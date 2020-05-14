//
//  BaseViewController.swift
//  Animations
//
//  Created by Leonardo Santos on 30/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    public var type: ViewControllerType?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if type != nil {
              setupNavigationBarItem()
        }
    }
    
    private func setupNavigationBarItem() {
        let barButtonIten = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                            style: .done,
                                            target: self,
                                            action: #selector(didTapInfoButton))
        
        navigationItem.rightBarButtonItem = barButtonIten
    }
    
    @objc private func didTapInfoButton() {
        let vc = DetailsViewController()
        vc.descriptionLabel.text = type?.getDescription()
        present(vc, animated: true, completion: nil)
    }
}
