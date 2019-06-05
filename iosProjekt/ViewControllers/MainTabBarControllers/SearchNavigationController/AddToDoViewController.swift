//
//  AddToDoViewController.swift
//  iosProjekt
//
//  Created by five on 05/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddToDoViewController : UIViewController {
    
    let addToDoView = AddToDoView()
    let backgroundView = UIView()
    var category : String? = nil
    var cityName : String? = nil
    var yAnchor : NSLayoutConstraint? = nil
    var keyboardUp = false
    
    
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(backgroundView)
        self.view.addSubview(addToDoView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        let backgroundTap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        
        view.addGestureRecognizer(tap)
        backgroundView.addGestureRecognizer(backgroundTap)
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        
        yAnchor = addToDoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        
        addToDoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToDoView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
            addToDoView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.85),
            addToDoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            yAnchor!
            ])
        
        backgroundView.backgroundColor = .clear
        
        addToDoView.clipsToBounds = false
        addToDoView.layer.masksToBounds = false
        
        addToDoView.layer.shadowColor = UIColor.black.cgColor
        addToDoView.layer.shadowOffset = CGSize(width: 5, height: 5)
        addToDoView.layer.shadowRadius = 5
        addToDoView.layer.shadowOpacity = 0.2
        addToDoView.layer.cornerRadius = 22.5
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            }
        }
        
        addToDoView.imageField.addTarget(self, action: #selector(loadImage), for: .editingDidEnd)
        addToDoView.addButton.addTarget(self, action: #selector(addPlace), for: .touchUpInside)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification , object:nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func dismissController(){

        if keyboardUp {
            dismissKeyboard()
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.backgroundView.backgroundColor = .clear
            }) { bool in
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc
    func loadImage() {
        let urlString = self.addToDoView.imageField.text
        print("pocinjem")
        ImageService.shared.fetchImage(imageUrl: urlString){ (image) in
            if image != nil {
                DispatchQueue.main.async {
                    print("ima slike")
                    self.addToDoView.imageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    print("nema slike")
                    self.addToDoView.imageView.image = UIImage(named: "sight")
                }
            }
        }
        
    }
    
    @objc
    func addPlace(){
        guard
            let imageUrl = self.addToDoView.imageField.text,
            let name = self.addToDoView.nameField.text,
            let description = self.addToDoView.descriptionField.text,
            let cityName = self.cityName,
            let category = self.category else {
                return
        }
        
        let todo = ToDo(name: name, image: imageUrl, description: description)
        let ref = Database.database().reference(withPath: "todos/\(cityName)/\(category)/\(name)")
        
        ref.setValue(todo.toAnyObject())
        keyboardUp = false
        dismissController()

    }
    
    @objc
    func keyBoardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        self.keyboardUp = true
        guard let yAnchor = self.yAnchor else {
            return
        }
        
        yAnchor.constant = -keyboardHeight
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc
    func keyBoardWillHide(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        self.keyboardUp = false
        print(keyboardHeight)
        guard let yAnchor = self.yAnchor else {
            return
        }
        
        yAnchor.constant = 0

        UIView.animate(withDuration: 0.2){
            self.view.layoutIfNeeded()
        }
    }
}
