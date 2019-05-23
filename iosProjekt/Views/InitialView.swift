//
//  InitialView.swift
//  iosProjekt
//
//  Created by five on 22/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class InitialView : UIView {
    
    let backgroundImage = UIImageView()
    let logoImage = UIImageView()
    let loginButton = UIButton()
    let signupButton = UIButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    
    func setupView(){
        print("bok")
        self.addSubviews()
        self.styleSubviews()
        self.positionSubviews()
    }
    
    func addSubviews(){
        self.addSubview(backgroundImage)
        self.addSubview(logoImage)
        self.addSubview(loginButton)
        self.addSubview(signupButton)
    }
    
    func styleSubviews(){
        
        backgroundImage.image = UIImage(named: "background.png")
        backgroundImage.contentMode = .scaleAspectFill
        
        logoImage.image = UIImage(named: "triptipsLogo.pdf")
        logoImage.contentMode = .scaleAspectFit
        
        loginButton.backgroundColor = UIColor.triptipsBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.cornerRadius = 22.5
        loginButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)

        signupButton.backgroundColor = .white
        signupButton.setTitleColor(UIColor.triptipsBlue, for: .normal)
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        signupButton.layer.shadowColor = UIColor.black.cgColor
        signupButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        signupButton.layer.shadowRadius = 5
        signupButton.layer.shadowOpacity = 0.2
        signupButton.layer.cornerRadius = 22.5
    }
    
    func positionSubviews(){
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.centerYAnchor.constraint(greaterThanOrEqualTo: self.centerYAnchor),
            logoImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
            ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -115),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75)
            ])
        
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signupButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -180),
            signupButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signupButton.heightAnchor.constraint(equalToConstant: 45),
            signupButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75)
            ])
    }
}
