//
//  ViewModelUsernameAndEmailItem.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 19/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

class ViewModelUsernameAndEmailItem: ProfileViewModelItem {
    
    private static let fields: [String] = ["username", "email"]
    private var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var type: ProfileViewModelItemType {
        return .usernameAndEmail
    }
    
    var rowCount: Int {
        return 2
    }
    
    public func cellModel(forRow row: Int) -> ProfileTableCellViewModel? {
        let field = ViewModelUsernameAndEmailItem.fields[row]
        if let value = user[field] as? String {
            return ProfileTableCellViewModel(
                field: field,
                value: value
            )
        }
        
        return nil
    }
    
    public func model(forRow row: Int) -> FieldViewModel? {
        return FieldViewModel(
            field: ViewModelUsernameAndEmailItem.fields[row],
            secured: false
        )
    }
}
