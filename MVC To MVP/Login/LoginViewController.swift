//
//  ViewController.swift
//  MVC To MVP
//
//  Created by Youssef on 8/9/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginUserProtocol {
    
    func login(phone: String?, password: String?) {
        do {
            let phone = try Validator.validatePhone(with: phone)
            let password = try Validator.validatePassword(with: password)
            
            let parameters = [
                "mobile": phone,
                "password": password,
                ]
            
            Network.shared.getData(UserModel.self, url: URLs.userSignin, parameters: parameters, method: .post) {[weak self] (err, data) in
                if let data = data, let userdata = data.data {
                    AuthService.instance.setUserDefaults(user: userdata)
                    // self?.present(UINavigationController(rootViewController: HomeTabBarController()), animated: true, completion: nil)
                } else if let err = err {
                    self?.showAlert(message: err)
                }
            }
        } catch let error as ValidatorError {
            showAlert(message: error.associatedMessage)
        } catch { }
    }

    let mainView = LoginView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

