//
//  ViewModelPasswordItem.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 19/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

class ViewModelPasswordItem: ProfileViewModelItem {
    
    var type: ProfileViewModelItemType {
        return .password
    }
    
    func cellModel(forRow row: Int) -> ProfileTableCellViewModel? {
        return ProfileTableCellViewModel(field: "password", value: "")
    }
    
    func model(forRow row: Int) -> FieldViewModel? {
        return FieldViewModel(
            field: "password",
            secured: true
        )
    }
}
