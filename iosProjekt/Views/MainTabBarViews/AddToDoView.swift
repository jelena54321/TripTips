//
//  AddToDoView.swift
//  iosProjekt
//
//  Created by five on 05/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class AddToDoView : UIView {
    
    let imageView = UIImageView()
    let imageField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let nameField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let descriptionField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let addButton = UIButton()
    let titleLabel = UILabel()
    
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
        self.addSubview(imageView)
        self.addSubview(imageField)
        self.addSubview(nameField)
        self.addSubview(descriptionField)
        self.addSubview(addButton)
        self.addSubview(titleLabel)
    }
    
    func styleSubviews(){
        self.backgroundColor = .white
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 20)
        titleLabel.text = "Add a new place"
        
        nameField.placeholder = "Name"
        nameField.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        nameField.layer.cornerRadius = 10
        nameField.setLeftPaddingPoints(10)
        
        descriptionField.placeholder = "Description"
        descriptionField.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        descriptionField.layer.cornerRadius = 10
        descriptionField.setLeftPaddingPoints(10)
        
        imageField.placeholder = "Image URL"
        imageField.textColor = .white
        imageField.attributedPlaceholder = NSAttributedString(string: "Enter image URL",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        imageField.setLeftPaddingPoints(10)
        
        imageField.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        imageField.layer.cornerRadius = 10
        
        addButton.backgroundColor = UIColor.triptipsBlue
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitle("Add", for: .normal)
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        addButton.layer.shadowRadius = 5
        addButton.layer.shadowOpacity = 0.2
        addButton.layer.cornerRadius = 22.5
        addButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "sight")
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
    }
    
    func positionSubviews(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            imageView.bottomAnchor.constraint(equalTo: nameField.topAnchor, constant: -20)])
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameField.bottomAnchor.constraint(equalTo: descriptionField.topAnchor, constant: -20),
            nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameField.heightAnchor.constraint(equalToConstant: 35),
            nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        imageField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageField.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            imageField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageField.heightAnchor.constraint(equalToConstant: 35),
            imageField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionField.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20),
            descriptionField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionField.heightAnchor.constraint(equalToConstant: 70),
            descriptionField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            addButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 45),
            addButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
            ])
    }
}
