//
//  DescriptionView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 06/08/2023.
//

import UIKit
import SnapKit

class DescriptionView: UIView {
    
    var dimmingView: UIView?
    
    var mainTitle: UILabel = {
        let title = UILabel()
        title.text = "Task Name"
        title.font = UIFont(name: "Avenir Next Medium", size: 25)
        title.textAlignment = .center
        return title
    }()
    
    var descriptionLabel: UILabel = {
        let description = UILabel()
        description.text = "Task Description"
        description.font = UIFont(name: "Avenir Next", size: 20)
        description.textAlignment = .center
        return description
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Medium", size: 20)
        button.backgroundColor = .clear
        button.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderWidth = 1
        setupSubviews(mainTitle, cancelButton, descriptionLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews(_ subview: UIView...) {
        subview.forEach { subview in
            addSubview(subview)
        }
    }
    
    private func dismissAnimated() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.dimmingView?.alpha = 0
        }) { _ in
            self.removeFromSuperview()
            self.dimmingView?.removeFromSuperview()
        }
    }
    
    func showAnimated(on parentViewController: MainViewController) {
        dimmingView = UIView(frame: parentViewController.view.bounds)
        dimmingView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dimmingView?.tag = 1001
        
        parentViewController.view.addSubview(dimmingView!)
        parentViewController.view.addSubview(self)
        
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: []) {
            self.alpha = 1
            self.transform = .identity
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        dimmingView?.addGestureRecognizer(tapGesture)
    }
}

extension DescriptionView {
    @objc func cancelButtonPressed() {
        dismissAnimated()
    }
    
    @objc private func tapGesture() {
        dismissAnimated()
    }
}

extension DescriptionView {
    private func setConstraints() {
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(10)
            make.leading.equalTo(snp.leading).inset(20)
            make.trailing.equalTo(snp.trailing).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).inset(-25)
            make.leading.equalTo(snp.leading).inset(20)
            make.trailing.equalTo(snp.trailing).inset(20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom).inset(20)
            make.leading.equalTo(snp.leading).inset(30)
            make.trailing.equalTo(snp.trailing).inset(30)
        }
    }
}

