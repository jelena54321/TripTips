//
//  User.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 18/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let username: String
    let email: String
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let username = value["username"] as? String,
            let email = value["email"] as? String else {
                
                return nil
        }
        
        self.username = username
        self.email = email
    }
}

extension User {
    subscript(key: String) -> Any? {
        for child in Mirror(reflecting: self).children {
            if child.label == key { return child.value }
        }
        
        return nil
    }
}
