//
//  ToDosViewController.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 23/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class MyToDosViewController: UIViewController {
    
    private static let cellReuseIdentifier = "cellReuseIdentifier"
    
    private let returnButton: UIButton = {
        let returnButton = BackButton()
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        return returnButton
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    private let toDosTableView: UITableView = {
        let toDosTableView = UITableView()
        toDosTableView.translatesAutoresizingMaskIntoConstraints = false
        return toDosTableView
    }()
    
    var toDosViewModel: ToDosViewModel!
    var refreshControl: UIRefreshControl!
    
    convenience init(toDosViewModel: ToDosViewModel) {
        self.init()
        self.toDosViewModel = toDosViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpTableView()
        addTargets()
        bindViewModel()
    }
    
    @objc func refresh() {
        DispatchQueue.main.async { [weak self] in
            self?.toDosTableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @objc func returnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        
        view.addSubview(returnButton)
        NSLayoutConstraint.activate([
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            returnButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            returnButton.widthAnchor.constraint(equalToConstant: 60.0),
            returnButton.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        titleLabel.text = "Trip ToDos"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 30)
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30.0),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30.0),
            titleLabel.topAnchor.constraint(equalTo: returnButton.bottomAnchor, constant: 40.0)
        ])
        
        toDosTableView.showsVerticalScrollIndicator = false
        toDosTableView.separatorStyle = .none
        
        view.addSubview(toDosTableView)
        NSLayoutConstraint.activate([
            toDosTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toDosTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toDosTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30.0),
            toDosTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpTableView() {
        refreshControl = UIRefreshControl()
        toDosTableView.refreshControl =  refreshControl
        
        toDosTableView.delegate = self
        toDosTableView.dataSource = self
        toDosTableView.separatorStyle = .none
        
        toDosTableView.register(
            ToDosTableViewCell.self,
            forCellReuseIdentifier: MyToDosViewController.cellReuseIdentifier
        )
    }
    
    private func addTargets() {
        refreshControl.addTarget(
            self,
            action: #selector(refresh),
            for: .valueChanged
        )
        
        returnButton.addTarget(
            self,
            action: #selector(returnTapped),
            for: .touchUpInside
        )
    }
    
    private func bindViewModel() {
        toDosViewModel.fetchToDos { [weak self] in
            self?.refresh()
        }
    }
}

extension MyToDosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

extension MyToDosViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return toDosViewModel.numberOfToDos()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = toDosTableView.dequeueReusableCell(
            withIdentifier: MyToDosViewController.cellReuseIdentifier,
            for: indexPath
        ) as! ToDosTableViewCell
        
        if let cellModel = toDosViewModel.cellModel(forRow: indexPath.section) {
            cell.setUp(withModel: cellModel)
        }
        
        return cell
    }
}
