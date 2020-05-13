//
//  UIViewExtensions.swift
//  Animations
//
//  Created by Leonardo Santos on 13/05/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow() {
        layer.shadowColor = UIColor(red:0.39, green:0.44, blue:0.53, alpha:1.0).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowOpacity = 0.35
        layer.masksToBounds = false
        layer.shadowRadius = 6
    }
}

