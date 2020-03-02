//
//  DetailsViewController.swift
//  Animations
//
//  Created by Leonardo Santos on 02/03/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import UIKit

class DetailsViewController: BaseViewController {
    
    var descriptionLabel: UILabel = {
        let str = UILabel()
        str.textColor = .label
        str.translatesAutoresizingMaskIntoConstraints = false
        str.contentMode = .topLeft
        str.numberOfLines = 0
        
        return str
    }()
    
    lazy var infoTitle: UILabel = {
        let str = UILabel()
        str.text = "Informação"
        str.textColor = .label
        str.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        str.translatesAutoresizingMaskIntoConstraints = false
        
        return str
    }()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addSubview(infoTitle)
        view.addSubview(descriptionLabel)
        
        infoTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
        infoTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        infoTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
        infoTitle.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: infoTitle.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32).isActive = true
    }
}
