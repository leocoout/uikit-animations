//
//  ViewControllerType.swift
//  Animations
//
//  Created by Leonardo Santos on 02/03/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation

enum ViewControllerType {
    case loadingCurves
    case textfieldErrorShake
    case alert
    case uberRewardsGauge
    case twitterMenu
    
    func getDescription() -> String {
        switch self {
        case .loadingCurves: return "Loader simples utilizando curva bézier customizada."
        default: return ""
        }
    }
}
