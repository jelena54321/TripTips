//
//  AddTripViewController.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 20/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class AddTripViewController: UIViewController {
    
    private let mapImageView: UIImageView = {
        let mapImageView = UIImageView()
        mapImageView.translatesAutoresizingMaskIntoConstraints = false
        return mapImageView
    }()
    
    private let container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private let tripCreator: TripCreatorView = {
        let tripCreator = TripCreatorView(destinationModel: DestinationViewModel())
        tripCreator.translatesAutoresizingMaskIntoConstraints = false
        return tripCreator
    }()
    
    private let returnButton: UIButton = {
        let returnButton = BackButton()
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        return returnButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        addTargets()
    }
    
    override func viewDidLayoutSubviews() {
        tripCreator.setBorders()
    }
    
    @objc func returnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpUI() {
        mapImageView.image = UIImage(named: "map.png")
        mapImageView.contentMode = .scaleAspectFill
        
        view.addSubview(mapImageView)
        NSLayoutConstraint.activate([
            mapImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapImageView.topAnchor.constraint(equalTo: view.topAnchor),
            mapImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(returnButton)
        NSLayoutConstraint.activate([
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            returnButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            returnButton.widthAnchor.constraint(equalToConstant: 60.0),
            returnButton.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        container.backgroundColor = .white
        container.layer.cornerRadius = 15
        container.layer.masksToBounds = false
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOffset = CGSize(width: 5, height: 5)
        container.layer.shadowRadius = 5
        container.layer.shadowOpacity = 0.2
        
        view.addSubview(container)
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0)
        ])
        
        tripCreator.delegate = self
        
        container.addSubview(tripCreator)
        NSLayoutConstraint.activate([
            tripCreator.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15.0),
            tripCreator.topAnchor.constraint(equalTo: container.topAnchor, constant: 30.0),
            tripCreator.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15.0),
            tripCreator.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -30.0)
        ])
    }
    
    private func addTargets() {
        returnButton.addTarget(
            self,
            action: #selector(returnTapped),
            for: .touchUpInside
        )
    }
}

extension AddTripViewController: TripCreatorDelegate {
    
    func tripCreated() {
        guard
            let departureDate = tripCreator.getDepartureDate(),
            !departureDate.isEmpty,
            let returnDate = tripCreator.getReturnDate(),
            !returnDate.isEmpty,
            let destination = tripCreator.getDestination(),
            !destination.isEmpty else {
                
            let alert = UIAlertController(
                title: "Failure",
                message: "Can not make new trip with empty fields!",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let trip = Trip(
            departureDate: departureDate,
            returnDate: returnDate,
            destination: destination
        )
        
        DataController.shared.createTrip(trip: trip) { [weak self] (updateStatus) in
            let alert: UIAlertController
            if updateStatus == UpdateStatus.SUCCESS {
                alert = UIAlertController(
                    title: "Success",
                    message: "New trip has been added to your trips!",
                    preferredStyle: .alert
                )
            } else {
                alert = UIAlertController(
                    title: "Failure",
                    message: "Something went wrong",
                    preferredStyle: .alert
                )
            }
            
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (action) in
                    self?.navigationController?.popViewController(animated: true)
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
