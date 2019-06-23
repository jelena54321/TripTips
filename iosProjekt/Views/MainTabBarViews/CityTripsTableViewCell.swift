//
//  CityTripsTableViewCell.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 22/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

class CityTripsTableViewCell: UITableViewCell {
    
    private let viewsContainer: UIView = {
        let viewsContainer = UIView()
        viewsContainer.translatesAutoresizingMaskIntoConstraints = false
        return viewsContainer
    }()
    
    private let destinationProperty: TripPropertyView = {
        let destinationProperty = TripPropertyView()
        destinationProperty.translatesAutoresizingMaskIntoConstraints = false
        return destinationProperty
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
            viewsContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            viewsContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15.0),
            viewsContainer.topAnchor.constraint(equalTo: self.topAnchor),
            viewsContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        destinationProperty.setProperty(property: "Destination")
        destinationProperty.setPropertyIcon(image: UIImage(named: "whereToIcon.png")!)
        
        viewsContainer.addSubview(destinationProperty)
        NSLayoutConstraint.activate([
            destinationProperty.leadingAnchor.constraint(
                equalTo: viewsContainer.leadingAnchor, constant: 20.0
            ),
            destinationProperty.trailingAnchor.constraint(
                equalTo: viewsContainer.trailingAnchor, constant: -20.0
            ),
            destinationProperty.topAnchor.constraint(equalTo: viewsContainer.topAnchor, constant: 20.0),
            destinationProperty.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        let dateImage = UIImage(named: "dateIcon.png")!
        
        departureProperty.setProperty(property: "Departure")
        departureProperty.setPropertyIcon(image: dateImage)
        
        viewsContainer.addSubview(departureProperty)
        NSLayoutConstraint.activate([
            departureProperty.leadingAnchor.constraint(equalTo: destinationProperty.leadingAnchor),
            departureProperty.trailingAnchor.constraint(equalTo: destinationProperty.trailingAnchor),
            departureProperty.topAnchor.constraint(equalTo: destinationProperty.bottomAnchor, constant: 10.0),
            departureProperty.heightAnchor.constraint(equalTo: destinationProperty.heightAnchor)
        ])
        
        returnProperty.setProperty(property: "Return")
        returnProperty.setPropertyIcon(image: dateImage)
        
        viewsContainer.addSubview(returnProperty)
        NSLayoutConstraint.activate([
            returnProperty.leadingAnchor.constraint(equalTo: destinationProperty.leadingAnchor),
            returnProperty.trailingAnchor.constraint(equalTo: destinationProperty.trailingAnchor),
            returnProperty.topAnchor.constraint(equalTo: departureProperty.bottomAnchor, constant: 10.0),
            returnProperty.heightAnchor.constraint(equalTo: destinationProperty.heightAnchor),
            returnProperty.bottomAnchor.constraint(equalTo: viewsContainer.bottomAnchor, constant: -20.0)
        ])
    }
    
    override func prepareForReuse() {
        destinationProperty.setPropertyValue(value: "")
        departureProperty.setPropertyValue(value: "")
        returnProperty.setPropertyValue(value: "")
    }
    
    func setUp(withModel model: CityTripsCellViewModel) {
        destinationProperty.setPropertyValue(value: model.destination)
        departureProperty.setPropertyValue(value: model.departureDate)
        returnProperty.setPropertyValue(value: model.returnDate)
    }

}
