//
//  OnboardingView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 01/06/2023.
//

import UIKit
import SnapKit

class OnboardingView: UIView {
    
    private let pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Medium", size: 30)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let pageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start!", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 23)
        button.layer.cornerRadius = 20
        button.isHidden = true
        button.addTarget(nil, action: #selector(OnboardingViewController.nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let pageImageView = PageImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(pageLabel)
        addSubview(pageImageView)
        addSubview(pageDescriptionLabel)
        addSubview(nextButton)
    }
}

extension OnboardingView {
    public func setPageLabelText(text: String) {
        pageLabel.text = text
    }
    
    public func setPageLabelTransform(transform: CGAffineTransform) {
        pageLabel.transform = transform
    }
    
    public func setPageDescriptionLabelText(text: String) {
        pageDescriptionLabel.text = text
    }
    
    public func setPageDescriptionTransform(transform: CGAffineTransform) {
        pageDescriptionLabel.transform = transform
    }
    
    public func setPageImage(image: UIImage) {
        pageImageView.imageView.image = image
    }
    
    public func activateButton(active: Bool) {
        nextButton.isHidden = active
    }
}

extension OnboardingView {
    private func setConstraints() {
        pageImageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(30)
            make.leading.equalTo(snp.leading).inset(20)
            make.trailing.equalTo(snp.trailing).inset(20)
            make.height.equalTo(400)
            make.width.equalTo(300)
        }
        
        pageLabel.snp.makeConstraints { make in
            make.top.equalTo(pageImageView.snp.bottom).inset(15)
            make.leading.equalTo(snp.leading).inset(30)
            make.trailing.equalTo(snp.trailing).inset(30)
            make.height.equalTo(100)
        }
        
        pageDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(pageLabel.snp.bottom).inset(10)
            make.leading.equalTo(snp.leading).inset(30)
            make.trailing.equalTo(snp.trailing).inset(30)
            make.height.equalTo(70)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(pageDescriptionLabel.snp.bottom).inset(-30)
            make.centerX.equalTo(snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
}
