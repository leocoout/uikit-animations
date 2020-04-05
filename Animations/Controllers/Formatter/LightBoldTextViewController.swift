//
//  LightBoldText.swift
//  Animations
//
//  Created by Leonardo Santos on 19/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class LightBoldTextViewController: BaseViewController {

    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 200, height: 64))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .red
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.text = "<html><b>teste</b> teste</html>"
        label.font = UIFont.systemFont(ofSize: 16)
        label.setHTMLFromString()
    }
}


extension UILabel {
    func setHTMLFromString() {
        let modifiedFont = String(format:"<span style=\"font-family: 'Roboto', sans-serif; font-size: \(font.pointSize)\">\(text ?? "")</span>")
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let attrStr = try? NSMutableAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        attrStr?.addAttributes([.paragraphStyle: style],
                               range: NSMakeRange(0, attrStr?.length ?? 0))
    
        self.attributedText = attrStr
    }
}

extension String {
    func formatBoldString() -> NSAttributedString? {
        var attributedText: NSAttributedString?
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        if let data = data(using: .unicode, allowLossyConversion: true),
            let attrStr = try? NSAttributedString(data: data,
                                                  options: options,
                                                  documentAttributes: nil) {
            attributedText = attrStr
        }
        
        return attributedText
    }
}






//extension String {
//
//    func formatBoldString(from: String = "<b>", to: String = "</b>") -> NSAttributedString? {
//        var attributedArray = [String]()
//        let finalStr = NSMutableAttributedString()
//
//        attributedArray.append(contentsOf: components(separatedBy: from))
//        attributedArray.forEach {
//            let sliced = $0.slice(to: to)?.replacingOccurrences(of: to, with: "")
//
//            if $0.contains(to) {
//                let tst = $0.components(separatedBy: to)
//
//                finalStr.append(tst[0].makeBold())
//                finalStr.append(tst[1].makeLight())
//            } else {
//                let attributed = sliced == nil ? $0.makeLight() : sliced?.makeBold()
//                finalStr.append(attributed ?? NSAttributedString())
//            }
//        }
//
//        return finalStr
//    }
//
//    private func makeLight() -> NSAttributedString {
//        let lightFont = UIFont.systemFont(ofSize: 24, weight: .light)
//        let normalFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
//                                    NSAttributedString.Key.font: lightFont]
//
//        return NSMutableAttributedString(string: self, attributes: normalFontAttributes)
//    }
//
//    private func makeBold() -> NSAttributedString {
//        let boldFont = UIFont.systemFont(ofSize: 24, weight: .bold)
//        let boldFontAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
//                                  NSAttributedString.Key.font: boldFont]
//
//        return NSMutableAttributedString(string: self, attributes: boldFontAttributes)
//    }
//
//    private func slice(to: String) -> String? {
//        return (range(of: to)?.upperBound).flatMap { substringFrom in
//            String(self[..<substringFrom])
//        }
//    }
//}
