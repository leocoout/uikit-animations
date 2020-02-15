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
    var view: UIViewController.Type
    var tag: Int?
}

struct MainTableViewContent {
    
    private let viewAnimate = [MainTableViewItem(title: "Loading Curves", view: LoadingCurvesViewController.self),
                               MainTableViewItem(title: "Alerts", view: AlertsViewController.self),
                               MainTableViewItem(title: "Uber Rewards", view: UberRewardsGaugeViewController.self, tag: 0),
                               MainTableViewItem(title: "Textfield shake", view: TextfieldErrorShake.self, tag: 1),
                               MainTableViewItem(title: "Twitter Menu", view: TwitterMenu.self)]
    
    private let property = [MainTableViewItem(title: "Basic PropertyAnimator Example", view: BasicPropertyExample.self),
                            MainTableViewItem(title: "Youtube MiniPlayer", view: YoutubeMiniPlayer.self)]
    
    private let lottie = [MainTableViewItem(title: "Lottie Basic Example", view: LottieBasicExample.self),
                          MainTableViewItem(title: "Lottie Car Example", view: LottieCarExample.self),
                          MainTableViewItem(title: "Lottie Custom Switch", view: LottieChangeStateButton.self)]

    private let neomorphism = [MainTableViewItem(title: "Button", view: NeumorphismButtonViewController.self)]
    
    private let formatter = [MainTableViewItem(title: "Light/Bold", view: LightBoldTextViewController.self),]
    
    var sections: [MainTableViewSections] {
        return [
            MainTableViewSections(headerTitle: "UI View Animate", itens: viewAnimate),
            MainTableViewSections(headerTitle: "UI View PropertyAnimator", itens: property),
            MainTableViewSections(headerTitle: "Lottie", itens: lottie),
            MainTableViewSections(headerTitle: "Neomorphism", itens: neomorphism),
            MainTableViewSections(headerTitle: "Formatters", itens: formatter)
            
        ]
    }
}

enum MainTableViewTags: Int {
    case uberGauge = 0
    case textfieldShake = 1
}
