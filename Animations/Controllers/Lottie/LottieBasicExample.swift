//
//  LottieBasicExample.swift
//  Animations
//
//  Created by Leonardo Santos on 11/02/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LottieBasicExample: BaseViewController {
    
    lazy var animation: AnimationView = {
        let view = AnimationView(name: "cute_guy")
        view.frame = CGRect(x: 0, y: 0, width: 164, height: 164)
        view.loopMode = .loop
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        view.addSubview(animation)
        animation.center = view.center
        animation.play()
    }
    
}
