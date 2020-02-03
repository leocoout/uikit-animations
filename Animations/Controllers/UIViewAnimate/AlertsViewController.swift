
 // BottomToast.swift
 // Animations

 // Created by Leonardo Santos on 10/01/20.
 // Copyright © 2020 Leonardo Santos. All rights reserved.


import Foundation
import UIKit

class AlertsViewController: BaseViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let manager = ECSBottomToastManager(view: self.view)
        manager.displayText = "Solicite crédito com facilidade através dos nossos parceiros"
        manager.animationStyle = .startNormal
        manager.action = {
            self.teste()
        }
        
        ECSBottomToast.shared.show(manager: manager)
        
    }

    func teste() {
        print("aqui")
    }
}

class ECSBottomToastManager {
    
    let view: UIView
    var displayText: String = ""
    var animationStyle: ECSBottonToastAnimationStyles = .startNormal
    let icon = UIImage()
    var action: (() -> Void)?
    
    init(view: UIView) {
        self.view = view
    }
    
    enum ECSBottonToastAnimationStyles {
        case startRounded
        case startNormal
    }
}

class ECSBottomToast {
    
    static var shared = ECSBottomToast()
    private let fixedHeight: CGFloat = 48
    private var bottomPosition: CGFloat {
        return UIScreen.main.bounds.height - fixedHeight - 16
    }
    private let ballWidth: CGFloat = 48
    private let maxToastWidth: CGFloat = UIScreen.main.bounds.width - 32
    private var manager: ECSBottomToastManager!

    private lazy var bottomToast: UIView = {

        var view = UIView(frame: .zero)

        view.backgroundColor = UIColor(red:0.13, green:0.45, blue:0.87, alpha:1.0)
        view.layer.cornerRadius = fixedHeight / 2
        view.clipsToBounds = true
        view.addShadow()
            
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0,
                                          y: UIScreen.main.bounds.height - fixedHeight - 16,
                                          width: maxToastWidth, height: fixedHeight))

        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center
        label.textColor = .white
        label.alpha = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 0

        return label
    }()

    func show(manager: ECSBottomToastManager) {
        self.manager = manager
        label.text = manager.displayText
        
        bottomToast.translatesAutoresizingMaskIntoConstraints = false
        manager.view.addSubview(bottomToast)
       
        bottomToast.addSubview(label)
        bottomToast.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelect(gesture:))))
        
        animateWithStyle(manager.animationStyle)
    }
    
    func hide() {
        animateHide()
    }

    private func animateWithStyle(_ style: ECSBottomToastManager.ECSBottonToastAnimationStyles) {
        
        switch style {
        case .startNormal:
            animateNormal()
        case .startRounded:
            animateRounded()
        }
    }
    
    private func animateNormal() {
        bottomToast.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: maxToastWidth, height: fixedHeight)
        insertText()
        bottomToast.center.x = manager.view.center.x
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.bottomToast.frame.origin.y = self.bottomPosition
        })
    }
    
    private func animateRounded() {
        bottomToast.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: ballWidth, height: fixedHeight)
        bottomToast.center.x = manager.view.center.x
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.bottomToast.frame.origin.y = self.bottomPosition
            
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.bottomToast.frame.size.width = self.maxToastWidth
                self.bottomToast.center.x = UIScreen.main.bounds.size.width / 2
                self.animateText()
            }
        }
    }
    
    private func animateHide() {
        UIView.animate(withDuration: 0.5) {
            self.bottomToast.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - self.bottomToast.frame.size.width / 2,
                                            y: UIScreen.main.bounds.height,
                                            width: self.maxToastWidth,
                                            height: self.fixedHeight)
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

extension UIView {
    
    func addShadow() {
        layer.shadowColor = UIColor(red:0.39, green:0.44, blue:0.53, alpha:1.0).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowOpacity = 0.54
        layer.masksToBounds = false
        layer.shadowRadius = 4
    }
}
