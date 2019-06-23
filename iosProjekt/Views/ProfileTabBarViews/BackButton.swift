//
//  BackButton.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 19/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

class BackButton: UIButton {
    
    private let imageIcon: UIImageView = {
        let imageIcon = UIImageView()
        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        return imageIcon
    }()
    
    private let buttonLabel: UILabel = {
        let buttonLabel = UILabel()
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        return buttonLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        imageIcon.image = UIImage(
            cgImage: UIImage(named: "arrow.png")!.cgImage!,
            scale: 1.0,
            orientation: UIImage.Orientation.upMirrored
        )
        
        addSubview(imageIcon)
        NSLayoutConstraint.activate([
            imageIcon.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageIcon.topAnchor.constraint(equalTo: self.topAnchor),
            imageIcon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageIcon.heightAnchor.constraint(equalToConstant: 20.0),
            imageIcon.widthAnchor.constraint(equalToConstant: 20.0)
        ])
        
        buttonLabel.text = "back"
        buttonLabel.font = UIFont(name: "Montserrat-Regular", size: 14)
        
        addSubview(buttonLabel)
        NSLayoutConstraint.activate([
            buttonLabel.leftAnchor.constraint(equalTo: imageIcon.rightAnchor),
            buttonLabel.heightAnchor.constraint(equalTo: imageIcon.heightAnchor),
            buttonLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            buttonLabel.widthAnchor.constraint(equalToConstant: 40.0)
        ])
    }
}
