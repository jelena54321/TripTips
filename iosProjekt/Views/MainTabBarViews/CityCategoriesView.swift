//
//  CityCategoriesView.swift
//  iosProjekt
//
//  Created by five on 24/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class CityCategoriesView : UIView {
    
    let backgroundImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }

    func setupView(){
        self.addSubviews()
        self.styleSubviews()
        self.positionSubviews()
    }

    func addSubviews(){
        self.addSubview(backgroundImage)
    }

    func styleSubviews(){
        self.backgroundColor = .white
        }

    func positionSubviews(){

    }
}

