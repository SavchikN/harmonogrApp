//
//  PopupViewController.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 06/08/2023.
//

import UIKit
import SnapKit

class PopupViewController: UIViewController {
    
    let descriptionView = DescriptionView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
//        view.backgroundColor = .clear
        view.addSubview(descriptionView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        descriptionView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(400)
            make.width.equalTo(300)
        }
    }
}


