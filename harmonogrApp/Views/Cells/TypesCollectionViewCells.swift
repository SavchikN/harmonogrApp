//
//  TypesCollectionViewCells.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 26/07/2023.
//

import UIKit
import SnapKit

class TypesCollectionViewCells: UICollectionViewCell {
    
    let typeColors = [#colorLiteral(red: 0.5393829942, green: 0.7509046197, blue: 0.2320667803, alpha: 1), #colorLiteral(red: 0.9972404838, green: 0.4982656837, blue: 0.01081676036, alpha: 1), #colorLiteral(red: 0.9916325212, green: 0.006866422482, blue: 0.0002546116593, alpha: 1)]
    
    let typeLabel: UILabel = {
        let type = UILabel()
        type.textColor = .black
        type.textAlignment = .center
        type.font = UIFont(name: "Avenir Next", size: 24)
        return type
    }()
    
    let typeImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    var index = 0
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 1.5
                layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                
                UIView.animate(withDuration: 0.2) {
                    self.backgroundColor = self.typeColors[self.index]
                }
                
                typeLabel.font = UIFont(name: "Avenir Next Medium", size: 24)
            } else {
                layer.borderWidth = 0.5
                backgroundColor = .white
                typeLabel.font = UIFont(name: "Avenir Next", size: 24)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.borderWidth = 0.5
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 10
        
        addSubview(typeLabel)
        addSubview(typeImage)
    }
}

extension TypesCollectionViewCells {
    private func setConstraints() {
        typeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(2)
            make.centerY.equalTo(snp.centerY)
        }
        
        typeImage.snp.makeConstraints { make in
            make.leading.equalTo(typeLabel.snp.trailing).inset(40)
            make.centerY.equalTo(snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(30)
        }
    }
}
