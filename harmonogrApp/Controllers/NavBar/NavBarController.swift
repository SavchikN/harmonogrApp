//
//  NavBarController.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 11/06/2023.
//

import UIKit

class NavBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(ciColor: .black),
            .font: UIFont(name: "Avenir Next", size: 25)
        ]
        
        navigationBar.addBottomBorder(with: UIColor(red: 0.91, green: 0.93, blue: 0.94, alpha: 1.00), height: 1)
    }
}
