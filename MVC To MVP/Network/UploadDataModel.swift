//
//  UploadDataModel.swift
//  Aryaf
//
//  Created by Youssef on 7/24/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

struct UploadData {
    let data: Data
    let fileName: String
    let mimeType: String
    let name: String
    
    init(data: Data,
         fileName: String = "image.jpeg",
         mimeType: String = "image/jpeg",
         name: String = "image") {
        
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
        self.name = name
    }
}
