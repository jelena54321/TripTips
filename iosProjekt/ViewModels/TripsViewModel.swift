//
//  TripsViewModel.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 21/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

struct TripsTableViewCellModel {
    
    let destination: String
    let departureDate: String
    let returnDate: String
    let image: String
    
    init(trip: Trip, city: City) {
        self.destination = trip.destination
        self.departureDate = trip.departureDate
        self.returnDate = trip.returnDate
        self.image = city.image
    }
}

class TripsViewModel {
    
    private var trips: [Trip]?
    private var cities: [String: City]?
    
    func fetchTrips(onComplete: @escaping (() -> Void)) {
        DataController.shared.fetchTrips { (trips) in
            if let trips = trips {
                self.trips = trips
                
                DataController.shared.fetchCities { (cities) in
                    if let cities = cities {
                        self.cities = TripsViewModel.mapCitiesByName(cities: cities)
                          onComplete()
                    }
                }
            }
        }
    }
    
    func numberOfTrips() -> Int {
        return trips?.count ?? 0
    }
    
    func cellModel(forRow row: Int) -> TripsTableViewCellModel? {
        guard let trips = trips,
              let cities = cities else {
            return nil
        }
        
        let trip = trips[row]
        if let city = cities[trip.destination] {
            return TripsTableViewCellModel(
                trip: trip,
                city: city
            )
        }
        
        return nil
    }
    
    func model(forRow row: Int) -> ToDosViewModel? {
        guard let trips = trips else {
            return nil
        }
        
        return ToDosViewModel(trip: trips[row])
    }
    
    private static func mapCitiesByName(cities: [City]) -> [String: City] {
        return Dictionary(
            uniqueKeysWithValues: cities.map { (city) -> (String, City) in
                return (city.name, city)
            }
        )
    }
}
