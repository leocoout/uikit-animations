//
//  CurvesViewController.swift
//  Animations
//
//  Created by Leonardo Santos on 28/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class CurvesViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var animatedView: UIView!
    
    // MARK: Properties
    var endPos: CGRect {
        return CGRect(x: UIScreen.main.bounds.size.width - animatedView.frame.size.width - 24,
                      y: animatedView.frame.origin.y,
                      width: animatedView.frame.size.width,
                      height: animatedView.frame.size.height)
    }
    
    var curves: UIView.AnimationOptions = .curveLinear
    
    @IBAction func linearAnimation(_ sender: Any) {
        curves = .curveLinear
        playAnimation()
    }
    
    @IBAction func easeInAnimation(_ sender: Any) {
        curves = .curveEaseIn
        playAnimation()
    }
    
    @IBAction func easeOutAnimation(_ sender: Any) {
        curves = .curveEaseOut
        playAnimation()
    }
    
    @IBAction func easeInOutAnimation(_ sender: Any) {
        curves = .curveEaseInOut
        playAnimation()
    }
gi
    private func playAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options: [curves, .autoreverse, .repeat], animations: {
            self.animatedView.frame = self.endPos
        }, completion: nil)
    }
    
}
