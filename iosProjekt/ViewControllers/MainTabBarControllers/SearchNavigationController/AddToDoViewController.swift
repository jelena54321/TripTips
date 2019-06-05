//
//  AddToDoViewController.swift
//  iosProjekt
//
//  Created by five on 05/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class AddToDoViewController : UIViewController {
    
    let addToDoView = AddToDoView()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(addToDoView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        
        addToDoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addToDoView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
            addToDoView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.85),
            addToDoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            addToDoView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        
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
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc
    func dismissKeyboard(){
        if isEditing {
            view.endEditing(true)
        } else {
            
            
            UIView.animate(withDuration: 0.2, animations: {
                self.view.backgroundColor = .clear
            }) { bool in
                self.dismiss(animated: true)
            }
        }
    
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
    
    
    
}
