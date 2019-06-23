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
    var city : String?
    var cityName : String? = nil
    var category : String? = nil
    var ref : DatabaseReference? = nil
    var likedTodos = [ToDo]()
    var likedTodosRealtime = [ToDo]()
    let likesRef = Database.database().reference(withPath: "users/\(Auth.auth().currentUser!.uid)/likes")
    var newLikedTodos = [ToDo]()
    var unlikedTodos = [ToDo]()
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
        guard
            let cityName = cityName,
            let category = category else {
            return
        }
        
        newLikedTodos.forEach { todo in
            FirebaseService.shared.like(todo: todo, city: cityName, category: category)
        }
        
        unlikedTodos.forEach { todo in
            FirebaseService.shared.unlike(todo: todo, city: cityName, category: category)
            
        }
        
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
        
        likesRef.observe(.value, with: { snapshot in
            var newItems: [ToDo] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let todo = ToDo(snapshot: snapshot) {
                    newItems.append(todo)
                }
            }
            self.likedTodos = newItems
            self.likedTodosRealtime = newItems
        })
        
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
    
    
    func isLiked(todo: ToDo) -> Bool {
        let liked = likedTodosRealtime + newLikedTodos
        
        return liked.contains(todo)
    }
    
    
    @objc
    func like(_ sender : UIButton) {
        let cell = sender.superview as! ToDoTableViewCell
        guard let currentLikes = Int(cell.likeNumberLabel.text!) else {
            return
        }
        if sender.tag == 1 {
            sender.setImage(UIImage(named: "heartEmpty"), for: .normal)
            sender.tag = 0
            cell.likeNumberLabel.text = "\(currentLikes-1)"
            
            
            if likedTodos.contains(cell.toDo){
                unlikedTodos.append(cell.toDo)
            }
            
            likedTodosRealtime = likedTodos.filter {likedTodo in
                likedTodo != cell.toDo
            }
            
            newLikedTodos = newLikedTodos.filter {likedTodo in
                likedTodo != cell.toDo
            }
        } else {
            sender.setImage(UIImage(named: "heartRed"), for: .normal)
            sender.tag = 1
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.1, animations: {
                    sender.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
                },
                               completion: { bool in
                    UIView.animate(withDuration: 0.1) {
                        sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }
                })
            }
            
            cell.likeNumberLabel.text = "\(currentLikes+1)"
            
            if !likedTodos.contains(cell.toDo) {
                newLikedTodos.append(cell.toDo)
            }
            
            
            
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
    
    @objc
    func addToTrip(_ sender : UIButton) {
        guard let city = city,
              let category = category else {
            return
        }
    
        self.present(
            AddToDoToTripViewController(
                cityTripsViewModel: CityTripsViewModel(
                    city: city,
                    category: category,
                    toDo: (sender.superview as! ToDoTableViewCell).toDo
                )
            ),
            animated: true
        )
    }
}

extension ToDoTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        if let cell = tableView.cellForRow(at: indexPath) as? ToDoTableViewCell {
            
            let liked = isLiked(todo: toDos[indexPath.row])
            
            cell.setup(with: toDos[indexPath.row], liked: liked)
            cell.likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
            cell.tripButton.addTarget(self, action: #selector(addToTrip), for: .touchUpInside)
        } else {
            let liked = isLiked(todo: toDos[indexPath.row])
            
            cell = ToDoTableViewCell(with: toDos[indexPath.row])

            if let cell = cell as? ToDoTableViewCell {
                cell.likeButton.addTarget(self, action: #selector(like), for: .touchUpInside)
                cell.tripButton.addTarget(self, action: #selector(addToTrip), for: .touchUpInside)
                if liked {
                    cell.likeButton.setImage(UIImage(named: "heartRed"), for: .normal)
                    cell.likeButton.tag = 1
                } else {
                    cell.likeButton.setImage(UIImage(named: "heartEmpty"), for: .normal)
                    cell.likeButton.tag = 0
                }
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

