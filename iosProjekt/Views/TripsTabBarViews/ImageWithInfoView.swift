//
//  ImageWithInfoView.swift
//  iosProjekt
//
//  Created by Jelena Šarić on 20/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class ImageWithInfoView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        return infoLabel
    }()
    
    private var infoLabelWidthConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImage(image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = image
        }
    }
    
    func setInfo(info: String) {
        infoLabel.text = info
        infoLabel.textAlignment = .center
        infoLabelWidthConstraint.constant = 15 + infoLabel.intrinsicContentSize.width + 15
    }
    
    func setInfoBackgroundColor(color: UIColor) {
        infoLabel.backgroundColor = color
    }
    
    func setInfoColor(color: UIColor) {
        infoLabel.textColor = color
    }
    
    private func setUpUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true;
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20.0)
        ])
        
        infoLabel.font = UIFont(name: "Montserrat-Bold", size: 20)
        infoLabel.layer.cornerRadius = 20.0
        infoLabel.layer.masksToBounds = true
        
        addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        infoLabelWidthConstraint = infoLabel.widthAnchor.constraint(
            equalToConstant: 20 + infoLabel.intrinsicContentSize.width + 20
        )
        infoLabelWidthConstraint.isActive = true
    }
}
