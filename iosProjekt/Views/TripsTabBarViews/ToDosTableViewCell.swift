//
//  ToDosTableViewCell.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 23/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

class ToDosTableViewCell: UITableViewCell {
    
    private let viewsContainer: UIView = {
        let viewsContainer = UIView()
        viewsContainer.translatesAutoresizingMaskIntoConstraints = false
        return viewsContainer
    }()
    
    private let toDoImage: ImageWithInfoView = {
        let toDoImage = ImageWithInfoView()
        toDoImage.translatesAutoresizingMaskIntoConstraints = false
        return toDoImage
    }()
    
    private let toDoNameLabel: UILabel = {
        let toDoNameLabel = UILabel()
        toDoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return toDoNameLabel
    }()
    
    private let separatorLine: UIView = {
        let separtorLine = UIView()
        separtorLine.translatesAutoresizingMaskIntoConstraints = false
        return separtorLine
    }()
    
    private let toDoDescriptionLabel: UILabel = {
        let toDoDescriptionLabel = UILabel()
        toDoDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return toDoDescriptionLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        backgroundColor = .white
        
        viewsContainer.backgroundColor = .white
        viewsContainer.layer.masksToBounds = false
        viewsContainer.layer.shadowColor = UIColor.black.cgColor
        viewsContainer.layer.shadowOffset = CGSize(width: 5, height: 5)
        viewsContainer.layer.shadowRadius = 5
        viewsContainer.layer.shadowOpacity = 0.2
        viewsContainer.layer.cornerRadius = 10.0
        
        addSubview(viewsContainer)
        NSLayoutConstraint.activate([
            viewsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            viewsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            viewsContainer.topAnchor.constraint(equalTo: self.topAnchor),
            viewsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        toDoImage.setInfo(info: "ToDo")
        toDoImage.setInfoColor(color: .black)
        toDoImage.setInfoBackgroundColor(color: .triptipsYellow)
        toDoImage.imageView.layer.cornerRadius = 10.0
        toDoImage.imageView.layer.masksToBounds = true
        toDoImage.imageView.layer.cornerRadius = 10
        toDoImage.imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        viewsContainer.addSubview(toDoImage)
        NSLayoutConstraint.activate([
            toDoImage.leadingAnchor.constraint(equalTo: viewsContainer.leadingAnchor),
            toDoImage.trailingAnchor.constraint(equalTo: viewsContainer.trailingAnchor),
            toDoImage.topAnchor.constraint(equalTo: viewsContainer.topAnchor),
            toDoImage.heightAnchor.constraint(equalToConstant: 200.0)
        ])
        
        toDoNameLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
        
        viewsContainer.addSubview(toDoNameLabel)
        NSLayoutConstraint.activate([
            toDoNameLabel.leadingAnchor.constraint(equalTo: viewsContainer.leadingAnchor, constant: 20.0),
            toDoNameLabel.topAnchor.constraint(equalTo: toDoImage.bottomAnchor, constant: 30.0),
            toDoNameLabel.trailingAnchor.constraint(equalTo: viewsContainer.trailingAnchor, constant: -20.0),
            toDoNameLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        separatorLine.backgroundColor = .lightGray
        
        viewsContainer.addSubview(separatorLine)
        NSLayoutConstraint.activate([
            separatorLine.leadingAnchor.constraint(equalTo: toDoNameLabel.leadingAnchor),
            separatorLine.topAnchor.constraint(equalTo: toDoNameLabel.bottomAnchor, constant: 20.0),
            separatorLine.trailingAnchor.constraint(equalTo: toDoNameLabel.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        toDoDescriptionLabel.font = UIFont(name: "Montserrat-Thin", size: 14)
        
        viewsContainer.addSubview(toDoDescriptionLabel)
        NSLayoutConstraint.activate([
            toDoDescriptionLabel.leadingAnchor.constraint(equalTo: toDoNameLabel.leadingAnchor),
            toDoDescriptionLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 20.0),
            toDoDescriptionLabel.trailingAnchor.constraint(equalTo: toDoNameLabel.trailingAnchor),
            toDoDescriptionLabel.heightAnchor.constraint(equalTo: toDoNameLabel.heightAnchor),
            toDoDescriptionLabel.bottomAnchor.constraint(equalTo: viewsContainer.bottomAnchor, constant: -20.0)
        ])
    }
    
    override func prepareForReuse() {
        toDoImage.setImage(image: nil)
        toDoNameLabel.text = ""
        toDoDescriptionLabel.text = ""
    }
    
    func setUp(withModel model: ToDosTableCellViewModel) {
        ImageService.shared.fetchImage(imageUrl: model.image) { [weak self] (image) in
            if let image = image {
                self?.toDoImage.setImage(image: image)
            }
        }
        
        toDoNameLabel.text = model.name
        toDoDescriptionLabel.text = model.description
    }

}
