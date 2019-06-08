//
//  ToDo.swift
//  iosProjekt
//
//  Created by five on 24/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import Firebase

struct ToDo {
    
    let ref: DatabaseReference?
    let name : String
    let description : String
    let image : String
    let likesNumber : Int
    
    
    init(name: String, image: String, description: String) {
        self.ref = nil
        self.name = name
        self.image = image
        self.description = description
        self.likesNumber = 0
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let image = value["image"] as? String,
            let description = value["description"] as? String,
            let likesNumber = value["likesNumber"] as? Int else {
                return nil
        }
        
        
        self.ref = snapshot.ref
        self.name = name
        self.image = image
        self.description = description
        self.likesNumber = likesNumber
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "description": description,
            "image": image,
            "likesNumber": likesNumber
        ]
    }
}

extension ToDo : Equatable {
    static func == (lhs: ToDo, rhs: ToDo) -> Bool {
        return
            lhs.name == rhs.name &&
                lhs.description == rhs.description &&
                lhs.image == rhs.image
    }
}
