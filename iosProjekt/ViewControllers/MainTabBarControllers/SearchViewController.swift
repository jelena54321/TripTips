//
//  SearchViewController.swift
//  iosProjekt
//
//  Created by five on 22/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController : UIViewController {
    
    let searchView = SearchView()
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(searchView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchView.topAnchor.constraint(equalTo: self.view.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
}
