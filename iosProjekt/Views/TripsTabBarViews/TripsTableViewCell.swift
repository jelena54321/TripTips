//
//  TripsTableViewCell.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 21/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

class TripsTableViewCell: UITableViewCell {
    
    private let viewsContainer: UIView = {
        let viewsContainer = UIView()
        viewsContainer.translatesAutoresizingMaskIntoConstraints = false
        return viewsContainer
    }()
    
    private let tripImage: ImageWithInfoView = {
        let tripImage = ImageWithInfoView()
        tripImage.translatesAutoresizingMaskIntoConstraints = false
        return tripImage
    }()
    
    private let whereToProperty: TripPropertyView = {
        let whereToProperty = TripPropertyView()
        whereToProperty.translatesAutoresizingMaskIntoConstraints = false
        return whereToProperty
    }()
    
    private let departureProperty: TripPropertyView = {
        let departureProperty = TripPropertyView()
        departureProperty.translatesAutoresizingMaskIntoConstraints = false
        return departureProperty
    }()
    
    private let returnProperty: TripPropertyView = {
        let returnProperty = TripPropertyView()
        returnProperty.translatesAutoresizingMaskIntoConstraints = false
        return returnProperty
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        viewsContainer.backgroundColor = .white
        viewsContainer.layer.masksToBounds = false
        viewsContainer.layer.shadowColor = UIColor.black.cgColor
        viewsContainer.layer.shadowOffset = CGSize(width: 5, height: 5)
        viewsContainer.layer.shadowRadius = 5
        viewsContainer.layer.shadowOpacity = 0.2
        viewsContainer.layer.cornerRadius = 10.0
        
        addSubview(viewsContainer)
        NSLayoutConstraint.activate([
            viewsContainer.topAnchor.constraint(equalTo: self.topAnchor),
            viewsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            viewsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            viewsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        tripImage.setInfoColor(color: .black)
        tripImage.setInfoBackgroundColor(color: .triptipsYellow)
        tripImage.setInfo(info: "Trip")
        tripImage.imageView.layer.cornerRadius = 10.0
        tripImage.imageView.layer.masksToBounds = true
        tripImage.imageView.layer.cornerRadius = 10
        tripImage.imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        viewsContainer.addSubview(tripImage)
        NSLayoutConstraint.activate([
            tripImage.leadingAnchor.constraint(equalTo: viewsContainer.leadingAnchor),
            tripImage.topAnchor.constraint(equalTo: viewsContainer.topAnchor),
            tripImage.trailingAnchor.constraint(equalTo: viewsContainer.trailingAnchor),
            tripImage.heightAnchor.constraint(equalToConstant: 200.0)
        ])
        
        whereToProperty.setProperty(property: "Where to?")
        whereToProperty.setPropertyIcon(image: UIImage(named: "whereToIcon.png")!)
        
        viewsContainer.addSubview(whereToProperty)
        NSLayoutConstraint.activate([
            whereToProperty.leadingAnchor.constraint(equalTo: viewsContainer.leadingAnchor, constant: 20.0),
            whereToProperty.topAnchor.constraint(equalTo: tripImage.bottomAnchor, constant: 30.0),
            whereToProperty.trailingAnchor.constraint(equalTo: viewsContainer.trailingAnchor, constant: -20.0),
            whereToProperty.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        let dateImage = UIImage(named: "dateIcon.png")!
        
        departureProperty.setProperty(property: "Departure")
        departureProperty.setPropertyIcon(image: dateImage)
        
        addSubview(departureProperty)
        NSLayoutConstraint.activate([
            departureProperty.leadingAnchor.constraint(equalTo: whereToProperty.leadingAnchor),
            departureProperty.topAnchor.constraint(equalTo: whereToProperty.bottomAnchor, constant: 20.0),
            departureProperty.trailingAnchor.constraint(equalTo: whereToProperty.trailingAnchor),
            departureProperty.heightAnchor.constraint(equalTo: whereToProperty.heightAnchor)
        ])
        
        returnProperty.setProperty(property: "Return")
        returnProperty.setPropertyIcon(image: dateImage)
        
        addSubview(returnProperty)
        NSLayoutConstraint.activate([
            returnProperty.leadingAnchor.constraint(equalTo: whereToProperty.leadingAnchor),
            returnProperty.topAnchor.constraint(equalTo: departureProperty.bottomAnchor, constant: 20.0),
            returnProperty.trailingAnchor.constraint(equalTo: whereToProperty.trailingAnchor),
            returnProperty.heightAnchor.constraint(equalTo: whereToProperty.heightAnchor),
            returnProperty.bottomAnchor.constraint(equalTo: viewsContainer.bottomAnchor, constant: -20.0)
        ])
    }
    
    override func prepareForReuse() {
        tripImage.setImage(image: nil)
        whereToProperty.setPropertyValue(value: "")
        departureProperty.setPropertyValue(value: "")
        returnProperty.setPropertyValue(value: "")
    }
    
    func setUpWith(model: TripsTableViewCellModel) {
        ImageService.shared.fetchImage(imageUrl: model.image) { [weak self] (image) in
            if let image = image {
                self?.tripImage.setImage(image: image)
            }
        }
        
        whereToProperty.setPropertyValue(value: model.destination)
        departureProperty.setPropertyValue(value: model.departureDate)
        returnProperty.setPropertyValue(value: model.returnDate)
    }
}
