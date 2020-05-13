//
//  AlertToast.swift
//  Animations
//
//  Created by Leonardo Santos on 13/05/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class AlertManager {
    
    let view: UIView
    var displayText: String = ""
    var animationStyle: ECSBottonToastAnimationStyles = .startNormal
    var icon: UIImage?
    var action: (() -> Void)?
    
    init(view: UIView) {
        self.view = view
    }
    
    enum ECSBottonToastAnimationStyles {
        case startRounded
        case startNormal
    }
}

class AlertToast {
    
    static var shared = AlertToast()
    private let fixedHeight: CGFloat = 64
    private var bottomPosition: CGFloat = 80
    private let ballWidth: CGFloat = 48
    private let maxToastWidth: CGFloat = UIScreen.main.bounds.width - 32
    private let iconSize: CGFloat = 32
    private var manager: AlertManager!

    private lazy var bottomToast: UIView = {

        var view = UIView(frame: .zero)

        view.backgroundColor = .twitterBlue
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addShadow()
            
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: iconSize + 40,
                                          y: UIScreen.main.bounds.height - fixedHeight - 16,
                                          width: maxToastWidth - iconSize, height: fixedHeight))

        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .left
        label.textColor = .white
        label.alpha = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0

        return label
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: iconSize, height: iconSize))
        image.tintColor = .white
        
        return image
    }()

    func show(manager: AlertManager) {
        self.manager = manager
        label.text = manager.displayText
        icon.image = manager.icon
        
        manager.view.addSubview(bottomToast)
        bottomToast.addSubview(icon)
        bottomToast.addSubview(label)
        
        icon.frame.origin.x = 24
        icon.center.y = fixedHeight / 2
        bottomToast.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelect(gesture:))))
        
        animateWithStyle(manager.animationStyle)
    }
    
    func hide() {
        animateHide()
    }

    private func animateWithStyle(_ style: AlertManager.ECSBottonToastAnimationStyles) {
        animateNormal()
    }
    
    private func animateNormal() {
        bottomToast.frame = CGRect(x: 0, y: 0, width: maxToastWidth, height: fixedHeight)
        insertText()
        bottomToast.center.x = manager.view.center.x
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.bottomToast.alpha = 1
            self.bottomToast.frame.origin.y = self.bottomPosition
        })
    }
    
    private func animateHide() {
        UIView.animate(withDuration: 0.3) {
            self.bottomToast.frame.origin.y = -self.fixedHeight
            self.bottomToast.alpha = 0
        }
    }
    
    private func insertText() {
        self.label.alpha = 1
        self.label.center.y = self.bottomToast.frame.size.height / 2
    }

    private func animateText() {
        UIView.animate(withDuration: 1, animations: {
            self.label.alpha = 1
            self.label.center.y = self.bottomToast.frame.size.height / 2
        })
    }
    
    @objc private func didSelect(gesture: UITapGestureRecognizer) {
          manager.action?()
      }
}
