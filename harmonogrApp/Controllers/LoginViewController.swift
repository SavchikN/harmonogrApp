//
//  LoginViewController.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 07/05/2023.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.font = UIFont(name: "Avenir Next Medium", size: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LogIn", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 20)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let forgotButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot login or password?", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 15)
        button.addTarget(self, action: #selector(forgotButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let signUpTitle: UILabel = {
        let label = UILabel()
        label.text = "Don't Have An Account?"
        label.font = UIFont(name: "Avenir Next", size: 15)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 15)
        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let loginView = LoginView()
    let passwordView = PasswordView()
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = false
        loginButton.setTitleColor(.gray, for: .normal)
        setupViews()
        setDelegates()
        setConstraints()
    }
    
    func setDelegates() {
        loginView.loginTextField.delegate = self
        passwordView.passwordTextField.delegate = self
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(welcomeLabel)
        view.addSubview(loginView)
        view.addSubview(passwordView)
        view.addSubview(loginButton)
        view.addSubview(forgotButton)
        view.addSubview(signUpTitle)
        view.addSubview(signUpButton)
    }

    @objc func loginButtonPressed() {
        print(loginView.loginTextField.text!)
    }
    
    @objc func forgotButtonPressed() {
        print("tapp")
    }
    
    @objc func signUpButtonPressed() {
        let regVC = RegistrationViewController()
        let navController = UINavigationController(rootViewController: regVC)
        dismiss(animated: true, completion: nil)
        present(navController, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let login = loginView.loginTextField.text, let password = passwordView.passwordTextField.text, !login.isEmpty, !password.isEmpty {
            loginButton.isEnabled = true
            loginButton.setTitleColor(.blue, for: .normal)
        } else {
            loginButton.isEnabled = false
            loginButton.setTitleColor(.gray, for: .normal)
        }
    }
}

extension LoginViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension LoginViewController {
    private func setConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(120)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        loginView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).inset(-20)
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).inset(5)
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        forgotButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).inset(5)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotButton.snp.bottom).inset(-20)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        signUpTitle.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).inset(-10)
            make.leading.equalTo(view.snp.leading).inset(85)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).inset(-3)
            make.leading.equalTo(signUpTitle.snp.trailing).inset(-7)
        }
    }
}
