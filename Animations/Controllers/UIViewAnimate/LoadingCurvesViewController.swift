//
//  LoadingCurvesViewController.swift
//  Animations
//
//  Created by Leonardo Santos on 07/02/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class LoadingCurvesViewController: BaseViewController {
    
    lazy var progressBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .grayest
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(animateLoadingBar(_:))))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(progressBackground)
        progressBackground.addSubview(progressBar)
        
        progressBackground.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        progressBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        progressBackground.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
        progressBackground.heightAnchor.constraint(equalToConstant: 4).isActive = true
        
        progressBar.frame = CGRect(x: -progressBackground.constraints[0].constant, y: 0,
                                   width: progressBackground.constraints[0].constant,
                                   height: 4)
    }
    
    @objc private func animateLoadingBar(_ gesture: UITapGestureRecognizer) {
        let timingFunction = CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)
        CATransaction.setAnimationTimingFunction(timingFunction)
        
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.progressBar.frame.origin.x = self.progressBackground.constraints[0].constant
        }, completion: nil)
    }
    
}
