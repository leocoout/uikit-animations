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
        label.attributedText = "antes <b>negrito</b> teste <b>testetsatas</b> asdasdas <b>asdasdas</b>".formatBoldString()
    }
}

extension String {
    
    func formatBoldString() -> NSAttributedString? {
        return checkPhrases(str: self)
    }
    
    private func checkPhrases(str: String, fullStringArray: NSMutableAttributedString = NSMutableAttributedString()) -> NSAttributedString? {
        
        var finalStr = str
        finalStr = finalStr.replacingOccurrences(of: "<b></b>", with: "")
        let fullString = fullStringArray
        
        let lightFont = UIFont.systemFont(ofSize: 16, weight: .light)
        let boldFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        let boldFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                  NSAttributedString.Key.font: boldFont]
        let normalFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                                    NSAttributedString.Key.font: lightFont]
    
        if let range = finalStr.range(of: "<b>") {
            
            let firstPart = finalStr[finalStr.startIndex..<range.lowerBound]
            let firstAttr = NSMutableAttributedString(string: String(firstPart), attributes: normalFontAttributes)
            fullString.append(firstAttr)
            finalStr = str.replacingOccurrences(of: firstPart, with: "")
            finalStr = finalStr.replacingOccurrences(of: "<b></b>", with: "")
            
            let boldStr = finalStr.getStringBetweenSymbol()
            let boldAttr = NSMutableAttributedString(string: String(boldStr ?? ""), attributes: boldFontAttributes)
            fullString.append(boldAttr)
            finalStr = finalStr.replacingOccurrences(of: boldStr ?? "", with: "")
            
            return checkPhrases(str: finalStr, fullStringArray: fullString)
        } else {
            let normalAttr = NSMutableAttributedString(string: String(finalStr), attributes: normalFontAttributes)
            fullString.append(normalAttr)
            return fullString
        }
    }

    private func getStringBetweenSymbol() -> String? {
        return (range(of: "<b>")?.upperBound).flatMap { from in
            (range(of: "</b>", range: from..<endIndex)?.lowerBound).map { to in
                String(self[from..<to])
            }
        }
    }
}

