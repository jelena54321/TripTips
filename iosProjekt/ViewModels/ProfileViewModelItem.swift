//
//  File.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 19/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

enum ProfileViewModelItemType {
    
    case usernameAndEmail
    case password
    case myLikes
    case myTrips
}

protocol ProfileViewModelItem {
    
    var type: ProfileViewModelItemType { get }
    
    var rowCount: Int { get }
    
    func cellModel(forRow row: Int) -> ProfileTableCellViewModel?
    
    func model(forRow row: Int) -> FieldViewModel?
}

extension ProfileViewModelItem {
    
    var rowCount: Int {
        return 1
    }
    
    func cellModel(forRow row: Int) -> ProfileTableCellViewModel? {
        return nil
    }
    
    func model(forRow: Int) -> FieldViewModel? {
        return nil
    }
}
