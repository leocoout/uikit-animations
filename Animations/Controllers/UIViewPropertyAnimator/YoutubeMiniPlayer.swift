//
//  RubberBandViewController.swift
//  Animations
//
//  Created by Leonardo Santos on 30/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class YoutubeMiniPlayer: BaseViewController {

    // MARK: Properties
    lazy var videoView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "player"))
        view.backgroundColor = .red

        return view
    }()
    
    lazy var videoBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow()
        
        return view
    }()
    
    private var animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn)
    private var isInterrupted = false
    private var progressWhenPaused: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoBackground)
        view.addSubview(videoView)
        
        videoView.frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: 200)
        videoBackground.frame = CGRect(x: 0, y: 64,
                                       width: view.bounds.width,
                                       height: view.bounds.height - 64)
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self,
                                                         action: #selector(popVideoView(recognizer:))))

        
        setupAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        animator.pauseAnimation()
        animator.stopAnimation(true)
    }
    
    private func setupAnimation() {
        
        animator.pausesOnCompletion = true
        animator.addAnimations {
            self.videoView.transform = CGAffineTransform(translationX: 0,y: self.view.bounds.height - 182)
            self.videoView.frame.size = CGSize(width: 100, height: 64)
            self.videoView.frame.origin.x = 42
            
            self.videoBackground.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height - 200)
            self.videoBackground.frame.size = CGSize(width: self.view.bounds.width - 48, height: 100)
            self.videoBackground.frame.origin.x = 24
        }
        
        animator.addObserver(self, forKeyPath: #keyPath(UIViewPropertyAnimator.isRunning), options: [.new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UIViewPropertyAnimator.isRunning){
           if !animator.isRunning && !isInterrupted {
                animator.isReversed = !animator.isReversed
                progressWhenPaused = 0
            }
        }
    }
    
    private func interruptAnimation(){
        if animator.isRunning == true {
            isInterrupted = true
            animator.pauseAnimation()
            progressWhenPaused = animator.fractionComplete
        }
    }

    @objc func popVideoView(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.translation(in: view)
        
        switch recognizer.state {
        case .began:
            interruptAnimation()
        case .changed:
            isInterrupted = false
            let direction : CGFloat = animator.isReversed ? -1 : 1
            animator.fractionComplete = direction * (point.y / view.bounds.height + direction * (progressWhenPaused))
        case .ended, .cancelled:
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }
}
