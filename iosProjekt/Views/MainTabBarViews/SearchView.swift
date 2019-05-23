//
//  SearchView.swift
//  iosProjekt
//
//  Created by five on 23/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class SearchView: UIView {
    
    let searchField = CustomSearchTextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let searchButton = UIButton()
    
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
        self.addSubview(searchField)
        self.addSubview(searchButton)
    }
    
    
    func styleSubviews(){
        self.backgroundColor = .white
        
        searchField.placeholder = "Enter city"
        searchField.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        searchField.layer.cornerRadius = 10
        searchField.setLeftPaddingPoints(10)
        
        searchButton.backgroundColor = UIColor.triptipsBlue
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.setTitle("Check it out", for: .normal)
        searchButton.layer.shadowColor = UIColor.black.cgColor
        searchButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        searchButton.layer.shadowRadius = 5
        searchButton.layer.shadowOpacity = 0.2
        searchButton.layer.cornerRadius = 22.5
        searchButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
    }
    
    func positionSubviews(){
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            searchField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 45),
            searchField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75)
            ])
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -75),
            searchButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 45),
            searchButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75)
            ])
    }
}
