//
//  CategoryMenuCell.swift
//  iosProjekt
//
//  Created by five on 24/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class CategoryMenuCell : UICollectionViewCell {
    
    let maskBackground = UIView()
    let gradient = UIImageView()
    let nameLabel = UILabel()
    let mainView = UIView()
    let separator = UIView()
    let descriptionLabel = UILabel()
    let stackViewLeft = UIStackView(arrangedSubviews: [
        CustomImageButton(image: UIImage(named: "restaurant.jpg")!, title: "Restaurants"),
        CustomImageButton(image: UIImage(named: "coffee.jpg")!, title: "Caffe bars"),
        ])
    
    let stackViewRight = UIStackView(arrangedSubviews: [
        CustomImageButton(image: UIImage(named: "museum.jpg")!, title: "Museums"),
        CustomImageButton(image: UIImage(named: "tour.jpg")!, title: "Tours"),
        ])
    
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
        self.addSubview(maskBackground)
        self.addSubview(gradient)
        self.addSubview(mainView)
        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        mainView.addSubview(stackViewLeft)
        mainView.addSubview(stackViewRight)
        mainView.addSubview(separator)
    }
    
    func styleSubviews(){
        maskBackground.backgroundColor = .white
        
        gradient.image = UIImage(named: "gradient.pdf")
        
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 10
        
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 5, height: 5)
        mainView.layer.shadowRadius = 5
        mainView.layer.shadowOpacity = 0.2
        
        nameLabel.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        descriptionLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.textColor = .gray
        
        separator.backgroundColor = .lightGray
        
        stackViewLeft.axis = .vertical
        stackViewLeft.spacing = 15
        stackViewLeft.distribution = .fillEqually
        
        stackViewRight.axis = .vertical
        stackViewRight.spacing = 15
        stackViewRight.distribution = .fillEqually
    }
    
    func positionSubviews(){
        
        
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 200),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
            ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20)
            ])
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 55),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: mainView.topAnchor, constant: 140)])
        
        gradient.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: self.topAnchor),
            gradient.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            gradient.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
        maskBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maskBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            maskBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 200),
            maskBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            maskBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 155),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20)])
        
        stackViewLeft.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewLeft.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 180),
            stackViewLeft.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            stackViewLeft.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 20),
            stackViewLeft.trailingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: -10)
            ])
        
        stackViewRight.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackViewRight.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 180),
            stackViewRight.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            stackViewRight.leadingAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 10),
            stackViewRight.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -20)
            ])
    }
}
