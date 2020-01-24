//
//  NeumorphismButton.swift
//  Animations
//
//  Created by Leonardo Santos on 27/12/19.
//  Copyright © 2019 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class NeumorphismButton: UIViewController {
    
    @IBOutlet weak var testButton: UIButton!
    
}

class NeumorphicButton: UIButton {

    let layer1: CALayer = {
        let layer = CALayer()
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.backgroundColor = UIColor.clear.cgColor
        
        return layer
    }()
    
    let layer2 = CALayer(),
    layer3 = CALayer(),
    layer4 = CALayer(),
    layer5 = CALayer(),
    layer6 = CALayer(),
    layer7 = CALayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addTarget(self, action:#selector(BtnPressed(_:)), for: UIControl.Event.touchDown)
        self.addTarget(self, action:#selector(BtnReleased(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func BtnPressed(_ sender: UIButton) {
        
        layer2.applySketchShadow(color: .clear, alpha: 1, x: -8, y: -8, blur: 20)
        layer3.applySketchShadow(color: .clear, alpha: 1, x: 8, y: 8, blur: 21)
        
        layer4.applySketchShadow(color: .white, alpha: 1, x: frame.size.width, y: 0, blur: 21)
        layer5.applySketchShadow(color: .white, alpha: 1, x: 0, y: frame.size.height, blur: 21)
        
        layer6.applySketchShadow(color: .black, alpha: 0.5, x: frame.size.width * -1, y: 0, blur: 21)
        layer7.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: frame.size.height * -1, blur: 21)
        
        [layer3, layer4, layer5, layer6, layer7].forEach {
            $0.masksToBounds = true
        }
        
        layer1.backgroundColor = UIColor.clear.cgColor
    }

      @objc func BtnReleased(_ sender: UIButton) {
        
        let topLeftColor = UIColor(red:0.96, green:0.95, blue:0.95, alpha:1.0)
        let bottomRightColor = UIColor(red:0.91, green:0.89, blue:0.88, alpha:1.0)
        
        layer2.applySketchShadow(color: topLeftColor, alpha: 1, x: -8, y: -8, blur: 20)
        layer3.applySketchShadow(color: bottomRightColor, alpha: 1, x: 8, y: 8, blur: 21)
        
        layer6.applySketchShadow(color: .clear, alpha: 0.5, x: frame.size.width * -1, y: 0, blur: 21)
        layer7.applySketchShadow(color: .clear, alpha: 0.5, x: 0, y: frame.size.height * -1, blur: 21)
        
        layer6.masksToBounds = true
        layer7.masksToBounds = true
        
        layer1.backgroundColor = UIColor(red:0.94, green:0.93, blue:0.93, alpha:1.0).cgColor
    }
      

    override func layoutSubviews() {
        super.layoutSubviews()
        
        [layer1, layer2, layer3, layer4, layer5, layer6, layer7].forEach {
            $0.frame = layer.bounds
            layer.insertSublayer($0, at: 0)
        }
    }
}

extension CALayer {
    func applySketchShadow(
        color: UIColor,
        alpha: Float = 1,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4) {
        
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = 4
        
        shadowPath = UIBezierPath(rect: bounds.insetBy(dx: 0, dy: 0)).cgPath
    
        masksToBounds = false
    }
}
