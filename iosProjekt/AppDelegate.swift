//
//  AppDelegate.swift
//  iosProjekt
//
//  Created by five on 21/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        customizeAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        sleep(1)
        if let window = window {
            let initialViewController = MainTabBarViewController()
            navigationController = UINavigationController(rootViewController: initialViewController)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        FirebaseApp.configure()
        return true
    }
    
    
    func customizeAppearance() {
        UITabBar.appearance().tintColor = .black
    }
}
