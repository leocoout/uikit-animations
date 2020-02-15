//
//  LottieChangeStateButton.swift
//  Animations
//
//  Created by Leonardo Santos on 07/02/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import Lottie

enum ToggleSwitch {
    case active, inactive
    
    func toggle() -> ToggleSwitch {
        switch self {
        case .active: return .inactive
        case .inactive: return .active
        }
    }
}

class LottieChangeStateButton: BaseViewController {
    
    private var buttonState: ToggleSwitch = .inactive
    lazy var switchButton: AnimationView = {
        let view = AnimationView(name: "switch_custom")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(didTapSwitch(gesture:))))
        return view
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(switchButton)
        switchButton.frame = view.bounds
    }
    
    @objc private func didTapSwitch(gesture: UITapGestureRecognizer) {
        buttonState = buttonState.toggle()
        
        switch buttonState {
        case .active:
            switchButton.play()
            let greenColor = ColorValueProvider(Color(r: 0, g: 0.5, b: 0.3, a: 1))
            let keyPath = AnimationKeypath(keypath: "Shape Layer 2.Rectangle 1.Fill 1.Color")
            switchButton.setValueProvider(greenColor, keypath: keyPath)
        case .inactive:
            let redColor = ColorValueProvider(Color(r: 1, g: 0.2, b: 0.3, a: 1))
            let keyPath = AnimationKeypath(keypath: "Shape Layer 2.Rectangle 1.Fill 1.Color")
            switchButton.setValueProvider(redColor, keypath: keyPath)
            switchButton.play(fromProgress: 25, toProgress: 0, loopMode: nil, completion: nil)
        }
    }
    
}
