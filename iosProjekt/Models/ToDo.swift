//
//  ToDo.swift
//  iosProjekt
//
//  Created by five on 24/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

struct ToDo {
    let name : String
    let description : String
    let image : String
    
    
    init(name: String, image: String, description: String) {
        self.name = name
        self.image = image
        self.description = description
    }
}
