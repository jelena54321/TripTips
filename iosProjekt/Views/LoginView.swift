//
//  LoginView.swift
//  iosProjekt
//
//  Created by five on 21/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit
import Foundation


class LoginView: UIView {
    
    let fieldsContainer = UIView()
    let nameField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton()
    let closeButton = UIButton()

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
        fieldsContainer.addSubview(nameField)
        fieldsContainer.addSubview(passwordField)
        fieldsContainer.addSubview(loginButton)
    }
    
    func styleSubviews(){
        self.backgroundColor = .white
        
        let defaultFont = UIFont(name: "Montserrat-Thin", size: 20)
    
        nameField.font = defaultFont
        nameField.textColor = .darkGray
        nameField.placeholder = "Name"
        nameField.setLeftPaddingPoints(10)
        //temporary
        nameField.text = "user@mail.com"
        
        passwordField.font = defaultFont
        passwordField.textColor = .darkGray
        passwordField.placeholder = "Password"
        passwordField.isSecureTextEntry = true
        passwordField.setLeftPaddingPoints(10)
        //temporary
        passwordField.text = "123456"

        loginButton.backgroundColor = UIColor.triptipsBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.cornerRadius = 22.5
        loginButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
    
        closeButton.setTitle("✖️", for: .normal)
    }
    
    func positionSubviews() {
        fieldsContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fieldsContainer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30.0),
            fieldsContainer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30.0),
            fieldsContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: fieldsContainer.topAnchor),
            nameField.leftAnchor.constraint(equalTo: fieldsContainer.leftAnchor),
            nameField.rightAnchor.constraint(equalTo: fieldsContainer.rightAnchor),
            nameField.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 30.0),
            passwordField.leftAnchor.constraint(equalTo: fieldsContainer.leftAnchor),
            passwordField.rightAnchor.constraint(equalTo: fieldsContainer.rightAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 40.0),
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 60.0),
            loginButton.leftAnchor.constraint(equalTo: fieldsContainer.leftAnchor),
            loginButton.rightAnchor.constraint(equalTo: fieldsContainer.rightAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.bottomAnchor.constraint(equalTo: fieldsContainer.bottomAnchor)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50)
        ])
    }
}


