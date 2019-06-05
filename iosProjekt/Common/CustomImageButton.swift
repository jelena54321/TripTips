//
//  CustomImageButton.swift
//  iosProjekt
//
//  Created by five on 24/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class CustomImageButton : UIButton {
    
    let backgroundImage = UIImageView()
    let nameLabel = UILabel()
    var refName : String? = nil
    
    
    init(image: UIImage, title: String, refName: String) {
        self.refName = refName
        super.init(frame: .zero)
        setupView(image: image, title: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(image: UIImage, title: String) {
        
        //add subviews
        self.addSubview(backgroundImage)
        backgroundImage.addSubview(nameLabel)
        
        
        //style
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        
        backgroundImage.image = image
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.cornerRadius = 10
        
        nameLabel.text = title
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "Montserrat-Bold", size: 15)
        nameLabel.clipsToBounds = false
        nameLabel.layer.shadowColor = UIColor.black.cgColor
        nameLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        nameLabel.layer.shadowRadius = 5
        nameLabel.layer.shadowOpacity = 0.4
        backgroundImage.bringSubviewToFront(nameLabel)
        
        //position
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)])
    }
    
    

}
