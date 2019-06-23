//
//  ProfileTableViewCell.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 20/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    func setUp(withModel: ProfileTableCellViewModel) {}

}
