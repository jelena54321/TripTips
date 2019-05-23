//
//  InitialViewController.swift
//  iosProjekt
//
//  Created by five on 22/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit


class InitialViewController : UIViewController{
    let initialView = InitialView()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(initialView)
        
        initialView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            initialView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            initialView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            initialView.topAnchor.constraint(equalTo: self.view.topAnchor),
            initialView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])

        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.initialView.logoImage.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height * 0.25)
            })
        }
        
        initialView.signupButton.addTarget(self, action: #selector(signupButtonTap), for: .touchUpInside)
        initialView.loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)

        
    }
    
    @objc
    func loginButtonTap(){
        DispatchQueue.main.async {
            let loginViewController = LoginViewController()
            self.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    
    @objc
    func signupButtonTap(){
        DispatchQueue.main.async {
            let signupViewController = SignUpViewController()
            self.navigationController?.pushViewController(signupViewController, animated: true)
        }
    }
}

