//
//  TitleView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 12/07/2023.
//

import UIKit
import SnapKit

class TitleView: UIView {
    
    private let titleImage: UILabel = {
        let title = UILabel()
        title.text = "🤷‍♂️"
        title.font = UIFont(name: "Avenir Next", size: 35)
        return title
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "You have no tasks for today!"
        titleLabel.font = UIFont(name: "Avenir Next Medium", size: 20)
        titleLabel.textColor = .black
        return titleLabel
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
        
//        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.1942259934)
        addSubview(titleImage)
        addSubview(titleLabel)
    }
}

extension TitleView {
    private func setConstraints() {
        titleImage.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(20)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImage.snp.bottom).inset(-10)
            make.centerX.equalTo(snp.centerX)
        }
    }
}
