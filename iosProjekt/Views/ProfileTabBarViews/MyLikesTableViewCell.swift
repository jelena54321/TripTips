//
//  MyLikesTableViewCell.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 19/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

class MyLikesTableViewCell: ProfileTableViewCell {
    
    private let viewsContainer: UIView = {
        let viewsContainer = UIView()
        viewsContainer.translatesAutoresizingMaskIntoConstraints = false
        return viewsContainer
    }()
    
    private let imageIcon: UIImageView = {
        let imageIcon = UIImageView()
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        return imageIcon
    }()
    
    private let myLikesLabel: UILabel = {
        let myLikesLabel = UILabel()
        myLikesLabel.translatesAutoresizingMaskIntoConstraints = false
        return myLikesLabel
    }()
    
    private let arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        return arrowImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        addSubview(viewsContainer)
        NSLayoutConstraint.activate([
            viewsContainer.widthAnchor.constraint(equalToConstant: 200.0),
            viewsContainer.heightAnchor.constraint(equalToConstant: 40.0),
            viewsContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            viewsContainer.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        imageIcon.image = UIImage(named: "heartRed.png")
        
        viewsContainer.addSubview(imageIcon)
        NSLayoutConstraint.activate([
            imageIcon.leftAnchor.constraint(equalTo: viewsContainer.leftAnchor, constant: 20.0),
            imageIcon.centerYAnchor.constraint(equalTo: viewsContainer.centerYAnchor),
            imageIcon.widthAnchor.constraint(equalToConstant: 20.0),
            imageIcon.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        myLikesLabel.text = "My Likes"
        myLikesLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
        
        viewsContainer.addSubview(myLikesLabel)
        NSLayoutConstraint.activate([
            myLikesLabel.leftAnchor.constraint(equalTo: imageIcon.rightAnchor, constant: 20.0),
            myLikesLabel.centerYAnchor.constraint(equalTo: imageIcon.centerYAnchor),
            myLikesLabel.widthAnchor.constraint(equalToConstant: 230.0),
            myLikesLabel.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        arrowImageView.image = UIImage(named: "arrow.png")
        
        addSubview(arrowImageView)
        NSLayoutConstraint.activate([
            arrowImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20.0),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20.0),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20.0),
            arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}
