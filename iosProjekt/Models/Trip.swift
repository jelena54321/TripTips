//
//  Trip.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 21/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import Firebase

class Trip {
    
    let id: String
    let departureDate: String
    let returnDate: String
    let destination: String
    let toDos: [String: [String]]?
    
    init(departureDate: String, returnDate: String, destination: String) {
        self.id = UUID().uuidString
        self.departureDate = departureDate
        self.returnDate = returnDate
        self.destination = destination
        self.toDos = [String: [String]]()
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let id = value["id"] as? String,
            let returnDate = value["returnDate"] as? String,
            let departureDate = value["departureDate"] as? String,
            let destination = value["destination"] as? String else {
                
                return nil
        }
        
        self.id = id
        self.returnDate = returnDate
        self.departureDate = departureDate
        self.destination = destination
        
        if let snapshot = value["toDos"] as? [String: Any] {
            self.toDos = Trip.parseToDos(snapshot: snapshot)
        } else {
            self.toDos = nil
        }
    }
    
    private static func parseToDos(snapshot: [String: Any]) -> [String: [String]]? {
        var toDos = [String: [String]]()
        for (key, value) in snapshot {
            if let dict = value as? [String: String] {
                toDos[key] = dict.map { (key, value) -> String in
                    return value
                }
            } else {
                return nil
            }
        }
        
        return toDos
    }
    
    func getDestinationName() -> String {
        guard let cityName = destination.components(separatedBy: ",").first else {
            return ""
        }
        
        return cityName
    }
    
    var numberOfToDos: Int {
        get {
            var count = 0
            toDos?.forEach { (key, value) -> Void in
                count += value.count
            }
            
            return count
        }
    }
}
