//
//  UberLoaderViewController.swift
//  Animations
//
//  Created by Leonardo Santos on 20/12/19.
//  Copyright © 2019 Leonardo Santos. All rights reserved.
//

import UIKit

class LoadingOneViewController: UIViewController {

    // MARK: - Properties
    let midY = UIScreen.main.bounds.midY
    let maxSize = UIScreen.main.bounds.width - 64

    lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black

        return view
    }()

    var containerView: UIView {
        let view = UIView(frame: CGRect(x: 32,
                             y:midY - 128,
                             width: maxSize,
                             height: 128))

        view.addSubview(blackView)
        view.clipsToBounds = true
        return view
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        blackView.frame = CGRect(x: maxSize * -1,
                                 y: containerView.frame.size.height / 2,
                                 width: maxSize,
                                 height: 4)

        view.addSubview(containerView)
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        performAnimation()
    }

    private func performAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse, .curveEaseInOut], animations: {
             self.blackView.frame.origin.x = self.maxSize
        }, completion: nil)
    }

}
