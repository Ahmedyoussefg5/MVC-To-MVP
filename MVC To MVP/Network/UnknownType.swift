//
//  UnknownType.swift
//  Aryaf
//
//  Created by Youssef on 7/24/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

enum UnknownType<S: Codable, F: Codable>: Codable {
    
    case integer(S)
    case string(F)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(S.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(F.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(UnknownType.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ID"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
