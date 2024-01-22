//
//  CommsSession.swift
//  pokedex
//
//  Created by Lee Wilson on 22/01/2024.
//

import Foundation
import Combine

protocol CommsSession: AnyObject {
    func request<T>(_ type: T.Type, _ request: Request) -> AnyPublisher<T, Error> where T: Decodable
}

class CommsSessionImpl: NSObject, CommsSession, URLSessionDelegate {
    var urlSession: URLSession!

    init(configuration: URLSessionConfiguration = .default) {
        super.init()
        self.urlSession = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }

    func request<T>(_ type: T.Type, _ request: Request) -> AnyPublisher<T, Error> where T: Decodable {
        return build(request: request)
            .flatMap { urlRequest -> AnyPublisher<Data, Error> in
                self.execute(request: urlRequest)
            }
            .flatMap { data -> AnyPublisher<T, Error> in
                request.decodeResponse(T.self, from: data)
            }
            .eraseToAnyPublisher()
    }

    private func build(request: Request) -> AnyPublisher<URLRequest, Error> {
        return request.build()
            .flatMap { urlRequest -> AnyPublisher<URLRequest, Error> in
                return Future<URLRequest, Error> { promise in
                    return promise(.success(urlRequest))
                }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    private func execute(request: URLRequest) -> AnyPublisher<Data, Error> {
        urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response in

                guard
                    let httpResponse = response as? HTTPURLResponse
                else {
                    throw ApiError.generalNetworkError
                }

                if self.isSuccess(code: httpResponse.statusCode) {
                    return data
                } else {
                    throw HTTPError(code: httpResponse.statusCode, data: data)
                }
            }
            .eraseToAnyPublisher()
    }

    private func isSuccess(code: Int) -> Bool {
        switch code {
        case 200, 201, 202, 204, 302:
            return true
        default:
            return false
        }
    }
}
