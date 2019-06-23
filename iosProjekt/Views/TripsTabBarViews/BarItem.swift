//
//  BarItem.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 21/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class BarItem: UIButton {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init()
        label.text = text
        label.textAlignment = .center
    }
    
    func setText(text: String) {
        label.text = text
        label.textAlignment = .center
    }
    
    private func setUpUI() {
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
