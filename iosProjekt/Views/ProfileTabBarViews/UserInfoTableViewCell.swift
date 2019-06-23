//
//  ProfileTableViewCell.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 18/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

class UserInfoTableViewCell: ProfileTableViewCell {
    
    private let fieldLabel: UILabel = {
        let fieldLabel = UILabel()
        fieldLabel.translatesAutoresizingMaskIntoConstraints = false
        return fieldLabel
    }()
    
    private let valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        return valueLabel
    }()
    
    private let arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        return arrowImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        fieldLabel.font = UIFont(name: "Montserrat-Bold", size: 14)
        
        addSubview(fieldLabel)
        NSLayoutConstraint.activate([
            fieldLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20.0),
            fieldLabel.widthAnchor.constraint(equalToConstant: 100.0),
            fieldLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            fieldLabel.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        valueLabel.font = UIFont(name: "Montserrat-Thin", size: 14)
        
        addSubview(valueLabel)
        NSLayoutConstraint.activate([
            valueLabel.leftAnchor.constraint(equalTo: fieldLabel.rightAnchor, constant: 20.0),
            valueLabel.widthAnchor.constraint(equalToConstant: 230.0),
            valueLabel.centerYAnchor.constraint(equalTo: fieldLabel.centerYAnchor),
            valueLabel.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        arrowImageView.image = UIImage(named: "arrow.png")
        
        addSubview(arrowImageView)
        NSLayoutConstraint.activate([
            arrowImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20.0),
            arrowImageView.widthAnchor.constraint(equalToConstant: 20.0),
            arrowImageView.heightAnchor.constraint(equalToConstant: 20.0),
            arrowImageView.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor)
        ])
    }
    
    override func prepareForReuse() {
        fieldLabel.text = ""
        valueLabel.text = ""
    }
    
    override func setUp(withModel model: ProfileTableCellViewModel) {
        fieldLabel.text = model.field
        fieldLabel.textAlignment = .right
        valueLabel.text = model.value
    }

}
