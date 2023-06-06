//
//  LoginView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 04/06/2023.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LogIn", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 20)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 20
        button.addTarget(nil, action: #selector(LoginViewController.loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let forgotButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot login or password?", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 15)
        button.addTarget(nil, action: #selector(LoginViewController.forgotButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let loginTFView = LoginTFView()
    let passwordTFView = PasswordView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setDelegates()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        loginButton.isEnabled = false
        loginButton.setTitleColor(.gray, for: .normal)
        
        addSubview(loginButton)
        addSubview(forgotButton)
        addSubview(loginTFView)
        addSubview(passwordTFView)
    }
    
    func setDelegates() {
        loginTFView.loginTextField.delegate = self
        passwordTFView.passwordTextField.delegate = self
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let login = loginTFView.loginTextField.text, let password = passwordTFView.passwordTextField.text, !login.isEmpty, !password.isEmpty {
            loginButton.isEnabled = true
            loginButton.setTitleColor(.blue, for: .normal)
        } else {
            loginButton.isEnabled = false
            loginButton.setTitleColor(.gray, for: .normal)
        }
    }
}

extension LoginView {
    private func setConstraints() {
        loginTFView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(40)
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.centerX.equalTo(snp.centerX)
        }
        
        passwordTFView.snp.makeConstraints { make in
            make.top.equalTo(loginTFView.snp.bottom).inset(5)
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.centerX.equalTo(snp.centerX)
        }
        
        forgotButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTFView.snp.bottom).inset(5)
            make.centerX.equalTo(snp.centerX)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotButton.snp.bottom).inset(-10)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
}

