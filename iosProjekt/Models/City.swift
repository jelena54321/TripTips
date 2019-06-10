//
//  City.swift
//  iosProjekt
//
//  Created by five on 23/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import Firebase

struct City{
    
    let ref: DatabaseReference?
    let name: String
    let image: String
    let description: String
    
    init(name: String, image: String, description: String) {
        self.ref = nil
        self.name = name
        self.image = image
        self.description = description
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let image = value["image"] as? String,
            let description = value["description"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.name = name
        self.image = image
        self.description = description
    }
    
    func getCityName() -> String {
        guard let cityName = name.components(separatedBy: ",").first else {
            return ""
        }
        
        return cityName
    }
    
    func getCountryName() -> String {
        guard let countryName = name.components(separatedBy: ", ").last else {
            return ""
        }
        return countryName
    }
    
}
