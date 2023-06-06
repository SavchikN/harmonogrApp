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
    
//    private let loginButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("LogIn", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 20)
//        button.backgroundColor = .clear
//        button.layer.borderWidth = 1
//        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        button.layer.cornerRadius = 20
//        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
//        return button
//    }()
//
//    private let forgotButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Forgot login or password?", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 15)
//        button.addTarget(self, action: #selector(forgotButtonPressed), for: .touchUpInside)
//        return button
//    }()
    
//    private let signUpTitle: UILabel = {
//        let label = UILabel()
//        label.text = "Don't Have An Account?"
//        label.font = UIFont(name: "Avenir Next", size: 15)
//        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        return label
//    }()
//
//    private let signUpButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = .clear
//        button.setTitle("SignUp", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 15)
//        button.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
//        return button
//    }()
    
    let loginView = LoginView()
    let loginType = LoginTypeView()
    let signUpView = SignUpView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpView.isHidden = true
        
        setupViews()
        setConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(welcomeLabel)
        view.addSubview(loginView)
        view.addSubview(loginType)
        view.addSubview(signUpView)
    }
    
    func updateUI(_ view: UIView, hidden: Bool) {
        view.isHidden = hidden
    }
}

extension LoginViewController {
    @objc func loginTypeButtonPressed() {
        loginType.updateButtonColor(loginColor: .blue, signUpColor: .gray)
        loginType.updateButtonFont(lgButton: "Medium", spButton: "Regular")
        updateUI(loginView, hidden: false)
        updateUI(signUpView, hidden: true)
    }
    
    @objc func signUpTypeButtonPressed() {
        loginType.updateButtonColor(loginColor: .gray, signUpColor: .blue)
        loginType.updateButtonFont(lgButton: "Regular", spButton: "Medium")
        updateUI(loginView, hidden: true)
        updateUI(signUpView, hidden: false)
    }
    
    @objc func loginButtonPressed() {
        print("login")
    }
    
    @objc func forgotButtonPressed() {
        print("K")
    }
    
    @objc func signUpButtonPressed() {
        let firstVC = LoginViewController()
        let secondVC = OnboardingViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

extension LoginViewController {
    private func setConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(120)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        loginType.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).inset(-5)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(250)
            make.height.equalTo(70)
        }
        
        loginView.snp.makeConstraints { make in
            make.top.equalTo(loginType.snp.bottom).inset(30)
            make.leading.equalTo(view.snp.leading).inset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
            make.height.equalTo(250)
        }
        
        signUpView.snp.makeConstraints { make in
            make.top.equalTo(loginType.snp.bottom).inset(-10)
            make.leading.equalTo(view.snp.leading).inset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
            make.height.equalTo(350)
        }
    }
}
