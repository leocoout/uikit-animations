//
//  LightBoldText.swift
//  Animations
//
//  Created by Leonardo Santos on 19/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class LightBoldText: UIViewController {

    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        label.attributedText = "<b>teste</b> teste <b> mais testeeee </b>".formatBoldString()
    }
}

extension String {
    
    func formatBoldString(from: String = "<b>", to: String = "</b>") -> NSAttributedString? {
        var attributedArray = [String]()
        let finalStr = NSMutableAttributedString()
        
        attributedArray.append(contentsOf: components(separatedBy: from))
        attributedArray.forEach {
            let sliced = $0.slice(to: to)?.replacingOccurrences(of: to, with: "")
            
            if $0.contains(to) {
                let tst = $0.components(separatedBy: to)
                
                finalStr.append(tst[0].makeBold())
                finalStr.append(tst[1].makeLight())
            } else {
                let attributed = sliced == nil ? $0.makeLight() : sliced?.makeBold()
                finalStr.append(attributed ?? NSAttributedString())
            }
        }
        
        return finalStr
    }
    
    private func makeLight() -> NSAttributedString {
        let lightFont = UIFont.systemFont(ofSize: 16, weight: .light)
        let normalFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                    NSAttributedString.Key.font: lightFont]
        
        return NSMutableAttributedString(string: self, attributes: normalFontAttributes)
    }
    
    private func makeBold() -> NSAttributedString {
        let boldFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        let boldFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                  NSAttributedString.Key.font: boldFont]
    
        return NSMutableAttributedString(string: self, attributes: boldFontAttributes)
    }
    
    private func slice(to: String) -> String? {
        return (range(of: to)?.upperBound).flatMap { substringFrom in
            String(self[..<substringFrom])
        }
    }
}


////
////extension String {
////
////    func formatBoldString() -> NSAttributedString? {
////        return checkPhrases(str: self)
////    }
////
//    private func checkPhrases(str: String, fullStringArray: NSMutableAttributedString = NSMutableAttributedString()) -> NSAttributedString? {
//
//        var finalStr = str
//        finalStr = finalStr.replacingOccurrences(of: "<b></b>", with: "")
//        let fullString = fullStringArray
//
//        let lightFont = UIFont.systemFont(ofSize: 16, weight: .light)
//        let boldFont = UIFont.systemFont(ofSize: 16, weight: .bold)
//
//        let boldFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
//                                  NSAttributedString.Key.font: boldFont]
//        let normalFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
//                                    NSAttributedString.Key.font: lightFont]
//
//        if let range = finalStr.range(of: "<b>") {
//
//            let firstPart = finalStr[finalStr.startIndex..<range.lowerBound]
//            let firstAttr = NSMutableAttributedString(string: String(firstPart), attributes: normalFontAttributes)
//            fullString.append(firstAttr)
//            finalStr = str.replacingOccurrences(of: firstPart, with: "")
//            finalStr = finalStr.replacingOccurrences(of: "<b></b>", with: "")
//
//            let boldStr = finalStr.getStringBetweenSymbol()
//            let boldAttr = NSMutableAttributedString(string: String(boldStr ?? ""), attributes: boldFontAttributes)
//            fullString.append(<#T##attrString: NSAttributedString##NSAttributedString#>)
//            finalStr = finalStr.replacingOccurrences(of: boldStr ?? "", with: "")
//
//            return checkPhrases(str: finalStr, fullStringArray: fullString)
//        } else {
//            let normalAttr = NSMutableAttributedString(string: String(finalStr), attributes: normalFontAttributes)
//            fullString.append(normalAttr)
//            return fullString
//        }
//    }
//
//    private func getStringBetweenSymbol() -> String? {
//        return (range(of: "<b>")?.upperBound).flatMap { from in
//            (range(of: "</b>", range: from..<endIndex)?.lowerBound).map { to in
//                String(self[from..<to])
//            }
//        }
//    }
//}
//
