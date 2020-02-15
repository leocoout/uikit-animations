//
//  BasicPropertyAnimatorExample.swift
//  Animations
//
//  Created by Leonardo Santos on 11/02/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class BasicPropertyExample: BaseViewController {
    
    var animator: UIViewPropertyAnimator? = UIViewPropertyAnimator(duration: 1, curve: .easeIn)
    lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(redView)
        redView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                            action: #selector(didTapRedView(_:))))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        redView.frame = CGRect(x: 24, y: view.bounds.height / 2, width: 64, height: 64)
    }
    
    @objc private func didTapRedView(_ gesture: UITapGestureRecognizer) {
        animator?.addAnimations {
            self.redView.frame.origin.x = self.view.bounds.width - self.redView.frame.size.width - 24
        }
        
        animator?.addCompletion { [unowned self] _ in
            self.animator = nil
        }

        animator?.startAnimation()
    }
}
