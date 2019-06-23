//
//  ToDoTableViewCell.swift
//  iosProjekt
//
//  Created by five on 24/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class ToDoTableViewCell : UITableViewCell {
    
    let toDoImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let separator = UIView()
    let likeButton = UIButton()
    let likeNumberLabel = UILabel()
    let tripButton = UIButton()
    
    let detailsBackground = UIView()
    let detailsLabel = UILabel()
    
    var toDo : ToDo!
    
    static let cellIdentifier = "ToDoTableViewCell"
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 8
            frame.size.height -= 2 * 9
            frame.origin.x += 15
            frame.size.width -= 2 * 16
            super.frame = frame
        }
    }
}

extension ToDoTableViewCell: DynamicViewType {
    
    var baseObject: ToDo {
        get {
            return self.toDo
        }
        set {
            self.toDo = newValue
        }
    }
    
    typealias InitType = ToDo
    
    func setup(with baseObject: ToDo) {
        self.descriptionLabel.text = toDo.description
        self.titleLabel.text = toDo.name
        self.likeNumberLabel.text = "\(toDo.likesNumber)"

        
        ImageService.shared.fetchImage(imageUrl: toDo.image){ (image) in
            if image != nil {
                DispatchQueue.main.async {
                    self.toDoImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.toDoImageView.image = UIImage(named: "tour.jpg")
                }
            }
        }
    }
    
    
    func setup(with baseObject: ToDo, liked: Bool) {
        self.descriptionLabel.text = toDo.description
        self.titleLabel.text = toDo.name
        self.likeNumberLabel.text = "\(toDo.likesNumber)"
        if liked {
            self.likeButton.setImage(UIImage(named: "heartRed"), for: .normal)
            self.likeButton.tag = 1
        } else {
            self.likeButton.setImage(UIImage(named: "heartEmpty"), for: .normal)
            self.likeButton.tag = 0
        }
        self.tripButton.setImage(UIImage(named: "trip.png"), for: .normal)
        
        ImageService.shared.fetchImage(imageUrl: toDo.image){ (image) in
            if image != nil {
                DispatchQueue.main.async {
                    self.toDoImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.toDoImageView.image = UIImage(named: "tour.jpg")
                }
            }
        }
    }
    
    func addSubviews(){
        self.addSubview(toDoImageView)
        self.addSubview(descriptionLabel)
        self.addSubview(titleLabel)
        self.addSubview(separator)
        self.addSubview(likeButton)
        self.addSubview(likeNumberLabel)
        self.addSubview(tripButton)
        
        self.addSubview(detailsBackground)
        self.addSubview(detailsLabel)
    }
    
    func styleSubviews(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        
        toDoImageView.clipsToBounds = true
        toDoImageView.layer.masksToBounds = true
        toDoImageView.contentMode = .scaleAspectFill
        toDoImageView.backgroundColor = .lightGray
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 16)
        
        descriptionLabel.textColor = .gray
        descriptionLabel.font = UIFont(name: "Montserrat-Regular", size: 12)
        descriptionLabel.numberOfLines = 0
        
        separator.backgroundColor = .lightGray
        
        likeButton.setImage(UIImage(named: "heartEmpty.pdf"), for: .normal)
        likeButton.imageView?.contentMode = .scaleAspectFit
        likeButton.tag = 0
        
        likeNumberLabel.font = UIFont(name: "Montserrat-Regular", size: 15)
        likeNumberLabel.textColor = .gray
        likeNumberLabel.text = "NaN"
        
        tripButton.setImage(UIImage(named: "trip.png"), for: .normal)
        
        detailsBackground.layer.cornerRadius = 15
        detailsBackground.backgroundColor = UIColor.triptipsYellow
        
        detailsLabel.text = "Details"
        detailsLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
        detailsLabel.textColor = .black
    }
    
    func positionSubviews(){
        
        toDoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toDoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            toDoImageView.heightAnchor.constraint(equalToConstant: 210),
            toDoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            toDoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: toDoImageView.topAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            ])

        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -52),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -45),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)])
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 23)
            ])
        
        likeNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            likeNumberLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likeNumberLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 5)
            ])
        
        tripButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tripButton.leadingAnchor.constraint(equalTo: likeNumberLabel.trailingAnchor, constant: 20.0),
            tripButton.heightAnchor.constraint(equalToConstant: 20),
            tripButton.widthAnchor.constraint(equalToConstant: 20),
            tripButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor)
        ])
        
        detailsBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailsBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            detailsBackground.heightAnchor.constraint(equalToConstant: 30),
            detailsBackground.widthAnchor.constraint(equalToConstant: 75),
            detailsBackground.topAnchor.constraint(equalTo: toDoImageView.bottomAnchor, constant: -15)
            ])
        
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            detailsLabel.centerYAnchor.constraint(equalTo: detailsBackground.centerYAnchor)
            ])
    }
}
