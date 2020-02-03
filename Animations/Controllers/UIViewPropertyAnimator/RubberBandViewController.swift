//
//  RubberBandViewController.swift
//  Animations
//
//  Created by Leonardo Santos on 30/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

enum MiniPlayerState {
    case expanded, collapsed
}

class RubberBandViewController: BaseViewController {

    // MARK: Properties
    lazy var videoView: UIView = {
        let view = UIView(frame: CGRect(x: 0,
                                        y: 64,
                                        width: UIScreen.main.bounds.size.width,
                                        height: 200))
        view.backgroundColor = .red
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(testeAnimation(recognizer:))))

        return view
    }()

    private var initialFrame: CGRect?
    private var state: MiniPlayerState = .expanded
    private var animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn)
    private var offset: CGFloat {
        return UIScreen.main.bounds.size.width - videoView.frame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoView)
    }

    @objc func testeAnimation(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            toggleAnimations()
            animator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: videoView)
            var fraction = -translation.y / offset
            if state == .collapsed { fraction *= -1 }
            animator.fractionComplete = fraction
        case .ended:
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default: ()
        }
    }

    private func toggleAnimations() {
        state == .collapsed ? expand() : collapse()
    }

    private func collapse() {

        animator.addAnimations {
            self.initialFrame = self.videoView.frame
            self.videoView.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - 64, width: 64, height: 64)
            self.videoView.layer.cornerRadius = 10
            self.state = .collapsed
            self.videoView.layoutIfNeeded()
        }

        animator.startAnimation()
    }

    private func expand() {
        animator.addAnimations {
            self.videoView.frame = self.initialFrame!
            self.state = .expanded
            self.videoView.layoutIfNeeded()
        }
        animator.startAnimation()
    }

}
