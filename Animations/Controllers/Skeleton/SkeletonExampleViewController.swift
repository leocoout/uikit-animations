//
//  SkeletonExampleViewController.swift
//  Animations
//
//  Created by Leonardo Santos on 12/05/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

enum SkeletonButtonState {
    case hide, show
    
    func toggle() -> SkeletonButtonState {
        switch self {
        case .hide: return .show
        case .show: return .hide
        }
    }
    
    func getButtonTitle () -> String {
        switch self {
        case .hide: return "Show skeleton"
        case .show: return "Hide Skeleton"
        }
    }
}

class SkeletonExampleViewController: BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    private var skeletonButtonState: SkeletonButtonState = .show

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSkeletonLayout()
    }
    
    @IBAction func didTapActionButton(_ sender: Any) {
        
        switch skeletonButtonState {
        case .show: applySkeleton()
        case .hide: removeSkeleton()
        }
        
        actionButton.setTitle(skeletonButtonState.getButtonTitle(), for: .normal)
        skeletonButtonState = skeletonButtonState.toggle()
    }
}


// MARK: - Private Methods
extension SkeletonExampleViewController {
    
    private func setupSkeletonLayout() {
        imageView.isSkeletonable = true
        imageView.skeletonCornerRadius = Float(imageView.frame.size.height / 2)
        descriptionLabel.isSkeletonable = true
        descriptionLabel.linesCornerRadius = 6
    }
    
    private func applySkeleton() {
        imageView.showAnimatedGradientSkeleton()
        descriptionLabel.showAnimatedGradientSkeleton()
    }
    
    private func removeSkeleton() {
        imageView.hideSkeleton()
        descriptionLabel.hideSkeleton()
    }
}
