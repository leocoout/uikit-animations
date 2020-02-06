//
//  LottieRubberEffect.swift
//  Animations
//
//  Created by Leonardo Santos on 03/02/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import Lottie

class LottieCarExample: BaseViewController {
    
    lazy var clouds: AnimationView = {
        let view = AnimationView(name: "clouds_animacao")
        view.loopMode = .loop
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mountain: AnimationView = {
        let view = AnimationView(name: "mountain_animacao")
        view.loopMode = .loop
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var street: AnimationView = {
         let view = AnimationView(name: "street_animacao")
         view.loopMode = .loop
         return view
     }()
    
    lazy var car: AnimationView = {
        let view = AnimationView(name: "veiculo_animacao")
        view.loopMode = .loop
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(gestureCar(recognizer:))))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .lightPurple
        
        view.addSubview(clouds)
        view.addSubview(mountain)
        view.addSubview(street)
        view.addSubview(car)
        
        clouds.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        clouds.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        clouds.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        clouds.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        
        mountain.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        mountain.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        mountain.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        mountain.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        
        
        car.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 16).isActive = true
        car.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -24).isActive = true
        car.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        car.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        street.frame = view.bounds
        
        street.play()
        car.play()
    }
    
    private var originalTouchPoint: CGPoint = .zero
    
    @objc private func gestureCar(recognizer: UIPanGestureRecognizer) {
        let touchPoint = recognizer.location(in: view)
        switch recognizer.state {
        case .began:
            originalTouchPoint = touchPoint
        case .changed:
            var offsetY = touchPoint.y - originalTouchPoint.y
            offsetY = offsetY > 0 ? pow(offsetY, 0.7) : -pow(-offsetY, 0.5)
            
            var offsetX = touchPoint.x - originalTouchPoint.x
            offsetX = offsetX > 0 ? pow(offsetX, 0.7) : -pow(-offsetX, 0.7)
        
            car.transform = CGAffineTransform(translationX: offsetX, y: offsetY)
            mountain.transform = CGAffineTransform(translationX: offsetX / 3, y: offsetY / 3)
            clouds.transform = CGAffineTransform(translationX: offsetX / 7, y: offsetY / 7)
        case .ended, .cancelled:
            let timingParameters = UISpringTimingParameters(dampingRatio: 0.4)
            let animator = UIViewPropertyAnimator(duration: 0, timingParameters: timingParameters)
            animator.addAnimations {
                self.car.transform = .identity
                self.mountain.transform = .identity
                self.clouds.transform = .identity
            }
            animator.isInterruptible = true
            animator.startAnimation()
        default: break
        }
    }
}
