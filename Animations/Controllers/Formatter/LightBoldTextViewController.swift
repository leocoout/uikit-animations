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
