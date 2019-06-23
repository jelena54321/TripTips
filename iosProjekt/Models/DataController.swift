//
//  DataController.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 18/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import Firebase

enum UpdateStatus {
    case SUCCESS
    case FAILURE
}

class DataController {
    
    private static let users = Database.database().reference(withPath: "users")
    private static let cities = Database.database().reference(withPath: "cities")
    private static let toDos = Database.database().reference(withPath: "todos")
    
    static let shared = DataController()
    
    private init() {}
    
    func fetchCurrentUser(onComplete: @escaping ((User?) -> Void)) {
        guard let firebaseUser = Auth.auth().currentUser else {
            onComplete(nil)
            return
        }
        
        DataController.users.child(firebaseUser.uid).observe(
            .value,
            with: { (snapshot) in
                onComplete(User(snapshot: snapshot))
            }
        )
    }
    
    func updateField(field: String, newValue: String, onComplete: @escaping ((UpdateStatus) -> Void)) {
        guard let firebaseUser = Auth.auth().currentUser else {
            onComplete(UpdateStatus.FAILURE)
            return
        }
        
        DataController.users.child(firebaseUser.uid)
                            .child(field)
                            .setValue(newValue)
        onComplete(UpdateStatus.SUCCESS)
    }
    
    func updateEmail(email: String, onComplete: @escaping ((UpdateStatus) -> Void)) {
        guard let firebaseUser = Auth.auth().currentUser else {
            onComplete(UpdateStatus.FAILURE)
            return
        }
        
        firebaseUser.updateEmail(to: email) { [weak self] (error) in
            if error != nil {
                onComplete(UpdateStatus.FAILURE)
                return
            }
            
            self?.updateField(field: "email", newValue: email, onComplete: onComplete)
        }
    }
    
    func updatePassword(password: String, onComplete: @escaping((UpdateStatus) -> Void)) {
        guard let firebaseUser = Auth.auth().currentUser else {
            onComplete(UpdateStatus.FAILURE)
            return
        }
        
        firebaseUser.updatePassword(to: password) { (error) in
            if error != nil {
                onComplete(UpdateStatus.FAILURE)
            } else {
                onComplete(UpdateStatus.SUCCESS)
            }
        }
    }
    
    func fetchDestinations(onComplete: @escaping (([String]) -> Void)) {
        DataController.cities.observe(
            .value,
            with: { (snapshot) in
                var destinations = [String]()
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let dictionary = childSnapshot.value as? [String: AnyObject],
                       let city = dictionary["name"] as? String {
                        destinations.append(city)
                    }
                }
                
                onComplete(destinations)
            }
        )
    }
    
    func createTrip(trip: Trip, onComplete: @escaping ((UpdateStatus) -> Void)) {
        guard let firebaseUser = Auth.auth().currentUser else {
            onComplete(UpdateStatus.FAILURE)
            return
        }
        
        DataController.users.child(firebaseUser.uid)
            .child("trips")
            .child(trip.id)
            .setValue(
                [
                    "id": trip.id,
                    "departureDate": trip.departureDate,
                    "returnDate": trip.returnDate,
                    "destination": trip.destination
                ]
            )
        onComplete(UpdateStatus.SUCCESS)
    }
    
    func fetchTrips(onComplete: @escaping (([Trip]?) -> Void)) {
        guard let firebaseUser = Auth.auth().currentUser else {
            onComplete(nil)
            return
        }
        
        DataController.users
                      .child(firebaseUser.uid)
                      .child("trips")
                      .observe(
            .value,
            with: { (snapshot) in
                var destinations = [Trip]()
                for child in snapshot.children {
                    if
                        let childSnapshot = child as? DataSnapshot,
                        let trip = Trip(snapshot: childSnapshot) {
                        
                        destinations.append(trip)
                    } else {
                        onComplete(nil)
                        return
                    }
                }
                
                onComplete(destinations)
            }
        )
    }
    
    func fetchCities(onComplete: @escaping (([City]?) -> Void)) {
        DataController.cities.observe(
            .value,
            with: { (snapshot) in
                var cities = [City]()
                for child in snapshot.children {
                    if
                        let childSnapshot = child as? DataSnapshot,
                        let city = City(snapshot: childSnapshot) {
                        
                        cities.append(city)
                    } else {
                        onComplete(nil)
                        return
                    }
                }
                
                onComplete(cities)
            }
        )
    }
    
    func fetchTrips(forCity city: String, onComplete: @escaping (([Trip]?) -> Void)) {
        guard let firebaseUser = Auth.auth().currentUser else {
            onComplete(nil)
            return
        }
        
        DataController.users
            .child(firebaseUser.uid)
            .child("trips")
            .queryOrdered(byChild: "destination")
            .queryEqual(toValue: city)
            .observe(
                .value,
                with: { (snapshot) in
                    var trips = [Trip]()
                    for child in snapshot.children {
                        if
                            let childSnapshot = child as? DataSnapshot,
                            let trip = Trip(snapshot: childSnapshot) {
                            
                            trips.append(trip)
                        } else {
                            onComplete(nil)
                            return
                        }
                    }
                    
                    onComplete(trips)
            }
        )
    }
    
    func addToDo(_ toDo: ToDo, toTrip trip: Trip, forCategory category: String, onComplete: @escaping ((UpdateStatus) -> Void)) {
        guard let firebaseUser = Auth.auth().currentUser else {
            onComplete(UpdateStatus.FAILURE)
            return
        }
        
        DataController.users.child(firebaseUser.uid)
            .child("trips")
            .child(trip.id)
            .child("toDos")
            .child(category)
            .childByAutoId()
            .setValue(toDo.name)
        
        onComplete(UpdateStatus.SUCCESS)
    }
    
    func fetchToDos(forTrip trip: Trip, onComplete: @escaping (([ToDo]?) -> Void)) {
        guard let tripToDos = trip.toDos else {
            onComplete(nil)
            return
        }
        
        var toDos = [ToDo]()
        for (category, values) in tripToDos {
            for value in values {
                DataController.toDos
                    .child(trip.getDestinationName())
                    .child(category)
                    .child(value)
                    .observe(
                        .value,
                        with: { (snapshot) in
                            if let toDoObject = ToDo(snapshot: snapshot) {
                                toDos.append(toDoObject)
                                
                                if toDos.count == trip.numberOfToDos {
                                    onComplete(toDos)
                                }
                            }
                    }
                )
            }
        }
    }
        
}
