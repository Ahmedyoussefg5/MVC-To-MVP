//
//  Network.swift
//  Home bride
//
//  Created by Youssef on 4/26/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Alamofire
import SwiftyJSON

class Network {
    
    private init() {
        
    }
    
    static let shared = Network()
    
    func getData<T: Codable>(_ decoder: T.Type, url: String, parameters: [String: Any]?, method: HTTPMethod, complation: ((_ error: String?,_ data: T?) -> Void)? = nil) {
        
        var header = ["X-localization": "en",
            "os": "ios"
        ]
        if let userToken = AuthService.instance.authToken {
            header["Authorization"] = "Bearer \(userToken)"
        }
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                guard let complation = complation else { return }
                
                switch response.result {
                case .failure(let error):
                    debugPrint("failure", error)
                    if error.localizedDescription.contains("JSON") {
                        complation("Server Error.".localize, nil)
                        return
                    }
                    complation(error.localizedDescription, nil)
                case .success(_):
                    guard let responseData = response.data else {
                        complation(response.error?.localizedDescription ?? "Error".localize, nil)
                        return
                    }
                    
                    print("""
                        Resopnse JSON For \(url) With Method: \(method.rawValue) is:
                        \(JSON(response.value ?? [:]))
                        """)
                    
                    do {
                        let data = try JSONDecoder.decodeFromData(T.self, data: responseData)
                        complation(nil, data)
                    } catch let error {
                        complation("Server Error.".localize, nil)
                        debugPrint(error)
                    }
                }
        }
    }    
}
