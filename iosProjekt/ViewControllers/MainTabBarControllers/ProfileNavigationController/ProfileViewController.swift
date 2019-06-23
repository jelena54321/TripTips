//
//  ProfileViewController.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 27/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    private static let userInfoCellID = "userInfoCellID"
    private static let myLikesCellID = "myLikesCellID"
    private static let myTripsCellID = "myTripsCellID"
    
    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImage
    }()
    
    private let blurEffectView: UIVisualEffectView = {
        let blurEffectView = UIVisualEffectView()
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private var tableViewTopConstraint: NSLayoutConstraint!
    
    private var profileViewModel: ProfileViewModel!
    private var refreshControl: UIRefreshControl!
    
    convenience init(profileViewModel: ProfileViewModel) {
        self.init()
        self.profileViewModel = profileViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setUpTableView()
        bindModel()
    }
    
    override func viewDidLayoutSubviews() {
        tableViewTopConstraint.constant = scrollView.bounds.height - 100
        tableView.tableHeaderView = ProfileTableViewHeader(frame:
            CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(width: scrollView.bounds.width, height: 100.0)
            )
        )
    }
    
    @objc func refresh() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func setUpUI() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        backgroundImage.image = UIImage(named: "profilePhoto")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.masksToBounds = true
        
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        blurEffectView.effect = UIBlurEffect(style: .regular)
        blurEffectView.alpha = 0
        
        view.addSubview(blurEffectView)
        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300.0)
        ])
        
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        tableView.layer.masksToBounds = false
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 15.0
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowRadius = 5
        tableView.layer.shadowOpacity = 0.3
        tableView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        contentView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 450)
        ])
        tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: contentView.topAnchor)
        tableViewTopConstraint.isActive = true
    }
    
    private func setUpTableView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            UserInfoTableViewCell.self,
            forCellReuseIdentifier: ProfileViewController.userInfoCellID
        )
        
        tableView.register(
            MyLikesTableViewCell.self,
            forCellReuseIdentifier: ProfileViewController.myLikesCellID
        )
        
        tableView.register(
            MyTripsTableViewCell.self,
            forCellReuseIdentifier: ProfileViewController.myTripsCellID
        )

        
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(
            self,
            action: #selector(ProfileViewController.refresh),
            for: UIControl.Event.valueChanged
        )
    }
    
    private func bindModel() {
        profileViewModel.fetchCurrentUser() { [weak self] in
            self?.refresh()
        }
    }
    
}

extension ProfileViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        blurEffectView.alpha = scrollView.contentOffset.y / scrollView.bounds.height
    }
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch profileViewModel.itemType(forSection: indexPath.section) {
        case .myTrips:
            navigationController?.pushViewController(
                MyTripsViewController(tripsViewModel: TripsViewModel()),
                animated: true
            )
        default:
            if let fieldViewModel = profileViewModel.model(forIndexPath: indexPath) {
                navigationController?.pushViewController(
                    SetUpController(fieldViewModel: fieldViewModel),
                    animated: true
                )
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileTableViewCell
        
        switch profileViewModel.itemType(forSection: indexPath.section) {
        case .myLikes:
            cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileViewController.myLikesCellID,
                for: indexPath
            ) as! MyLikesTableViewCell
        case .myTrips:
            cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileViewController.myTripsCellID,
                for: indexPath
            ) as! MyTripsTableViewCell
        default:
            cell = tableView.dequeueReusableCell(
                withIdentifier: ProfileViewController.userInfoCellID,
                for: indexPath
            ) as! UserInfoTableViewCell
        }
        
        if let cellModel = profileViewModel.cellModel(forIndexPath: indexPath) {
            cell.setUp(withModel: cellModel)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileViewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewModel.numberOfRows(forSection: section)
    }
}
