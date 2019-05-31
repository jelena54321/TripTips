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
    
    private var backgroundImageTopConstraint: NSLayoutConstraint?
    private var backgroundImageBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI() {
        self.navigationItem.hidesBackButton = true
        
        backgroundImage.image = UIImage(named: "profilePhoto")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.masksToBounds = true
        
        self.view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        backgroundImageTopConstraint = backgroundImage.topAnchor.constraint(
            equalTo: self.view.topAnchor
        )
        backgroundImageTopConstraint?.isActive = true
        backgroundImageBottomConstraint = backgroundImage.bottomAnchor.constraint(
            equalTo: self.view.bottomAnchor
        )
        backgroundImageBottomConstraint?.isActive = true
        
        blurEffectView.effect = UIBlurEffect(style: .regular)
        
        self.view.addSubview(blurEffectView)
        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: self.view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        tableView.clipsToBounds = false
        tableView.layer.masksToBounds = false

        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
}
