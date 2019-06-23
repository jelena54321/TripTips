//
//  SignUpViewController.swift
//  iosProjekt
//
//  Created by five on 21/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController : UIViewController {
    let signUpView = SignUpView()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(signUpView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        signUpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            signUpView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            signUpView.topAnchor.constraint(equalTo: self.view.topAnchor),
            signUpView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        signUpView.closeButton.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
        signUpView.signUpButton.addTarget(self, action: #selector(signUpButtonTap), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        signUpView.emailField.layer.addSublayer({
            let border = CALayer()
            border.frame = CGRect(
                x: 0,
                y: signUpView.emailField.bounds.height - 1,
                width: signUpView.emailField.bounds.width,
                height: 1
            )
            border.backgroundColor = UIColor.lightGray.cgColor
            return border
        }())
        
        signUpView.passwordField.layer.addSublayer({
            let border = CALayer()
            border.frame = CGRect(
                x: 0,
                y: signUpView.passwordField.bounds.height - 1,
                width: signUpView.passwordField.bounds.width,
                height: 1
            )
            border.backgroundColor = UIColor.lightGray.cgColor
            return border
        }())
        
        signUpView.usernameField.layer.addSublayer({
            let border = CALayer()
            border.frame = CGRect(
                x: 0,
                y: signUpView.usernameField.bounds.height - 1,
                width: signUpView.usernameField.bounds.width,
                height: 1
            )
            border.backgroundColor = UIColor.lightGray.cgColor
            return border
        }())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func closeButtonTap(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc
    func signUpButtonTap(){
        guard
            let email = signUpView.emailField.text,
            let password = signUpView.passwordField.text,
            let username = signUpView.usernameField.text,
            email.count > 0,
            password.count > 0,
            username.count > 0
            else {
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(title: "Sign Up Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                //user created
                
                //set username to user
                guard let uid = user?.user.uid else {
                    return
                }
                Database.database().reference().child("users").child(uid).setValue(
                    [
                        "username": username,
                        "email": email
                    ]
                )
            }
        }
    }
}
