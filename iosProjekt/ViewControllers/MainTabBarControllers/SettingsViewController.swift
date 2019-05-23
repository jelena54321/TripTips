//
//  SettingsViewController.swift
//  iosProjekt
//
//  Created by five on 22/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController {
    
    //temporary
    let settingsView = UIView()
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(settingsView)
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            settingsView.topAnchor.constraint(equalTo: self.view.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        settingsView.backgroundColor = .blue
        
    }
}
