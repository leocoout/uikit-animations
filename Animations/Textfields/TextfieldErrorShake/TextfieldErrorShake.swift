//
//  TextfieldErrorShake.swift
//  Animations
//
//  Created by Leonardo Santos on 23/12/19.
//  Copyright © 2019 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class TextfieldErrorShake: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBAction func didTapConfirmButton(_ sender: Any) {
        validateFields([emailTextfield])
    }
    
    private func validateFields(_ textfields: [UITextField]) {
        textfields.forEach {
            if $0.text == "" {
                shakeField(textfield: $0)
            }
        }
    }
    
    private func shakeField(textfield: UITextField?) {
        guard let textField = textfield else { return }
        
        textField.transform = CGAffineTransform(translationX: 15, y: 0)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 50, options: [.curveEaseInOut], animations: {
            textField.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

