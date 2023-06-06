//
//  SignUpView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 06/06/2023.
//

import UIKit
import SnapKit

class SignUpView: UIView {
    
    private let nameTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your name"
        textField.textAlignment = .center
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.smartDashesType = .no
        textField.smartQuotesType = .no
        textField.smartInsertDeleteType = .no
        textField.font = UIFont(name: "Avenir Next", size: 20)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 20)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 20
        button.addTarget(nil, action: #selector(LoginViewController.signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let loginTFView = LoginTFView()
    let passwordView = PasswordView()
    let repeatPassword = RepeatPasswordView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(nameTF)
        addSubview(signUpButton)
        addSubview(loginTFView)
        addSubview(passwordView)
        addSubview(repeatPassword)
    }
}

extension SignUpView {
    private func setConstraints() {
        nameTF.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(0)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        loginTFView.snp.makeConstraints { make in
            make.top.equalTo(nameTF.snp.bottom).inset(-15)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(loginTFView.snp.bottom).inset(-15)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        repeatPassword.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).inset(-15)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(repeatPassword.snp.bottom).inset(-25)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
}
