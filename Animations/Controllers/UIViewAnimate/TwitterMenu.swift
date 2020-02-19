//
//  TwitterInterface.swift
//  Animations
//
//  Created by Leonardo Santos on 31/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class TwitterMenu: BaseViewController {
    
    private var menuBarSize: CGFloat = 52
    
    lazy var contentStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var menuStackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var menuBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.twitterBlue
        view.translatesAutoresizingMaskIntoConstraints = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupLayout()
        setupStackButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        menuBarView.frame = CGRect(x: 0, y: 36,
                                   width: menuBarSize,
                                   height: 2)
    }
    
    private func setupLayout() {
        view.addSubview(contentStackView)
        contentStackView.addArrangedSubview(menuStackView)
        menuStackView.addSubview(menuBarView)
        
        menuStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        menuStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
    private func setupStackButtons() {
        let tweetsButton = TweetButton()
        tweetsButton.text = "Tweets"
        tweetsButton.tag = 0
        let answersButton = TweetButton()
        answersButton.text = "Tweets e respostas"
        answersButton.tag = 1
        let mediaButton = TweetButton()
        mediaButton.text = "Mídia"
        mediaButton.tag = 2
        
        [tweetsButton, answersButton, mediaButton].forEach { $0.delegate = self }
    
        menuStackView.addArrangedSubview(tweetsButton)
        menuStackView.addArrangedSubview(answersButton)
        menuStackView.addArrangedSubview(mediaButton)
    }
}

extension TwitterMenu: TweetButtonDelegate {
    func didTapButton(button: UIButton) {
        print(button.tag)

        moveButtonTo(button)
    }
    
    private func deselectOthers(button: UIButton) {
        menuStackView.arrangedSubviews.forEach {
            let buttonSubview = $0 as? TweetButton
            buttonSubview?.isSelected = buttonSubview?.tag == button.tag
        }
    }
    
    private func moveButtonTo(_ button: UIButton) {
        
        let timing = CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)
        CATransaction.setAnimationTimingFunction(timing)
        UIView.animate(withDuration: 0.5) {
            self.menuBarView.frame.origin.x = self.menuStackView.arrangedSubviews[button.tag].frame.origin.x
            self.menuBarView.frame.size.width = self.menuStackView.arrangedSubviews[button.tag].subviews[0].frame.size.width
        }
    }

}

protocol TweetButtonDelegate: class {
    func didTapButton(button: UIButton)
}

class TweetButton: UIButton {
    
    weak var delegate: TweetButtonDelegate?
    var text = "" {
        didSet {
            setTitle(text, for: .normal)
            setTitleColor(UIColor.twitterBlue, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            setTitleColor(isSelected ? UIColor.twitterBlue : UIColor.gray, for: .normal)
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addTarget(self, action: #selector(teste), for: .touchUpInside)
    }
    
    @objc func teste() {
        delegate?.didTapButton(button: self)
    }
}

