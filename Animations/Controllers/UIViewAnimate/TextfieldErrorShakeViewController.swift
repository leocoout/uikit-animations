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

//class ContentTextfieldView: UIView {
//
//    // MARK: Properties
//    lazy var contentStackView: UIStackView = {
//        let stack = UIStackView(frame: .zero)
//        stack.axis = .vertical
//        stack.alignment = .center
//        stack.distribution = .equalSpacing
//        stack.spacing = 24
//        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        return stack
//    }()
//
//
//    lazy var button: UIButton = {
//        let button = UIButton(type: .system)
//        button.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = true
//        button.setTitle("Validar", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = #colorLiteral(red: 0.1539083421, green: 0.5388586521, blue: 0.8937068582, alpha: 1)
//        button.layer.cornerRadius = 8
//        return button
//    }()
//
//    let textfield = CustomTextfield()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        setupLayout()
//    }
//
//
//    private func setupLayout() {
//        addSubview(contentStackView)
//        contentStackView.addArrangedSubview(button)
//        contentStackView.addArrangedSubview(textfield)
//
//
//
////        textfield.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
////        textfield.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
////        textfield.heightAnchor.constraint(equalToConstant: 42).isActive = true
////        textfield.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -104).isActive = true
////
////        contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
////        contentStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
////        contentStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
////        contentStackView.heightAnchor.constraint(equalToConstant: 64).isActive = true
//
//        button.titleLabel?.text = "Validar"
//    }
//
//    @objc private func didTapConfirmButton() {
////        validateFields([textfield])
//    }
//
//    private func validateFields(_ textfields: [UITextField]) {
//        textfields.forEach {
//            if $0.text == "" {
//                shakeField(textfield: $0)
//            }
//        }
//    }
//
//    private func shakeField(textfield: UITextField?) {
//        guard let textField = textfield else { return }
//
//        textField.transform = CGAffineTransform(translationX: 15, y: 0)
//
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 100, options: [.curveEaseInOut], animations: {
//            textField.transform = CGAffineTransform.identity
//        }, completion: nil)
//    }
//}
//

enum CustomTextFieldState {
    case valid, invalid, normal
}


@IBDesignable
class CustomTextField: UIView {
    
    public var state: CustomTextFieldState = .normal
    private lazy var border: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.twitterBlue.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var textfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Textfield exemplo"
        textfield.borderStyle = .none
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.addTarget(self,
                            action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)
        return textfield
    }()
    
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ruby
        
        return label
    }()
    
    var showTipLabel: Bool = false {
        didSet {
            tipLabel.isHidden = !showTipLabel
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(border)
        addSubview(textfield)
        addSubview(tipLabel)
        
        border.frame = bounds
        textfield.delegate = self
        textfield.frame = CGRect(x: 0, y: 0,
                                 width: bounds.width - 24,
                                 height: bounds.height - 4)
        
        textfield.center = center
        
        tipLabel.frame = CGRect(x: 0, y: bounds.height - 22, width: bounds.width, height: bounds.height)
        showTipLabel = false
    }
    
    public func validate(_ textfield: CustomTextField?) {
        state = textfield?.textfield.text == "" ? .invalid : .valid
        
        switch state {
        case .valid: isValid()
        case .invalid: shake(textfield: textfield)
        case .normal: break
        }
    }
    
    private func isValid() {
        UIView.animate(withDuration: 0.3) {
            self.border.layer.borderColor = UIColor.successGreen.cgColor
            self.showTipLabel = true
            self.tipLabel.textColor = .successGreen
            self.frame.origin.y = -10
        }
        
        tipLabel.text = "Hmmm, que nome bonito"
    }
    
    private func shake(textfield: CustomTextField?) {
        guard let textField = textfield else { return }
        
        textField.transform = CGAffineTransform(translationX: 15, y: 0)
        border.layer.borderColor = UIColor.ruby.cgColor
        showTipLabel = true
        tipLabel.textColor = .ruby
        tipLabel.text = "Insira um nome"
        textfield?.frame.origin.y = -10
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 100, options: [.curveEaseInOut], animations: {
            textField.transform = CGAffineTransform.identity
           
        }, completion: nil)
    }

}

extension CustomTextField: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        if state != .normal {
            setNormal()
        }
    }
    
    private func setNormal() {
        showTipLabel = false
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.y = 0
            self.border.layer.borderColor = UIColor.twitterBlue.cgColor
        }
    }
}
