//
//  JSONCodable+.swift
//  Aryaf
//
//  Created by Youssef on 7/24/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

extension JSONDecoder {
    static func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}

extension JSONEncoder {
    static func newJSONEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
}

extension JSONDecoder {
    static func decodeFromData<U: Codable>(_ model: U.Type, data: Data) throws -> U {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(U.self, from: data)
        } catch let error {
            debugPrint(error)
            throw error
        }
    }
}
