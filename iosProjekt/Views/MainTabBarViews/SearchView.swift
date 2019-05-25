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
    let destinationsLabel = UILabel()
    
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
        self.addSubview(destinationsLabel)
    }
    
    
    func styleSubviews(){        
        searchField.placeholder = "Enter city"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 10
        searchField.setLeftPaddingPoints(10)
        searchField.layer.shadowColor = UIColor.black.cgColor
        searchField.layer.shadowOffset = CGSize(width: 5, height: 5)
        searchField.layer.shadowRadius = 5
        searchField.layer.shadowOpacity = 0.2
        
        destinationsLabel.text = "Popular destinations"
        destinationsLabel.font = UIFont(name: "Montserrat-Bold", size: 20)
    }
    
    func positionSubviews(){
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            searchField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            searchField.heightAnchor.constraint(equalToConstant: 45)
            ])
        
        destinationsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            destinationsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 115),
            destinationsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18)])
    }
}
