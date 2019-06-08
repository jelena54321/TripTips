//
//  AddToDoView.swift
//  iosProjekt
//
//  Created by five on 05/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class AddToDoView : UIView {
    
    let imageView = UIImageView()
    let imageField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let nameField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let descriptionField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let scrollView = UIScrollView()
    let nextButton1 = UIButton()
    let nextButton2 = UIButton()
    let backButton1 = UIButton()
    let backButton2 = UIButton()
    let addButton = UIButton()
    let titleLabel = UILabel()
    let mapView = MKMapView()
    let pin = UIImageView()
    let defImageView = UIImageView()
    let defNameLabel = UILabel()
    let defDescriptionLabel = UILabel()
    let mapLabel = UILabel()
    
    //temporary
    let helpView = UIView()
    
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
        self.addSubview(titleLabel)
        self.addSubview(scrollView)
        scrollView.addSubview(helpView)
        helpView.addSubview(imageView)
        helpView.addSubview(imageField)
        helpView.addSubview(nameField)
        helpView.addSubview(descriptionField)
        helpView.addSubview(nextButton1)
        helpView.addSubview(nextButton2)
        helpView.addSubview(backButton1)
        helpView.addSubview(backButton2)
        helpView.addSubview(addButton)
        helpView.addSubview(mapView)
        helpView.addSubview(pin)
        helpView.addSubview(defDescriptionLabel)
        helpView.addSubview(defNameLabel)
        helpView.addSubview(defImageView)
        helpView.addSubview(mapLabel)
    }
    
    func styleSubviews(){
        self.backgroundColor = .white
        
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = false
        scrollView.showsHorizontalScrollIndicator = false
        
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
    
        
        nextButton1.backgroundColor = .white
        nextButton1.layer.borderWidth = 2
        nextButton1.layer.borderColor = UIColor.triptipsBlue.cgColor
        nextButton1.setTitleColor(UIColor.triptipsBlue, for: .normal)
        nextButton1.setTitle("Next", for: .normal)
        nextButton1.layer.cornerRadius = 22.5
        nextButton1.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        nextButton2.backgroundColor = .white
        nextButton2.layer.borderWidth = 2
        nextButton2.layer.borderColor = UIColor.triptipsBlue.cgColor
        nextButton2.setTitleColor(UIColor.triptipsBlue, for: .normal)
        nextButton2.setTitle("Next", for: .normal)
        nextButton2.layer.cornerRadius = 22.5
        nextButton2.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        backButton1.backgroundColor = .white
        backButton1.layer.borderWidth = 2
        backButton1.layer.borderColor = UIColor.triptipsBlue.cgColor
        backButton1.setTitleColor(UIColor.triptipsBlue, for: .normal)
        backButton1.setTitle("Back", for: .normal)
        backButton1.layer.cornerRadius = 22.5
        backButton1.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        backButton2.backgroundColor = .white
        backButton2.layer.borderWidth = 2
        backButton2.layer.borderColor = UIColor.triptipsBlue.cgColor
        backButton2.setTitleColor(UIColor.triptipsBlue, for: .normal)
        backButton2.setTitle("Back", for: .normal)
        backButton2.layer.cornerRadius = 22.5
        backButton2.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        addButton.backgroundColor = UIColor.triptipsBlue
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitle("Add", for: .normal)
        addButton.layer.cornerRadius = 22.5
        addButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "sight")
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        
        mapView.mapType = .standard
        
        pin.image = UIImage(named: "pin")
        pin.contentMode = .scaleAspectFit
        
        mapLabel.text = "Where is the location?"
        mapLabel.numberOfLines = 1
        mapLabel.font = UIFont(name: "Montserrat-Bold", size: 18)
        
        defImageView.contentMode = .scaleAspectFill
        defImageView.image = UIImage(named: "sight")
        defImageView.backgroundColor = .gray
        defImageView.clipsToBounds = true
        defImageView.layer.masksToBounds = true
        
        defNameLabel.text = ""
        defNameLabel.numberOfLines = 1
        defNameLabel.font = UIFont(name: "Montserrat-Bold", size: 18)
        
        defDescriptionLabel.text = ""
        defDescriptionLabel.numberOfLines = 0
        defDescriptionLabel.textColor = .gray
        defDescriptionLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        
    }
    
    func positionSubviews(){

        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
            ])
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant : 50),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -22),
            ])
        
        helpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helpView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            helpView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            helpView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            helpView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            helpView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            helpView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3)
            ])
    
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: helpView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: helpView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: helpView.bottomAnchor, constant: -180),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            nameField.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 0),
            nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            nameField.heightAnchor.constraint(equalToConstant: 35)
            ])
        
        imageField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageField.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            imageField.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 0),
            imageField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            imageField.heightAnchor.constraint(equalToConstant: 35)
            ])
        
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            descriptionField.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 0),
            descriptionField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            descriptionField.heightAnchor.constraint(equalToConstant: 35)
            ])
        
        nextButton1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton1.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20),
            nextButton1.heightAnchor.constraint(equalToConstant: 45),
            nextButton1.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            nextButton1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
            ])
        
        nextButton2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton2.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20),
            nextButton2.heightAnchor.constraint(equalToConstant: 45),
            nextButton2.leadingAnchor.constraint(equalTo: mapView.centerXAnchor, constant: 10),
            nextButton2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
            ])
        
        backButton1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton1.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20),
            backButton1.heightAnchor.constraint(equalToConstant: 45),
            backButton1.trailingAnchor.constraint(equalTo: mapView.centerXAnchor, constant: -10),
            backButton1.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
            ])
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: helpView.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: helpView.bottomAnchor, constant: -140),
            mapView.widthAnchor.constraint(equalTo: self.widthAnchor)
            ])
        
        pin.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pin.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            pin.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -18),
            pin.heightAnchor.constraint(equalToConstant: 36)
            ])
        
        mapLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapLabel.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            mapLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10)])
        
        defImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            defImageView.leadingAnchor.constraint(equalTo: mapView.trailingAnchor),
            defImageView.topAnchor.constraint(equalTo: helpView.topAnchor),
            defImageView.trailingAnchor.constraint(equalTo: helpView.trailingAnchor),
            defImageView.bottomAnchor.constraint(equalTo: helpView.bottomAnchor, constant: -170)])
        
        defNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            defNameLabel.topAnchor.constraint(equalTo: nameField.topAnchor),
            defNameLabel.leadingAnchor.constraint(equalTo: defImageView.leadingAnchor, constant: 20),
            ])
        
        defDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            defDescriptionLabel.topAnchor.constraint(equalTo: defNameLabel.bottomAnchor, constant: 10),
            defDescriptionLabel.leadingAnchor.constraint(equalTo: defImageView.leadingAnchor, constant: 20)
            ])
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20),
            addButton.heightAnchor.constraint(equalToConstant: 45),
            addButton.leadingAnchor.constraint(equalTo: defImageView.centerXAnchor, constant: 10),
            addButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
            ])
        
        backButton2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton2.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20),
            backButton2.heightAnchor.constraint(equalToConstant: 45),
            backButton2.trailingAnchor.constraint(equalTo: defImageView.centerXAnchor, constant: -10),
            backButton2.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
            ])
        
        
    }
}
