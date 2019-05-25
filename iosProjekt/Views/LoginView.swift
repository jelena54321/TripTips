//
//  LoginView.swift
//  iosProjekt
//
//  Created by five on 21/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit
import Foundation


class LoginView: UIView{
    
    let nameField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let passwordField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
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
        self.addSubview(nameField)
        self.addSubview(passwordField)
        self.addSubview(loginButton)
        self.addSubview(closeButton)

    }
    
    func styleSubviews(){
        self.backgroundColor = .white

        nameField.placeholder = "Name"
        nameField.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        nameField.layer.cornerRadius = 10
        nameField.setLeftPaddingPoints(10)
        //temporary
        nameField.text = "User@mail.com"
        
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        passwordField.layer.cornerRadius = 10
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
    
    func positionSubviews(){
        nameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameField.heightAnchor.constraint(equalToConstant: 35),
            nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            passwordField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 35),
            passwordField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50)])
    }
}


