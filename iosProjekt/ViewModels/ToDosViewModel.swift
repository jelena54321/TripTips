//
//  ToDosViewModel.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 23/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

struct ToDosTableCellViewModel {
    
    let name: String
    let description: String
    let image: String
    
    init(toDo: ToDo) {
        self.name = toDo.name
        self.description = toDo.description
        self.image = toDo.image
    }
}

class ToDosViewModel {
    
    private var toDos: [ToDo]?
    private let trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
    }
    
    func fetchToDos(onComplete: @escaping (() -> Void)) {
        DataController.shared.fetchToDos(forTrip: trip, onComplete: { [weak self] (toDos) in
            if let toDos = toDos {
                self?.toDos = toDos
                onComplete()
            }
        })
    }
    
    func numberOfToDos() -> Int {
        return toDos?.count ?? 0
    }
    
    func cellModel(forRow row: Int) -> ToDosTableCellViewModel? {
        guard let toDos = toDos else {
            return nil
        }
        
        return ToDosTableCellViewModel(toDo: toDos[row])
    }

}
