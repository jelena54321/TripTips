//
//  ToDoTableViewController.swift
//  iosProjekt
//
//  Created by five on 24/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ToDoTableViewController : UIViewController {
    
    var toDos = [ToDo]()
    let tableView = UITableView()
    var cityName : String? = nil
    var category : String? = nil
    var ref : DatabaseReference? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard
            let cityName = cityName,
            let category = category  else {
                return
        }
        
        ref = Database.database().reference(withPath: "todos/\(cityName)/\(category)")
        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.navigationController?.navigationBar.layer.shadowRadius = 5
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.2
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(add))
        
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
        
        if ref != nil {
            ref?.observe(.value, with: { snapshot in
                var newItems: [ToDo] = []
                for child in snapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let todo = ToDo(snapshot: snapshot) {
                        newItems.append(todo)
                    }
                }
                self.toDos = newItems
                self.tableView.reloadData()
            })
        }
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
    
    @objc
    func add() {
        let addToDoViewController = AddToDoViewController()
        addToDoViewController.modalPresentationStyle = .overCurrentContext
        addToDoViewController.category = self.category
        addToDoViewController.cityName = self.cityName
        DispatchQueue.main.async {
            self.tabBarController?.present(addToDoViewController, animated: true) {
                UIView.animate(withDuration: 0.2) {
                    addToDoViewController.backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                }
            }
        }
    }
}

extension ToDoTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        if let cell = tableView.cellForRow(at: indexPath) as? ToDoTableViewCell {
            cell.setup(with: toDos[indexPath.row])
            cell.likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
        } else {
            cell = ToDoTableViewCell(with: toDos[indexPath.row])
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

