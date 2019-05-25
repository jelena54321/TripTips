//
//  CityCollectionViewCell.swift
//  iosProjekt
//
//  Created by five on 23/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class CityCollectionViewCell : UICollectionViewCell {
    let image = UIImageView()
    let nameLabel = UILabel()
    var city : City? = nil

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
        self.addSubview(image)
        self.addSubview(nameLabel)
    }
    
    func styleSubviews(){
        
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "Montserrat-Bold", size: 18)
        nameLabel.layer.shadowColor = UIColor.black.cgColor
        nameLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        nameLabel.layer.shadowRadius = 5
        nameLabel.layer.shadowOpacity = 0.2

    }
    
    func positionSubviews(){
        
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)])
    }
    
    override func prepareForReuse() {
        
        image.image = nil
        super.prepareForReuse()
    }
}




