//
//  SignUpView.swift
//  iosProjekt
//
//  Created by five on 21/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit
import Foundation


class SignUpView: UIView{
    
    let emailField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let passwordField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let usernameField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let closeButton = UIButton()
    let signUpButton = UIButton()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func setupView(){
        self.addSubviews()
        self.styleSubviews()
        self.positionSubviews()
    }
    
    func addSubviews(){
        self.addSubview(emailField)
        self.addSubview(passwordField)
        self.addSubview(signUpButton)
        self.addSubview(usernameField)
        self.addSubview(closeButton)
    }
    
    func styleSubviews(){
        self.backgroundColor = .white
        
        emailField.placeholder = "Email"
        emailField.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        emailField.layer.cornerRadius = 10
        emailField.setLeftPaddingPoints(10)
        
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        passwordField.layer.cornerRadius = 10
        passwordField.isSecureTextEntry = true
        passwordField.setLeftPaddingPoints(10)
        
        usernameField.placeholder = "Username"
        usernameField.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        usernameField.layer.cornerRadius = 10
        usernameField.setLeftPaddingPoints(10)
        
        signUpButton.backgroundColor = UIColor(red:1.00, green:0.89, blue:0.00, alpha:1.0)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        signUpButton.layer.shadowRadius = 5
        signUpButton.layer.shadowOpacity = 0.2
        signUpButton.layer.cornerRadius = 10
        
        closeButton.setTitle("✖️", for: .normal)
    }
    
    func positionSubviews(){
        
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            usernameField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            usernameField.heightAnchor.constraint(equalToConstant: 35),
            usernameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            emailField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 35),
            emailField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            passwordField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 35),
            passwordField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 250),
            signUpButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 45),
            signUpButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50)])
    }
}



