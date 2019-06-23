//
//  File.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 18/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class ProfileTableViewHeader: UIView {
    
    private let profileIcon: UIImageView = {
        let profileIcon = UIImageView()
        profileIcon.translatesAutoresizingMaskIntoConstraints = false
        return profileIcon
    }()
    
    private let profileLabel: UILabel = {
        let profileLabel = UILabel()
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        return profileLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    private func setUpUI() {
        backgroundColor = .white
        layer.cornerRadius = 15.0
        
        profileIcon.image = UIImage(named: "profile.png")
        
        addSubview(profileIcon)
        NSLayoutConstraint.activate([
            profileIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20.0),
            profileIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileIcon.heightAnchor.constraint(equalToConstant: 40.0),
            profileIcon.widthAnchor.constraint(equalToConstant: 40.0)
        ])
        
        profileLabel.font = UIFont(name: "Montserrat-Bold", size: 25)
        profileLabel.text = "Profile"
        
        addSubview(profileLabel)
        NSLayoutConstraint.activate([
            profileLabel.leftAnchor.constraint(equalTo: profileIcon.rightAnchor, constant: 20.0),
            profileLabel.widthAnchor.constraint(equalToConstant: 200.0),
            profileLabel.heightAnchor.constraint(equalToConstant: 40.0),
            profileLabel.centerYAnchor.constraint(equalTo: profileIcon.centerYAnchor)
        ])
    }
}
