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
    
    lazy var floatingClouds: AnimationView = {
        let view = AnimationView(name: "floating_clouds_animacao")
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
    
   lazy var ocean: AnimationView = {
        let view = AnimationView(name: "ocean_animacao")
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
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(gestureCar(recognizer:)))
        panGesture.maximumNumberOfTouches = 1
        view.addGestureRecognizer(panGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var sun: UIView = {
        let view = UIView()
        view.backgroundColor = .yellowSun
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
    
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "<html>Viaje com a sua família para onde quiser sem se preocupar. <b>Conta com a gente ;) </b></html>"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.setHTMLFromString()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var originalTouchPoint: CGPoint = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
}

// MARK: - Private Methods
extension LottieCarExample {
    
    private func setupLayout() {
        view.backgroundColor = .lightPurple
        
        addSubviews()
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 86),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            label.widthAnchor.constraint(equalToConstant: view.bounds.width - 48),
            label.heightAnchor.constraint(equalToConstant: 200),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 64),
            closeButton.heightAnchor.constraint(equalToConstant: 64),
            
            sun.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -24),
            sun.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            sun.widthAnchor.constraint(equalToConstant: 64),
            sun.heightAnchor.constraint(equalToConstant: 64),
            
            clouds.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            clouds.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            clouds.widthAnchor.constraint(equalToConstant: view.bounds.width + 24),
            clouds.heightAnchor.constraint(equalToConstant: view.bounds.height),
            
            floatingClouds.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -86),
            floatingClouds.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            floatingClouds.widthAnchor.constraint(equalToConstant: view.bounds.width + 24),
            floatingClouds.heightAnchor.constraint(equalToConstant: view.bounds.height),
            
            mountain.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            mountain.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            mountain.widthAnchor.constraint(equalToConstant: view.bounds.width + 24),
            mountain.heightAnchor.constraint(equalToConstant: view.bounds.height),
            
            ocean.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 16),
            ocean.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            ocean.widthAnchor.constraint(equalToConstant: view.bounds.width + 48),
            ocean.heightAnchor.constraint(equalToConstant: view.bounds.height),
            
            car.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 16),
            car.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -24),
            car.widthAnchor.constraint(equalToConstant: view.bounds.width),
            car.heightAnchor.constraint(equalToConstant: view.bounds.height),
        ])
        
        sun.layer.cornerRadius = sun.constraints[1].constant / 2
        street.frame = view.bounds
        
        floatingClouds.play()
        clouds.play()
        mountain.play()
        street.play()
        car.play()
        ocean.play()
    }

    private func addSubviews() {
        [sun, clouds, floatingClouds, mountain, ocean, street, car, closeButton, label].forEach {
            view.addSubview($0)
        }
    }
    
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
            mountain.transform = CGAffineTransform(translationX: -offsetX / 4, y: -offsetY / 4)
            clouds.transform = CGAffineTransform(translationX: -offsetX / 5, y: -offsetY / 5)
            ocean.transform = CGAffineTransform(translationX: -offsetX / 3, y: -offsetY / 3)
            floatingClouds.transform = CGAffineTransform(translationX: -offsetX / 8, y: -offsetY / 8)
            sun.transform = CGAffineTransform(translationX: -offsetX / 8, y: -offsetY / 8)
        case .ended, .cancelled:
            let timingParameters = UISpringTimingParameters(dampingRatio: 0.4)
            let animator = UIViewPropertyAnimator(duration: 0, timingParameters: timingParameters)
            animator.addAnimations {
                self.car.transform = .identity
                self.mountain.transform = .identity
                self.clouds.transform = .identity
                self.ocean.transform = .identity
                self.floatingClouds.transform = .identity
                self.sun.transform = .identity
            }
            animator.isInterruptible = true
            animator.startAnimation()
        default: break
        }
    }

    @objc private func close() {
        navigationController?.popViewController(animated: true)
    }
}
