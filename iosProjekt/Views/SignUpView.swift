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
    
    let fieldsContainer = UIView()
    let emailField = UITextField()
    let passwordField = UITextField()
    let usernameField = UITextField()
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
        self.addSubview(closeButton)
        self.addSubview(fieldsContainer)
        fieldsContainer.addSubview(emailField)
        fieldsContainer.addSubview(passwordField)
        fieldsContainer.addSubview(signUpButton)
        fieldsContainer.addSubview(usernameField)
    }
    
    func styleSubviews(){
        self.backgroundColor = .white
        
        let defaultFont = UIFont(name: "Montserrat-Thin", size: 20)
        
        emailField.font = defaultFont
        emailField.placeholder = "Email"
        emailField.layer.cornerRadius = 10
        emailField.setLeftPaddingPoints(10)
        
        passwordField.font = defaultFont
        passwordField.placeholder = "Password"
        passwordField.layer.cornerRadius = 10
        passwordField.isSecureTextEntry = true
        passwordField.setLeftPaddingPoints(10)
        
        usernameField.font = defaultFont
        usernameField.placeholder = "Username"
        usernameField.layer.cornerRadius = 10
        usernameField.setLeftPaddingPoints(10)
        
        signUpButton.backgroundColor = UIColor.triptipsBlue
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.setTitle("Log in", for: .normal)
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        signUpButton.layer.shadowRadius = 5
        signUpButton.layer.shadowOpacity = 0.2
        signUpButton.layer.cornerRadius = 22.5
        signUpButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        closeButton.setTitle("✖️", for: .normal)
    }
    
    func positionSubviews(){
        fieldsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fieldsContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30.0),
            fieldsContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30.0),
            fieldsContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: fieldsContainer.topAnchor),
            usernameField.heightAnchor.constraint(equalToConstant: 40.0),
            usernameField.leftAnchor.constraint(equalTo: fieldsContainer.leftAnchor),
            usernameField.rightAnchor.constraint(equalTo: fieldsContainer.rightAnchor)
        ])
        
        emailField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 30.0),
            emailField.heightAnchor.constraint(equalToConstant: 40.0),
            emailField.leftAnchor.constraint(equalTo: fieldsContainer.leftAnchor),
            emailField.rightAnchor.constraint(equalTo: fieldsContainer.rightAnchor)
        ])
        
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 30.0),
            passwordField.heightAnchor.constraint(equalToConstant: 40.0),
            passwordField.leftAnchor.constraint(equalTo: fieldsContainer.leftAnchor),
            passwordField.rightAnchor.constraint(equalTo: fieldsContainer.rightAnchor)
        ])
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 60.0),
            signUpButton.heightAnchor.constraint(equalToConstant: 40.0),
            signUpButton.leftAnchor.constraint(equalTo: fieldsContainer.leftAnchor),
            signUpButton.rightAnchor.constraint(equalTo: fieldsContainer.rightAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: fieldsContainer.bottomAnchor)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50)
        ])
    }
}
