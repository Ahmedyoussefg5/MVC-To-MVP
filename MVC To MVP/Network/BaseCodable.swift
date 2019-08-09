//
//  BaseCodable.swift
//  Aryaf
//
//  Created by Youssef on 7/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

protocol BaseCodable: Codable {
    var status: String { get set }
    var message: String? { get set }
}

struct BaseModel: BaseCodable {
    var status: String
    var data: String?
    var message: String?
}
