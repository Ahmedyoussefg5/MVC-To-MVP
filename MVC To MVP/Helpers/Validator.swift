//
//  Validiator.swift
//  Aryaf
//
//  Created by Youssef on 7/28/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

protocol ValidatorError: Error {
    var associatedMessage: String { get }
}

//protocol ValidatorProtocol: class {
//    func validateMail(with mail: String) throws -> String
//    func validatePassword(with password: String) throws -> String
//    func validateName(with name: String) throws -> String
//    func validate(with value: String, decription: String, count: Int) throws -> String
//    func validatePhone(with name: String) throws -> String
//}

class Validator {
    static func validateMail(with mail: String?) throws -> String {
        if let mail = mail {
            if mail.isEmpty {
                throw UserAuthentcationError.emptyMail
            } else if !mail.trimmedString.isEmail {
                throw UserAuthentcationError.invalidMail
            } else {
                return mail.trimmedString
            }
        } else {
            throw UserAuthentcationError.emptyMail
        }
    }
    
    static func validatePassword(with password: String?) throws -> String {
        if let password = password {
            if password.isEmpty {
                throw UserAuthentcationError.emptyPass
            } else if password.count < 6 {
                throw UserAuthentcationError.tooShortPass
            } else {
                return password
            }
        } else {
            throw UserAuthentcationError.emptyPass
        }
    }
    
    static func validateName(with name: String?) throws -> String {
        if let name = name {
            if name.isEmpty {
                throw UserAuthentcationError.emptyName
            } else if name.count < 6 {
                throw UserAuthentcationError.tooShortName
            } else {
                return name
            }
        } else {
            throw UserAuthentcationError.emptyName
        }
    }
    
    static func validatePhone(with phone: String?) throws -> String {
        if let phone = phone {
            if phone.isEmpty {
                throw UserAuthentcationError.emptyPhone
            } else if !phone.isInt {
                throw UserAuthentcationError.invalidPhone
            } else if phone.count < 6 {
                throw UserAuthentcationError.tooShortPhone
            } else {
                return phone
            }
        } else {
            throw UserAuthentcationError.emptyPhone
        }
    }
    
    static func validate(with value: String?, decription: String, count: Int = 1) throws -> String {
        if let value = value {
            if value.isEmpty {
                throw UserAuthentcationError.emptyField(decription: decription)
            } else if value.count < count {
                throw UserAuthentcationError.tooShortField(decription: decription, count: count)
            } else {
                return value
            }
        } else {
            throw UserAuthentcationError.emptyField(decription: decription)
        }
    }
    
    static func validate(with value: Int?, decription: String, count: Int = 1) throws -> Int {
        if let value = value {
            return value
        } else {
            throw UserAuthentcationError.emptyField(decription: decription)
        }
    }
    
    static func validate(with value: [Int]?, decription: String, count: Int = 1) throws -> [Int] {
        if let value = value {
            if value.count < count {
                throw UserAuthentcationError.tooShortField(decription: decription, count: count)
            }
            return value
        } else {
            throw UserAuthentcationError.emptyField(decription: decription)
        }
    }
    
    static func validateTwoPasswords(password: String?, confirmPassword: String?) throws  -> String {
        if let password = password, let confirmPassword = confirmPassword {
            if password.isEmpty || confirmPassword.isEmpty {
                throw UserAuthentcationError.emptyPass
            } else if password.count < 6 {
                throw UserAuthentcationError.tooShortPass
            } else if confirmPassword != password {
                throw UserAuthentcationError.notTheSamePasswords
            } else {
                return password
            }
        } else {
            throw UserAuthentcationError.emptyPass
        }
    }
    
    static func validateLocation(lat: String?, lng: String?) throws  -> (lat: String, lng: String) {
        if let lat = lat, let lng = lng, !lat.isEmpty, !lng.isEmpty {
            return (lat: lat, lng: lng)
        } else {
            throw UserAuthentcationError.selectLocation
        }
    }
    
    enum UserAuthentcationError: ValidatorError {
        
        case invalidMail
        case invalidPhone
        
        case tooShortName
        case tooShortPass
        case tooShortPhone
        
        case emptyName
        case emptyPass
        case emptyMail
        case emptyPhone
        
        case notTheSamePasswords
        
        case selectLocation
        
        case emptyField(decription: String)
        case tooShortField(decription: String, count: Int)
        
        internal var associatedMessage: String {
            var message = "Error"
            
            switch self {
            case .invalidMail:
                message = "Enter Your Valid E-mail."
            case .tooShortName:
                message = "Enter Your Full Name, Must Be At Least 6 Chars."
            case .tooShortPass:
                message = "Password Should Be At Least 6 Chars."
            case .emptyName:
                message = "Empty Name."
            case .emptyPass:
                message = "Please Enter Your Password."
            case .emptyMail:
                message = "Empty Mail!"
            case .emptyField(let decription):
                message = "Please Enter Valid \(decription)"
            case .tooShortField(let decription, let count):
                message = "Please Enter Valid \(decription), Must Be At least \(count)."
            case .tooShortPhone:
                message = "Enter Your Valid Phone Number, Must Be At Least 6 Nums."
            case .emptyPhone:
                message = "Enter Your Valid Phone Number."
            case .invalidPhone:
                message = "Your Phone Number Is Invalid."
            case .notTheSamePasswords:
                message = "Enter The Same Passord Twice."
            case .selectLocation:
                message = "Please Select Your Location."
            }
            return message.localize
        }
    }
}
