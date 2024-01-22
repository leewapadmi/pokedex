//
//  BaseRequest.swift
//  pokedex
//
//  Created by Lee Wilson on 22/01/2024.
//

import Foundation
import Combine

protocol Request {
    func build() -> AnyPublisher<URLRequest, Error>
    func decodeResponse<T>(_ type: T.Type, from data: Data) -> AnyPublisher<T, Error> where T: Decodable
    func map(httpError: HTTPError) -> Error
    var requiresAuth: Bool { get }
}

enum Method {
    case get
    case post(Encodable)
    case put(Encodable)
}

enum ApiError : Error {
    case generalNetworkError
}

struct EncodableWrapper: Encodable {
    let encodable: Encodable

    func encode(to encoder: Encoder) throws {
        var wrapper = encoder.singleValueContainer()
        try encodable.encode(into: &wrapper)
    }
}

extension Encodable {
    func encode(into wrapper: inout SingleValueEncodingContainer) throws {
        try wrapper.encode(self)
    }
}

enum RequestError: Error {
    case buildError
    case mapError
    case parseError
}

struct ErrorDetails: Decodable, Equatable {
    let code: String
    let message: String
    let details: String
}

struct VoidRequest: Encodable {}
struct VoidResponse: Decodable, Equatable {}

class BaseRequestImpl {
    let method: Method
    let route: Route
    let params: [String: String]
    let headers: [String: String]
    let requiresAuth: Bool
    let forceRefresh: Bool

    init(route: Route,
         method: Method = .get,
         params: [String: String] = [:],
         headers: [String: String] = [:],
         forceRefresh: Bool = false,
         requiresAuth: Bool = true) {

        self.route = route
        self.method = method
        self.params = params
        self.headers = headers
        self.forceRefresh = forceRefresh
        self.requiresAuth = requiresAuth
    }

    func build() -> AnyPublisher<URLRequest, Error> {
        return Future<URLRequest, Error> { promise in
            guard var request = try? self.createRequest() else {
                promise(.failure(RequestError.buildError))
                return
            }

            request = self.addHeaders(request)
            request = self.addParams(request)

            if self.forceRefresh {
                request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            }

            promise(.success(request))
        }
        .eraseToAnyPublisher()
    }

    func createRequest() throws -> URLRequest? {
        var request: URLRequest?
        switch method {
        case .get:
            request = URLRequest(url: route.url)
            request?.httpMethod = "GET"
        case .post(let jsonEncodable):
            request = try encodeBody(url: route.url, body: jsonEncodable)
            request?.httpMethod = "POST"
        case .put(let jsonEncodable):
            request = try encodeBody(url: route.url, body: jsonEncodable)
            request?.httpMethod = "PUT"
        }

        return request
    }

    func addHeaders(_ request: URLRequest) -> URLRequest {
        var request = request
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        self.headers.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    func addParams(_ request: URLRequest) -> URLRequest {
        var request = request

        guard
            !params.isEmpty,
            let url = request.url,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        else { return request }

        components.queryItems = params.map {
            return URLQueryItem(name: $0.key, value: $0.value)
        }

        request.url = components.url
        return request
    }

    func encodeBody(url: URL, body: Encodable) throws -> URLRequest {
        var request = URLRequest(url: url)

        if body is VoidRequest {
            return request
        }

        let wrapper = EncodableWrapper(encodable: body)
        let jsonData = try JSONEncoder().encode(wrapper)

        request.httpBody = jsonData

        return request
    }
    
    func map(httpError: HTTPError) -> Error {
        return ApiError.generalNetworkError
    }

    func decodeError(from data: Data) -> ErrorDetails? {
        return nil
    }
}

struct HTTPError: Error {
    let code: Int
    let data: Data
}
