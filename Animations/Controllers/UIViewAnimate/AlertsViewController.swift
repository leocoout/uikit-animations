
 // BottomToast.swift
 // Animations

 // Created by Leonardo Santos on 10/01/20.
 // Copyright © 2020 Leonardo Santos. All rights reserved.


import Foundation
import UIKit

class AlertsViewController: BaseViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let manager = AlertManager(view: self.view)
        manager.displayText = "Erro. Por favor, tente novamente."
        manager.animationStyle = .startNormal
        manager.icon = UIImage(systemName: "exclamationmark.circle.fill")
        manager.action = {
            self.teste()
        }
        
        AlertToast.shared.show(manager: manager)
        
    }

    func teste() {
        AlertToast.shared.hide()
    }
}
