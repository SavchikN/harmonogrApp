//
//  RepeatPasswordView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 12/05/2023.
//

import UIKit
import SnapKit

class RepeatPasswordView: UIView {
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.textAlignment = .center
        password.font = UIFont(name: "Avenir Next", size: 20)
        password.isSecureTextEntry = true
        password.layer.borderWidth = 1
        password.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        password.layer.cornerRadius = 20
        return password
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(passwordTextField)
    }
}

extension RepeatPasswordView {
    private func setConstraints() {
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(0)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(40)
            make.width.equalTo(300)
        }
    }
}
