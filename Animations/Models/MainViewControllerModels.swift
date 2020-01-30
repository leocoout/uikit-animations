//
//  MainViewControllerMODELS.swift
//  Animations
//
//  Created by Leonardo Santos on 26/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

struct MainTableViewSections {
    var headerTitle: String
    var itens: [MainTableViewItem]
}

struct MainTableViewItem {
    var title: String
    var view: BaseViewController.Type
}

struct MainTableViewContent {
    
    private let firstSectionItens = [MainTableViewItem(title: "Alerts", view: AlertsViewController.self),
                                     MainTableViewItem(title: "Uber Rewards", view: UberRewardsGaugeViewController.self),
                                     MainTableViewItem(title: "Textfield shake", view: TextfieldErrorShake.self)]
    
    private let secondSectionItens = [MainTableViewItem(title: "Button", view: NeumorphismButtonViewController.self)]
    
    private let thirdSectionItens = [MainTableViewItem(title: "Light/Bold", view: LightBoldTextViewController.self),]
    
    var sections: [MainTableViewSections] {
        return [
            MainTableViewSections(headerTitle: "UI View Animate", itens: firstSectionItens),
            MainTableViewSections(headerTitle: "Neomorphism", itens: secondSectionItens),
            MainTableViewSections(headerTitle: "Formatters", itens: thirdSectionItens)
        ]
    }
}
