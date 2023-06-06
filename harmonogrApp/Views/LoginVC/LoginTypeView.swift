//
//  LoginTypeView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 06/06/2023.
//

import UIKit
import SnapKit

class LoginTypeView: UIView {
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LogIn", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 30)
        button.addTarget(nil, action: #selector(LoginViewController.loginTypeButtonPressed), for: .touchUpInside)
//        button.backgroundColor = .purple
        return button
    }()
    
    private let slashChar: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.font = UIFont(name: "Avenir Next Medium", size: 30)
        label.textColor = .black
//        label.backgroundColor = .gray
        return label
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 30)
        button.addTarget(nil, action: #selector(LoginViewController.signUpTypeButtonPressed), for: .touchUpInside)
//        button.backgroundColor = .green
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = 5.gray
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(loginButton)
        addSubview(slashChar)
        addSubview(signUpButton)
    }
}

extension LoginTypeView {
    public func updateButtonColor(loginColor: UIColor, signUpColor: UIColor) {
        loginButton.setTitleColor(loginColor, for: .normal)
        signUpButton.setTitleColor(signUpColor, for: .normal)
    }
    
    public func updateButtonFont(lgButton: String, spButton: String) {
        loginButton.titleLabel?.font = UIFont(name: "Avenir Next \(lgButton)", size: 30)
        signUpButton.titleLabel?.font = UIFont(name: "Avenir Next \(spButton)", size: 30)
    }
}

extension LoginTypeView {
    private func setConstraints() {
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(0)
            make.leading.equalTo(snp.leading).inset(0)
            make.width.equalTo(110)
            make.height.equalTo(70)
        }
        
        slashChar.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(0)
            make.leading.equalTo(loginButton.snp.trailing).inset(3)
            make.width.equalTo(15)
            make.height.equalTo(70)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(0)
            make.leading.equalTo(slashChar.snp.trailing).inset(-6)
            make.width.equalTo(110)
            make.height.equalTo(70)
        }
    }
}
