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

        let searchViewController = SearchViewController()
        let searchNavigationController = UINavigationController(
            rootViewController: searchViewController
        )
        searchViewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(named: "searchIcon.png"),
            tag: 0
        )
        
        let profileViewController = ProfileViewController(
            profileViewModel: ProfileViewModel()
        )
        let profileNavigationController = UINavigationController(
            rootViewController: profileViewController
        )
        profileViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "profileIcon.png"),
            tag: 1
        )
        
        let tripsViewController = UINavigationController(
            rootViewController: AddTripsViewController()
        )
        tripsViewController.tabBarItem = UITabBarItem(
            title: "Trips",
            image: UIImage(named: "tripsIcon.png"),
            tag: 2
        )
        
        let tabBarList = [
            searchNavigationController,
            profileNavigationController,
            tripsViewController
        ]
        viewControllers = tabBarList
    }
}
