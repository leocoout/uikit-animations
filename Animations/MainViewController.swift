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
    
    // MARK: Properties
    private var tableContent = MainTableViewContent()
    
    // MARK: Config TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableContent.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableContent.sections[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableContent.sections[section].itens.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainControllerCell.identifier,
                                                 for: indexPath) as! MainControllerCell
        let item = tableContent.sections[indexPath.section].itens[indexPath.row]
        cell.title = item.title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = tableContent.sections[indexPath.section].itens[indexPath.row]
        let vc = item.view.init()
        vc.title = item.title
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

class MainControllerCell: UITableViewCell {
    
    static let identifier = "MainCell"
    
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel!
}

//class MainViewController: UITableViewController {
//
//    var gaugeAlertNumber = ""
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        guard let cell = tableView.cellForRow(at: indexPath)?.tag else { return }
//
//        let models = HomeTableViewCellTag(rawValue: cell)
//        switch models {
//        case .uberGauge: showGaugeAlert()
//        default: break
//        }
//    }
//
//    private func showGaugeAlert() {
//        let alert = UIAlertController(title: "Digite um valor", message: "Valor a ser exibido na gauge", preferredStyle: .alert )
//
//        let save = UIAlertAction(title: "Abrir", style: .default) { (alertAction) in
//            let textField = alert.textFields?[0]
//            self.gaugeAlertNumber = textField?.text ?? ""
//            textField?.text?.isEmpty ?? false ? debugPrint("Textfield em branco") : self.navigateToGauge()
//
//        }
//
//        alert.addTextField { textField in
//            textField.placeholder = "valor"
//        }
//
//        alert.addAction(save)
//        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
//
//        self.present(alert, animated:true, completion: nil)
//    }
//
//    private func navigateToGauge() {
//        performSegue(withIdentifier: "uberRewardsSegue", sender: nil)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "uberRewardsSegue",
//            let vc = segue.destination as? UberRewardsGaugeViewController {
//            vc.number = gaugeAlertNumber
//        }
//    }
//}
//
//
