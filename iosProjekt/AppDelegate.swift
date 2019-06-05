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
        
        FirebaseApp.configure()

        customizeAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        sleep(1)
        if let window = window {
            let initialViewController = InitialViewController()
            navigationController = UINavigationController(rootViewController: initialViewController)
            
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        return true
    }
    
    func customizeAppearance() {
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        
        let attributes = [NSAttributedString.Key.font:  UIFont(name: "Helvetica-Bold", size: 0.1)!, NSAttributedString.Key.foregroundColor: UIColor.clear]
        
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        BarButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
        
        
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().backgroundColor = .white
        
        UITabBar.appearance().tintColor = .black
        
    }
}
