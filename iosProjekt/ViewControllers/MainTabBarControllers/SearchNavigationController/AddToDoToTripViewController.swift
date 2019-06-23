//
//  AddToDoToTripViewController.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 22/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class AddToDoToTripViewController: UIViewController {
    
    private static let cellReuseIdentifier = "cellReuseIdentifier"
    
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
    
    private let tripsTableView: UITableView = {
        let tripsTableView = UITableView()
        tripsTableView.translatesAutoresizingMaskIntoConstraints = false
        return tripsTableView
    }()
    
    private let closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()
    
    private var refreshControl: UIRefreshControl!
    private var cityTripsViewModel: CityTripsViewModel!
    
    convenience init(cityTripsViewModel: CityTripsViewModel) {
        self.init()
        self.cityTripsViewModel = cityTripsViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpTableView()
        addTargets()
        bindModel()
    }
    
    @objc func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func refresh() {
        DispatchQueue.main.async { [weak self] in
            self?.tripsTableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        
        closeButton.setTitle("✖️", for: .normal)
        
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
            closeButton.heightAnchor.constraint(equalToConstant: 30.0)
        ])
        
        titleLabel.text = "Select trip"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 30)
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 40.0)
        ])
        
        infoLabel.text = "Choose trip to which you want to add selected ToDo"
        infoLabel.textColor = .darkGray
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont(name: "Montserrat-Thin", size: 20)
        
        view.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0)
        ])
        
        tripsTableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tripsTableView)
        NSLayoutConstraint.activate([
            tripsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tripsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tripsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tripsTableView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 30.0)
        ])
    }
    
    private func setUpTableView() {
        tripsTableView.separatorStyle = .none
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
        
        tripsTableView.register(
            CityTripsTableViewCell.self,
            forCellReuseIdentifier: AddToDoToTripViewController.cellReuseIdentifier
        )
        
        refreshControl = UIRefreshControl()
        tripsTableView.refreshControl = refreshControl
    }
    
    private func addTargets() {
        closeButton.addTarget(
            self,
            action: #selector(closeTapped),
            for: .touchUpInside
        )
        
        refreshControl.addTarget(
            self,
            action: #selector(refresh),
            for: .valueChanged
        )
    }
    
    private func bindModel() {
        cityTripsViewModel.fetchTrips { [weak self] in
            self?.refresh()
        }
    }
}

extension AddToDoToTripViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        cityTripsViewModel.addToDo(toTripAtRow: indexPath.section) { [weak self] (updateStatus) in
            let alert: UIAlertController
            if updateStatus == UpdateStatus.SUCCESS {
                alert = UIAlertController(
                    title: "Success",
                    message: "ToDo has been successfully added to selected trip!",
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
                handler: { [weak self] (action) in
                    self?.dismiss(animated: true, completion: nil)
            }))
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
}

extension AddToDoToTripViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cityTripsViewModel.numberOfTrips()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: AddToDoToTripViewController.cellReuseIdentifier,
            for: indexPath
        ) as! CityTripsTableViewCell
        
        if let model = cityTripsViewModel.cellModel(forRow: indexPath.section) {
            cell.setUp(withModel: model)
        }
        
        return cell
    }
}
