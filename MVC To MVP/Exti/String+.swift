//
//  String+.swift
//  MVC To MVP
//
//  Created by Youssef on 8/9/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import Foundation

extension String {
    var trimmedString: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var removeTags: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
    
    var filterAsURL: String {
        return self.replacingOccurrences(of: "\\", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
    
    var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.trimmedString)
    }
    
    var localize: String {
        return NSLocalizedString(self, comment: "Hello From String Extension")
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    var toInt: Int? {
        return Int(self)
    }
    
    var double: Double? {
        return Double(self)
    }
    
    var toIntUnwrapped: Int {
        return Int(self) ?? 0
    }

}
