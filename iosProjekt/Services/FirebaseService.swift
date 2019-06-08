//
//  FirebaseService.swift
//  iosProjekt
//
//  Created by five on 05/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService {
    static var shared = FirebaseService()
    
    func like(todo : ToDo, city : String, category : String) {
        print("todos/\(city)/\(category)/\(todo.name)/likesNumber")
        let todoRef = Database.database().reference(withPath: "todos/\(city)/\(category)/\(todo.name)/likesNumber")
        todoRef.setValue(todo.likesNumber+1)
        
        let userID = Auth.auth().currentUser!.uid

        
        let userLikesRef = Database.database().reference(withPath: "users/\(userID)/likes/\(todo.name)")
        userLikesRef.setValue(todo.toAnyObject())
    }
    
    func unlike(todo : ToDo, city : String, category : String) {
        let ref = Database.database().reference(withPath: "todos/\(city)/\(category)/\(todo.name)/likesNumber")
        print("todos/\(city)/\(category)/\(todo.name)/likesNumber")
        ref.setValue(todo.likesNumber-1)
        
        let userID = Auth.auth().currentUser!.uid
        
        
        let userLikesRef = Database.database().reference(withPath: "users/\(userID)/likes/\(todo.name)")
        userLikesRef.removeValue()
        
    }
}
