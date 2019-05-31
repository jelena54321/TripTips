//
//  ToDoTableViewController.swift
//  iosProjekt
//
//  Created by five on 24/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class ToDoTableViewController : UIViewController {
    
    private var toDos = [ToDo]()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.navigationController?.navigationBar.layer.shadowRadius = 5
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.2
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingTableView = tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        leadingTableView.priority = UILayoutPriority.defaultLow
        let trailingTableView = tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        trailingTableView.priority = UILayoutPriority.defaultLow
        let topTableView = tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 24)
        topTableView.priority = UILayoutPriority.defaultLow
        let bottomTableView = tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        bottomTableView.priority = UILayoutPriority.defaultLow
        
        NSLayoutConstraint.activate([
            leadingTableView,
            trailingTableView,
            topTableView,
            bottomTableView
            ])
        
        tableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    @objc
    func like(_ sender : UIButton) {
        if sender.tag == 1 {
            sender.setImage(UIImage(named: "heartEmpty.pdf"), for: .normal)
            sender.tag = 0
        } else {
            sender.setImage(UIImage(named: "heartRed.pdf"), for: .normal)
            sender.tag = 1
        }
    }
}

extension ToDoTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        //temporary
        let toDo = ToDo(name: "Museum-museum", image: "https://www.londonpass.com/siteimg/newpages/london%20museums%20V&A.jpg", description: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC.")
        
        if let cell = tableView.cellForRow(at: indexPath) as? ToDoTableViewCell {
            cell.setup(with: toDo)
            cell.likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
        } else {
            cell = ToDoTableViewCell(with: toDo)
            if let cell = cell as? ToDoTableViewCell {
                cell.likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
            }
        }
        cell.selectionStyle = .none
        return cell
    }
}

extension ToDoTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
}

