//
//  ToDosViewModel.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 22/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

struct CityTripsCellViewModel {
    
    let destination: String
    let departureDate: String
    let returnDate: String
    
    init(trip: Trip) {
        self.destination = trip.destination
        self.departureDate = trip.departureDate
        self.returnDate = trip.returnDate
    }
}

class CityTripsViewModel {
    
    private let city: String
    private let category: String
    private let toDo: ToDo
    private var trips: [Trip]?
    
    init(city: String, category: String, toDo: ToDo) {
        self.city = city
        self.category = category
        self.toDo = toDo
    }
    
    func fetchTrips(onComplete: @escaping (() -> Void)) {
        DataController.shared.fetchTrips(forCity: city) { (trips) in
            if let trips = trips {
                self.trips = trips
                onComplete()
            }
        }
    }
    
    func numberOfTrips() -> Int {
        return trips?.count ?? 0
    }
    
    func cellModel(forRow row: Int) -> CityTripsCellViewModel? {
        guard let trips = trips else {
            return nil
        }
        
        return CityTripsCellViewModel(trip: trips[row])
    }
    
    func addToDo(toTripAtRow row: Int, onComplete: @escaping ((UpdateStatus) -> Void)) {
        guard let trips = trips else {
            onComplete(UpdateStatus.FAILURE)
            return
        }
        
        DataController.shared.addToDo(
        toDo,
        toTrip: trips[row],
        forCategory: category) { (updateStatus) in
            onComplete(updateStatus)
        }
    }

}
