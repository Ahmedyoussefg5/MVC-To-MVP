//
//  AppDelegate.swift
//  MVC To MVP
//
//  Created by Youssef on 8/9/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        
        window?.rootViewController = LoginViewController()
        return true
    }
}
