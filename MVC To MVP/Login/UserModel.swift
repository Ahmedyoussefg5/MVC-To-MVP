//
//  UserModel.swift
//  MVC To MVP
//
//  Created by Youssef on 8/9/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

struct UserModel: BaseCodable {
    var status: String
    var message: String?
    let data: UserData?
}

struct UserData: Codable {
    let id: Int?
    let name, mobile, email: String?
    let image: String?
    let type, jwt: String?
}
