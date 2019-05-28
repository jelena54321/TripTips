//
//  MainTabBarViewController.swift
//  iosProjekt
//
//  Created by five on 22/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()

        //TODO: find appropriate icons
        let searchViewController = SearchViewController()
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let profileViewController = ProfileViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let plansViewController = UIViewController()
        plansViewController.view.backgroundColor = .red
        plansViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        let tabBarList = [searchNavigationController, profileNavigationController, plansViewController]
        viewControllers = tabBarList
    }
}
