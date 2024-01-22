//
//  JsonDecoder.swift
//  pokedex
//
//  Created by Lee Wilson on 22/01/2024.
//

import Foundation

class JsonDecoder {
    static func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        return try decoder.decode(type, from: data)
    }

    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.iso8601)
        return decoder
    }()
}

extension DateFormatter {

    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.locale = .en_US_POSIX
        formatter.timeZone = .utc
        return formatter
    }()
}

// swiftlint:disable identifier_name
extension Locale {
    static let en_US_POSIX = Locale(identifier: "en_US_POSIX")
}
// swiftlint:enable identifier_name

extension TimeZone {
    static let utc = TimeZone(abbreviation: "UTC")
}
