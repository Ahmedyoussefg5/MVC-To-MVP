//
//  LoginView.swift
//  MVC To MVP
//
//  Created by Youssef on 8/9/19.
//  Copyright © 2019 Youssef. All rights reserved.
//

import UIKit

protocol LoginUserProtocol: class {
    func login(phone: String?, password: String?)
}

class LoginView: UIView {
    
    private let phoneTextField = UITextField()
    private let passTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layoutView()
        setTargets()
        setupSubViews()
    }
    
    private func layoutView() {
        let stack = VStack([
            phoneTextField.withHeight(40),
            passTextField.withHeight(40),
            UIView().withHeight(30),
            loginButton.withHeight(40),
            ], spacing: 10, alignment: .fill, distribution: .fillProportionally)
        
        addSubview(stack)
        stack.widthAnchorWithMultiplier(multiplier: 0.9)
        stack.centerYInSuperview()
        stack.centerXInSuperview()
    }
    
    private func setupSubViews() {
        phoneTextField.layer.borderColor = UIColor.gray.cgColor
        phoneTextField.layer.borderWidth = 1
        phoneTextField.placeholder = "Phone Number"
        phoneTextField.layer.cornerRadius = 3

        passTextField.layer.borderColor = UIColor.gray.cgColor
        passTextField.layer.borderWidth = 1
        passTextField.placeholder = "Password"
        passTextField.isSecureTextEntry = true
        passTextField.layer.cornerRadius = 3
        
        loginButton.backgroundColor = .green
        loginButton.setTitle("Login", for: .normal)
        passTextField.layer.cornerRadius = 9
    }
    
    weak var delegate: LoginUserProtocol?
    
    func setTargets() {
        loginButton.addTarget {[weak self] in
            self?.delegate?.login(phone: self?.phoneTextField.text, password: self?.passTextField.text)
        }
    }
}
