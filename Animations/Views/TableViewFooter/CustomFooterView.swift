//
//  CustomFooterView.swift
//  Animations
//
//  Created by Leonardo Santos on 13/05/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class CustomFooterView: UIView {
    
    lazy var profileIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "image_me"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 32
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        
        return stackView
    }()
    
    lazy var createdByLabel: UILabel = {
        let label = UILabel()
        label.text = "Developed by"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemGray
        
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Leonardo Santos"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(profileIcon)
        addSubview(stackView)
        
        stackView.addArrangedSubview(createdByLabel)
        stackView.addArrangedSubview(nameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            profileIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileIcon.heightAnchor.constraint(equalToConstant: 64),
            profileIcon.widthAnchor.constraint(equalToConstant: 64),
            
            stackView.leftAnchor.constraint(equalTo: profileIcon.rightAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
            stackView.centerYAnchor.constraint(equalTo: profileIcon.centerYAnchor)
        ])
    }
}
