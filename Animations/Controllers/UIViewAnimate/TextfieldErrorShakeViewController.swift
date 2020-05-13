//
//  TextfieldErrorShake.swift
//  Animations
//
//  Created by Leonardo Santos on 23/12/19.
//  Copyright © 2019 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class TextfieldErrorShake: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet var customTextfield: CustomTextField!
    
    // MARK: Actions
    @IBAction func didTapButton(_ sender: Any) {
        validateFields([customTextfield])
    }
    
    private func validateFields(_ textfields: [CustomTextField]) {
        textfields.forEach {
            customTextfield.validate($0)
        }
    }
}
