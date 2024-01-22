//
//  JsonRequest.swift
//  pokedex
//
//  Created by Lee Wilson on 22/01/2024.
//

import Foundation
import Combine

class JSONRequest: BaseRequestImpl, Request {
    func decodeResponse<T>(_ type: T.Type, from data: Data) -> AnyPublisher<T, Error> where T: Decodable {
        return Future<T, Error> { promise in
            do {
                let decoded = try JsonDecoder.decode(type.self, from: data)
                promise(.success(decoded))
            } catch {
                promise(.failure(RequestError.parseError))
            }
        }
        .eraseToAnyPublisher()
    }
}
