//
//  LoginViewController.swift
//  iosProjekt
//
//  Created by five on 21/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController : UIViewController{
    let loginView = LoginView()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log in"
        self.view.addSubview(loginView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        loginView.closeButton.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func loginButtonTap(){
        
        guard
            let email = loginView.nameField.text,
            let password = loginView.passwordField.text,
            email.count > 0,
            password.count > 0
            else {
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Log In Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                //user logged in
                //show citiesVC
                let mainTabBarViewController = MainTabBarViewController()
                self.present(mainTabBarViewController, animated: true, completion: nil)
            }
        }
        
    }
    @objc
    func signUpButtonTap(){
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true, completion: nil)
    }
    
    @objc
    func closeButtonTap(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

