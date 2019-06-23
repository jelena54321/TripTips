//
//  MyTripsViewController.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 21/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class MyTripsViewController: UIViewController {
    
    private static let cellReuseIdentifier = "cellReuseIdentifier"
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let tripsTableView: UITableView = {
        let tripsTableView = UITableView()
        tripsTableView.translatesAutoresizingMaskIntoConstraints = false
        return tripsTableView
    }()
    
    private let returnButton: UIButton = {
        let returnButton = BackButton()
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        return returnButton
    }()
    
    private var refreshControl: UIRefreshControl!
    private var tripsViewModel: TripsViewModel!
    
    convenience init(tripsViewModel: TripsViewModel) {
        self.init()
        self.tripsViewModel = tripsViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpTable()
        addTargets()
        bindViewModel()
    }
    
    @objc func refresh() {
        DispatchQueue.main.async { [weak self] in
            self?.tripsTableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc func returnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.addSubview(returnButton)
        NSLayoutConstraint.activate([
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            returnButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            returnButton.widthAnchor.constraint(equalToConstant: 60.0),
            returnButton.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        titleLabel.text = "My Trips"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 30)
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            titleLabel.topAnchor.constraint(equalTo: returnButton.bottomAnchor, constant: 40.0)
        ])
        
        tripsTableView.showsVerticalScrollIndicator = false
        tripsTableView.separatorStyle = .none
        
        view.addSubview(tripsTableView)
        NSLayoutConstraint.activate([
            tripsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tripsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tripsTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30.0),
            tripsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpTable() {
        tripsTableView.delegate = self
        tripsTableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        tripsTableView.refreshControl = refreshControl
        
        tripsTableView.register(
            TripsTableViewCell.self,
            forCellReuseIdentifier: MyTripsViewController.cellReuseIdentifier
        )
    }
    
    private func addTargets() {
        refreshControl.addTarget(
            self,
            action: #selector(refresh),
            for: .touchUpInside
        )
        
        returnButton.addTarget(
            self,
            action: #selector(returnTapped),
            for: .touchUpInside
        )
    }
    
    private func bindViewModel() {
        tripsViewModel.fetchTrips { [weak self] in
            self?.refresh()
        }
    }
}

extension MyTripsViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let model = tripsViewModel.model(forRow: indexPath.section) {
            navigationController?.pushViewController(
                MyToDosViewController(toDosViewModel: model),
                animated: true
            )
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
}

extension MyTripsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripsViewModel.numberOfTrips()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tripsTableView.dequeueReusableCell(
            withIdentifier: MyTripsViewController.cellReuseIdentifier,
            for: indexPath
        ) as! TripsTableViewCell
        
        if let cellModel = tripsViewModel.cellModel(forRow: indexPath.section) {
            cell.setUpWith(model: cellModel)
        }
        
        return cell
    }
}
