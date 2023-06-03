//
//  PageImageView.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 03/06/2023.
//

import UIKit
import SnapKit

class PageImageView: UIView {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "img")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(imageView)
    }
}

extension PageImageView {
    private func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).inset(5)
            make.leading.equalTo(snp.leading).inset(5)
            make.trailing.equalTo(snp.trailing).inset(5)
            make.centerY.equalTo(snp.centerY)
        }
    }
}
