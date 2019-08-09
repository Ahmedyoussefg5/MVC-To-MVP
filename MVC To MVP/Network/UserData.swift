
import UIKit

class AuthService {
    
    static let instance = AuthService()
    
    private init () {
        
    }
    
    private let userDefault = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return userDefault.bool(forKey: "LoggedInKey")
        }
        set {
            userDefault.set(newValue, forKey: "LoggedInKey")
        }
    }
    
    var authToken: String? {
        get {
            return userDefault.value(forKey: "ApiTokenKey") as? String
        }
        set {
            userDefault.set(newValue, forKey: "ApiTokenKey")
        }
    }
    
    var userEmail: String? {
        get {
            return userDefault.value(forKey: "UserMailKey") as? String
        }
        set {
            userDefault.set(newValue, forKey: "UserMailKey")
        }
    }
    
    func setUserDefaults(user: UserData) {
        isLoggedIn = true
        authToken = user.jwt
        userEmail = user.email
    }
    
    private func removeUserDefaults()  {
        isLoggedIn = false
        authToken = nil
        userEmail = nil
    }
    
    func restartAppAndRemoveUserDefaults() {
        removeUserDefaults()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let window =  UIApplication.shared.keyWindow else { fatalError() }
//            window.rootViewController = UINavigationController(rootViewController: UserSelectionController())
            UIView.transition(with: window, duration: 1.0, options: .curveEaseIn, animations: nil, completion: nil)
        }
    }
    
    func transiteWithViewController(_ vc: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            guard let window =  UIApplication.shared.keyWindow else { fatalError() }
            window.rootViewController = UINavigationController(rootViewController: vc)
            UIView.transition(with: window, duration: 1.0, options: .transitionCurlUp, animations: nil, completion: nil)
        })
    }
}
