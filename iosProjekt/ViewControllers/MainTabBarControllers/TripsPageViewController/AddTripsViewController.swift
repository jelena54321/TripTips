//
//  MyTripsViewController.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 20/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class AddTripsViewController: UIViewController {
    
    private static let cellReuseIdentifier = "cellReuseIdentifier"
    
    private let viewsContainer: UIView = {
        let viewsContainer = UIView()
        viewsContainer.translatesAutoresizingMaskIntoConstraints = false
        return viewsContainer
    }()
    
    private let mainImage: ImageWithInfoView = {
        let mainImage = ImageWithInfoView()
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        return mainImage
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        return infoLabel
    }()
    
    private let addButton: UIButton = {
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        addTargets()
    }
    
    @objc func addTapped() {
        navigationController?.pushViewController(
            AddTripViewController(),
            animated: true
        )
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.addSubview(viewsContainer)
        NSLayoutConstraint.activate([
            viewsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            viewsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            viewsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        mainImage.setImage(image: UIImage(named: "beetle.jpg")!)
        mainImage.setInfo(info: "+")
        mainImage.setInfoColor(color: .white)
        mainImage.setInfoBackgroundColor(color: .triptipsBlue)

        mainImage.layer.masksToBounds = false
        mainImage.layer.shadowColor = UIColor.black.cgColor
        mainImage.layer.shadowOffset = CGSize(width: 5, height: 5)
        mainImage.layer.shadowRadius = 5
        mainImage.layer.shadowOpacity = 0.2

        mainImage.imageView.layer.cornerRadius = 10.0
        mainImage.imageView.layer.masksToBounds = true

        viewsContainer.addSubview(mainImage)
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: viewsContainer.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: viewsContainer.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: viewsContainer.trailingAnchor),
            mainImage.heightAnchor.constraint(equalToConstant: 400.0)
        ])

        titleLabel.text = "Add Trips"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 30)

        viewsContainer.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: viewsContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: viewsContainer.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 40.0)
        ])

        infoLabel.textColor = .darkGray
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont(name: "Montserrat-Thin", size: 20)
        infoLabel.text = "Add new trip to your list of trips by clicking button bellow"

        viewsContainer.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: viewsContainer.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: viewsContainer.trailingAnchor),
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0)
        ])

        addButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 20)
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(UIColor.triptipsBlue, for: .normal)
        addButton.backgroundColor = .white
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.triptipsBlue.cgColor
        addButton.layer.cornerRadius = 22.5

        viewsContainer.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: viewsContainer.centerXAnchor),
            addButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 30.0),
            addButton.widthAnchor.constraint(equalToConstant: 200.0),
            addButton.heightAnchor.constraint(equalToConstant: 40.0),
            addButton.bottomAnchor.constraint(equalTo: viewsContainer.bottomAnchor)
        ])
    }
    
    private func addTargets() {
        addButton.addTarget(
            self,
            action: #selector(addTapped),
            for: .touchUpInside
        )
    }
}
