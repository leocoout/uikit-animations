//
//  HeroMusicPlayerExample.swift
//  Animations
//
//  Created by Leonardo Santos on 17/02/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import Hero

class HeroMusicPlayerExample: BaseViewController {
    
    lazy var musicViewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heroID = "musicContainer"
        view.addShadow()
        
        return view
    }()
    
    lazy var musicImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heroID = "musicImageContainer"
        view.clipsToBounds = true
   
        return view
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 48 / 2
        button.addTarget(self, action: #selector(navigateToAnotherController), for: .touchUpInside)
        button.heroID = "playButton"
        
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(musicViewContainer)

        setupMusicViewContainer()
    }
    
    private func setupMusicViewContainer() {
        musicViewContainer.addSubview(musicImageContainer)
        musicViewContainer.addSubview(playButton)

        musicViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        musicViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        musicViewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 124).isActive = true
        musicViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -124).isActive = true
        
        musicImageContainer.topAnchor.constraint(equalTo: musicViewContainer.topAnchor,constant: 0).isActive = true
        musicImageContainer.leftAnchor.constraint(equalTo: musicViewContainer.leftAnchor, constant: 0).isActive = true
        musicImageContainer.rightAnchor.constraint(equalTo: musicViewContainer.rightAnchor, constant: 0).isActive = true
        musicImageContainer.bottomAnchor.constraint(equalTo: musicViewContainer.bottomAnchor, constant: -124).isActive = true
        
        playButton.rightAnchor.constraint(equalTo: musicViewContainer.rightAnchor, constant: -16).isActive = true
        playButton.centerYAnchor.constraint(equalTo: musicImageContainer.bottomAnchor, constant: 0).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
    }
    
    @objc private func navigateToAnotherController() {
       let vc = HeroMusicPlayerAnotherController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true, completion: nil)
    }
}

class HeroMusicPlayerAnotherController: BaseViewController {
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 48 / 2
        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        button.heroID = "playButton"
        
        return button
    }()
    
     lazy var musicImageContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .red
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heroID = "musicImageContainer"
        
         return view
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isHeroEnabled = true
        view.heroID = "musicContainer"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(playButton)
        view.addSubview(musicImageContainer)
        
        playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64).isActive = true
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        musicImageContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 124).isActive = true
        musicImageContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 64).isActive = true
        musicImageContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -64).isActive = true
        musicImageContainer.heightAnchor.constraint(equalToConstant: 264).isActive = true

    }
    
    @objc private func navigateBack() {
        dismiss(animated: true, completion: nil)
    }
    
}
