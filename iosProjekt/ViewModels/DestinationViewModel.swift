//
//  DestinationViewModel.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 20/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

class DestinationViewModel {
    
    private var destinations: [String]?
    
    init() {
        fetchDestinations()
    }
    
    func fetchDestinations() {
        DataController.shared.fetchDestinations { [weak self] (destinations) in
            self?.destinations = destinations
        }
    }
    
    func numberOfDestinations() -> Int {
        return destinations?.count ?? 0
    }
    
    func destination(forRow row: Int) -> String? {
        return destinations?[row]
    }
}
