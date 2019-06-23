//
//  TripPropertyView.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 21/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class TripPropertyView: UIView {
    
    private let propertyLabel: UILabel = {
        let whereToLabel = UILabel()
        whereToLabel.translatesAutoresizingMaskIntoConstraints = false
        return whereToLabel
    }()
    
    private let propertyIcon: UIImageView = {
        let whereToIcon = UIImageView()
        whereToIcon.translatesAutoresizingMaskIntoConstraints = false
        return whereToIcon
    }()
    
    private let propertyValue: UILabel = {
        let whereToValue = UILabel()
        whereToValue.translatesAutoresizingMaskIntoConstraints = false
        return whereToValue
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setProperty(property: String) {
        propertyLabel.text = property
        propertyLabel.textAlignment = .right
    }
    
    func setPropertyIcon(image: UIImage) {
        propertyIcon.image = image
    }
    
    func setPropertyValue(value: String) {
        propertyValue.text = value
        propertyValue.textAlignment = .left
    }
    
    private func setUpUI() {
        propertyLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        
        addSubview(propertyLabel)
        NSLayoutConstraint.activate([
            propertyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            propertyLabel.topAnchor.constraint(equalTo: self.topAnchor),
            propertyLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            propertyLabel.widthAnchor.constraint(equalToConstant: 100.0)
        ])
        
        addSubview(propertyIcon)
        NSLayoutConstraint.activate([
            propertyIcon.leadingAnchor.constraint(equalTo: propertyLabel.trailingAnchor, constant: 20.0),
            propertyIcon.widthAnchor.constraint(equalToConstant: 20.0),
            propertyIcon.heightAnchor.constraint(equalToConstant: 20.0),
            propertyIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        propertyValue.font = UIFont(name: "Montserrat-Bold", size: 14)
        
        addSubview(propertyValue)
        NSLayoutConstraint.activate([
            propertyValue.leadingAnchor.constraint(equalTo: propertyIcon.trailingAnchor, constant: 20.0),
            propertyValue.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            propertyValue.topAnchor.constraint(equalTo: self.topAnchor),
            propertyValue.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
