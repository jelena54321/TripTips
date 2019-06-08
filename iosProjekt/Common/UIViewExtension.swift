//
//  UIViewExtension.swift
//  iosProjekt
//
//  Created by five on 08/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func shakeByX() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 6, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 6, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    func shakeByY() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y - 6))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y + 6))
        self.layer.add(animation, forKey: "position")
    }
}
