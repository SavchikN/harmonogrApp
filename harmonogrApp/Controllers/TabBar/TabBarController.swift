//
//  TabBarController.swift
//  harmonogrApp
//
//  Created by Nikita Savchik on 11/06/2023.
//

import UIKit
import SnapKit

enum Tabs: Int {
    case main
    case about
}

class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        navigationItem.hidesBackButton = true
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inactive
        tabBar.backgroundColor = .white

        
        tabBar.layer.borderColor = Resources.Colors.separator.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let mainViewController = MainViewController()
        let aboutViewController = AboutViewController()
        
        let mainNavigation = NavBarController(rootViewController: mainViewController)
        let aboutNavigation = NavBarController(rootViewController: aboutViewController)
        
        mainNavigation.tabBarItem = UITabBarItem(
            title: "Main",
            image: UIImage(systemName: "house"),
            tag: Tabs.main.rawValue
        )
        
        aboutNavigation.tabBarItem = UITabBarItem(
            title: "About Me",
            image: UIImage(systemName: "person"),
            tag: Tabs.about.rawValue
        )
        
        setViewControllers([
            mainNavigation,
            aboutNavigation
        ], animated: false)
    }
}
