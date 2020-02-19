//
//  LottieCustomPullToRefresh.swift
//  Animations
//
//  Created by Leonardo Santos on 16/02/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LottieCustomPullToRefresh: BaseViewController {
    
    let customItens = ["1", "2"]
    let tableView = UITableView()
    var refreshControl = CustomRefreshView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.refreshControl = refreshControl
    }
}

extension LottieCustomPullToRefresh: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshControl.updateProgress(offset: scrollView.contentOffset.y)
    }
}

class CustomRefreshView: UIRefreshControl {
    
    private let animationView = AnimationView(name: "cute_guy")
    private var isAnimating = false
    private let maxDistance: CGFloat = 150
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
        setupAnimationView()
    }
    
    private func setupLayout() {
        addSubview(animationView)
        
        self.backgroundColor = .twitterBlue
        self.translatesAutoresizingMaskIntoConstraints = false
        tintColor = .clear
        addTarget(self, action: #selector(refreshContent(sender:)), for: .valueChanged)
    }
    
    public func updateProgress(offset: CGFloat) {
        guard !isAnimating else { return }
        let progress = min(abs(offset / maxDistance), 1)
        animationView.currentProgress = progress
    }
    
    
    @objc private func refreshContent(sender: UIRefreshControl) {
        perform(#selector(stopRefresh(sender:)), with: nil, afterDelay: 3)
        isAnimating = true
        animationView.currentProgress = 0
        animationView.play()
    }
    
    @objc private func stopRefresh(sender: UIRefreshControl) {
        endRefreshing()
        animationView.stop()
        isAnimating = false
    }
    
    private func setupAnimationView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor,
                                                   constant: UIScreen.main.bounds.width / 2),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 64),
            animationView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}
