//
//  Alert.swift
//  MVC To MVP
//
//  Created by Youssef on 8/9/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? = "", message: String?, selfDismissing: Bool = true, time: TimeInterval = 1) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.view.alpha = 0.3
        
        if !selfDismissing {
            alert.addAction(UIAlertAction(title: "Ok".localize, style: .cancel, handler: nil))
        }
        
        present(alert, animated: true)
        
        if selfDismissing {
            Timer.scheduledTimer(withTimeInterval: time, repeats: false) { t in
                t.invalidate()
                alert.dismiss(animated: true)
            }
        }
    }

}
