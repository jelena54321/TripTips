//
//  UserViewModel.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 18/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import Firebase

struct ProfileTableCellViewModel {
    
    let field: String
    let value: String
    
    init(field: String, value: String) {
        self.field = field
        self.value = value
    }
}


class ProfileViewModel {
    
    private var items = [ProfileViewModelItem]()
    
    func fetchCurrentUser(onComplete: @escaping (() -> Void)) {
        DataController.shared.fetchCurrentUser { [weak self] (user) in
            if let user = user {
                self?.initItemsFor(user: user)
            }
            
            onComplete()
        }
    }
    
    func itemType(forSection section: Int) -> ProfileViewModelItemType {
        return items[section].type
    }
    
    func cellModel(forIndexPath indexPath: IndexPath) -> ProfileTableCellViewModel? {
        if indexPath.section < 0 || indexPath.section > items.count - 1 {
            return nil
        }
        
        return items[indexPath.section].cellModel(forRow: indexPath.row)
    }
    
    func model(forIndexPath indexPath: IndexPath) -> FieldViewModel? {
        if indexPath.section < 0 || indexPath.section > items.count - 1 {
            return nil
        }
        
        return items[indexPath.section].model(forRow: indexPath.row)
    }
    
    func numberOfRows(forSection section: Int) -> Int {
        if section < 0 || section > items.count - 1 {
            return 0
        }
        
        return items[section].rowCount
    }
    
    func numberOfSections() -> Int {
        return items.count
    }
    
    private func initItemsFor(user: User) {
        items.append(ViewModelUsernameAndEmailItem(user: user))
        items.append(ViewModelPasswordItem())
        items.append(ViewModelLikesItem())
        items.append(ViewModelTripsItem())
    }
}
