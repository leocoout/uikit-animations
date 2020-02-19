//
//  HeroExample.swift
//  Animations
//
//  Created by Leonardo Santos on 15/02/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import Hero

class HeroBasicExample: BaseViewController {
    
    lazy var circleButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(navigateToAnotherView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.hero.id = "id_example"
        button.layer.cornerRadius = 64 / 2
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(circleButton)
        
        circleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        circleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        circleButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        circleButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    @objc private func navigateToAnotherView() {
        let vc = AnotherViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

class AnotherViewController: BaseViewController {
    
    lazy var blueCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.hero.id = "id_example"
        
        return view
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(backViewController), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("back view controller", for: .normal)
        return button
    }()
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHeroEnabled = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(blueCircle)
        blueCircle.frame = view.bounds
        view.addSubview(button)
        
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    @objc private func backViewController() {
        dismiss(animated: true, completion: nil)
    }
    
}
