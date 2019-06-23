//
//  FieldViewModel.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 18/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

class FieldViewModel {
    
    private var field: String!
    private var secured: Bool!
    
    init(field: String, secured: Bool) {
        self.field = field
        self.secured = secured
    }
    
    func getField() -> String {
        return field
    }
    
    func isSecured() -> Bool {
        return secured
    }
    
    func updateField(newValue: String, onComplete: @escaping ((UpdateStatus) -> Void)) {
        switch field {
        case "email":
            DataController.shared.updateEmail(
                email: newValue,
                onComplete: onComplete
            )
        case "password":
            DataController.shared.updatePassword(
                password: newValue,
                onComplete: onComplete
            )
        default:
            DataController.shared.updateField(
                field: field,
                newValue: newValue,
                onComplete: onComplete
            )
        }
    }
}
