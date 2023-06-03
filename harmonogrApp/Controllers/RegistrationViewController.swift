//
//  RegistrationViewController.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 09/05/2023.
//

import UIKit
import SnapKit
import FirebaseCore
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SignUP"
        label.font = UIFont(name: "Avenir Next Medium", size: 30)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your email adress:"
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a password:"
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let repeatPassword: UILabel = {
        let label = UILabel()
        label.text = "Repeat password:"
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.font = UIFont(name: "Avenir Next", size: 20)
        textField.placeholder = "Your name"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 20)
        button.layer.cornerRadius = 20
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let loginView = LoginView()
    let passwordView = PasswordView()
    let repeatPV = RepeatPasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmButton.isEnabled = true
        confirmButton.setTitleColor(.gray, for: .normal)
        setDelegates()
        setupViews()
        setConstraints()
    }
    
    func setDelegates() {
        loginView.loginTextField.delegate = self
        passwordView.passwordTextField.delegate = self
        repeatPV.passwordTextField.delegate = self
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(loginView)
        view.addSubview(passwordView)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(repeatPassword)
        view.addSubview(repeatPV)
        view.addSubview(confirmButton)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
    }
    
    @objc func confirmButtonPressed() {
       
    }
}

extension RegistrationViewController: UITextFieldDelegate {
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        if let name = nameTextField.text, let login = loginView.loginTextField.text, let password = passwordView.passwordTextField.text, let repeatPass = repeatPV.passwordTextField.text, !name.isEmpty, !login.isEmpty, !password.isEmpty, !repeatPass.isEmpty {
//            confirmButton.isEnabled = true
//            confirmButton.setTitleColor(.blue, for: .normal)
//        } else {
//            confirmButton.isEnabled = false
//            confirmButton.setTitleColor(.gray, for: .normal)
//        }
//    }
}

extension RegistrationViewController {
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(50)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-40)
            make.leading.equalTo(view.snp.leading).inset(65)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-5)
            make.height.equalTo(40)
            make.width.equalTo(300)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).inset(-40)
            make.leading.equalTo(view.snp.leading).inset(65)
        }
        
        loginView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).inset(-5)
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).inset(10)
            make.leading.equalTo(view.snp.leading).inset(65)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).inset(-5)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
            make.width.equalTo(300)
        }
        
        repeatPassword.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).inset(10)
            make.leading.equalTo(view.snp.leading).inset(65)
        }
        
        repeatPV.snp.makeConstraints { make in
            make.top.equalTo(repeatPassword.snp.bottom).inset(-5)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(60)
            make.width.equalTo(300)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(repeatPV.snp.bottom).inset(-10)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
}
