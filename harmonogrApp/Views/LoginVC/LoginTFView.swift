//
//  LoginView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 07/05/2023.
//

import UIKit
import SnapKit

class LoginTFView: UIView {
    
    let loginTextField: UITextField = {
        let login = UITextField()
        login.placeholder = "E-mail"
        login.textAlignment = .center
        login.keyboardType = .emailAddress
        login.autocapitalizationType = .none
        login.autocorrectionType = .no
        login.smartDashesType = .no
        login.smartQuotesType = .no
        login.smartInsertDeleteType = .no
        login.font = UIFont(name: "Avenir Next", size: 20)
        login.layer.borderWidth = 1
        login.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        login.layer.cornerRadius = 20
        return login
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
        addSubview(loginTextField)
    }
}

extension LoginTFView {
    func setConstraints() {
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(0)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(40)
            make.width.equalTo(300)
        }
    }
}
