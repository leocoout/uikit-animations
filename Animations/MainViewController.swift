//
//  MainViewController.swift
//  Animations
//
//  Created by Leonardo Santos on 26/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITableViewController {
    
    var gaugeAlertNumber = ""
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let models = TableViewIndexPathCells(rawValue: indexPath.row)
        switch models {
        case .uberGauge: showGaugeAlert()
        default: break
        }
    }
    
    private func showGaugeAlert() {
        let alert = UIAlertController(title: "Digite um valor", message: "Valor a ser exibido na gauge", preferredStyle: .alert )
    
        let save = UIAlertAction(title: "Abrir", style: .default) { (alertAction) in
            let textField = alert.textFields?[0]
            self.gaugeAlertNumber = textField?.text ?? ""
            textField?.text?.isEmpty ?? false ? debugPrint("Textfield em branco") : self.navigateToGauge()
   
        }
        
        alert.addTextField { textField in
            textField.placeholder = "valor"
        }

        alert.addAction(save)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated:true, completion: nil)
    }
    
    private func navigateToGauge() {
        performSegue(withIdentifier: "uberRewardsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "uberRewardsSegue",
            let vc = segue.destination as? UberRewardsGaugeViewController {
            vc.number = gaugeAlertNumber
        }
    }
}


