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
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(gestureCar(recognizer:))))
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
        label.attributedText = "Viaje com a sua família para onde quiser sem se preocupar. <b>Conta com a gente ;) </b>".formatBoldString()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .lightPurple
        
        view.addSubview(sun)
        view.addSubview(clouds)
        view.addSubview(floatingClouds)
        view.addSubview(mountain)
        view.addSubview(ocean)
        view.addSubview(street)
        view.addSubview(car)
        view.addSubview(closeButton)
        view.addSubview(label)

        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 86).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        label.widthAnchor.constraint(equalToConstant: view.bounds.width - 48).isActive = true
        label.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        closeButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        sun.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -24).isActive = true
        sun.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        sun.widthAnchor.constraint(equalToConstant: 64).isActive = true
        sun.heightAnchor.constraint(equalToConstant: 64).isActive = true
        sun.layer.cornerRadius = sun.constraints[1].constant / 2

        clouds.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        clouds.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        clouds.widthAnchor.constraint(equalToConstant: view.bounds.width + 24).isActive = true
        clouds.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        
        floatingClouds.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -86).isActive = true
        floatingClouds.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        floatingClouds.widthAnchor.constraint(equalToConstant: view.bounds.width + 24).isActive = true
        floatingClouds.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        
        mountain.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        mountain.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        mountain.widthAnchor.constraint(equalToConstant: view.bounds.width + 24).isActive = true
        mountain.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        
        ocean.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 16).isActive = true
        ocean.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        ocean.widthAnchor.constraint(equalToConstant: view.bounds.width + 48).isActive = true
        ocean.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        
        car.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 16).isActive = true
        car.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -24).isActive = true
        car.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        car.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        street.frame = view.bounds
        
        floatingClouds.play()
        clouds.play()
        mountain.play()
        street.play()
        car.play()
        ocean.play()
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
