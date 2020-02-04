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

    // MARK: Properties
    lazy var textfield: UITextField = {
        let textfield = UITextField(frame: CGRect(x: 0, y: 0, width: 400, height: 32))
        textfield.placeholder = "Textfield exemplo"
        textfield.borderStyle = UITextField.BorderStyle.roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Validar", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1539083421, green: 0.5388586521, blue: 0.8937068582, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(textfield)
        view.addSubview(button)
        
        textfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        textfield.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        textfield.heightAnchor.constraint(equalToConstant: 42).isActive = true
        textfield.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -104).isActive = true

        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        button.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        button.titleLabel?.text = "Validar"
    }
    
    @objc private func didTapConfirmButton() {
        validateFields([textfield])
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
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 100, options: [.curveEaseInOut], animations: {
            textField.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

