//
//  PlansViewController.swift
//  iosProjekt
//
//  Created by five on 22/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class PlansViewController : UIViewController {
    
    //temporary
    let plansView = UIView()
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(plansView)
        
        plansView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plansView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            plansView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            plansView.topAnchor.constraint(equalTo: self.view.topAnchor),
            plansView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        plansView.backgroundColor = .red
        
    }
}
