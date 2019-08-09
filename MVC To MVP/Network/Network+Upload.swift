//
//  Network+Upload.swift
//  Aryaf
//
//  Created by Youssef on 7/30/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension Network {
    func uploadDataToServerWith<T: Codable>(_ decoder: T.Type, data: [UploadData], url: String, method: HTTPMethod, parameters: [String: Any]?, progress: ((Progress) -> Void)? = nil, completion: ((_ error: String?,_ data: T?) -> Void)? = nil) {
        
        var header = ["X-localization": "en"]
        if let userToken = AuthService.instance.authToken {
            header["Authorization"] = "Bearer \(userToken)"
        }
        
        upload(multipartFormData: { (mal) in
            for image in data {
                mal.append(image.data, withName: image.name, fileName: image.fileName, mimeType: image.mimeType)
            }
            for (key, val) in parameters ?? [:] {
                mal.append("\(val)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: url, method: method, headers: header) { (response) in
            guard let completion = completion else { return }
            
            switch response {
            case .success(let uploadRequest, _, _):
                uploadRequest.responseData(completionHandler: {
                    guard let responseData = $0.data else {
                        completion($0.error?.localizedDescription ?? "Server Error.".localize, nil)
                        return
                    }
                    
                    print("""
                        Resopnse JSON For \(url) With Method: \(method.rawValue) is:
                        \(JSON(responseData))
                        """)
                    
                    do { let data = try JSONDecoder.decodeFromData(T.self, data: responseData)
                        completion(nil, data)
                    } catch let error {
                        completion("Server Error.".localize, nil)
                        debugPrint(error)
                    }
                })
            case .failure(let error):
                completion(error.localizedDescription, nil)
            }
        }
    }
    
}
