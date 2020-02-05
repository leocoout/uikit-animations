//
//  UberRewardsGauge.swift
//  Animations
//
//  Created by Leonardo Santos on 24/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class UberRewardsGaugeViewController: BaseViewController {
    var number = ""
    let slotMachine = SlotMachine()
    let gauge = GaugeView()
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupSlotMachineLayout()
    }
    
    private func setupSlotMachineLayout() {
        slotMachine.frame = view.bounds
       
        view.addSubview(slotMachine)
        view.addSubview(gauge)
        gauge.center = view.center

        let convertedNumber = Int(number) ?? 0
        
        slotMachine.show(number: convertedNumber)
        gauge.animateGauge(value: CGFloat(convertedNumber))
    }
}

class GaugeView: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    public var maxValue: CGFloat = 500
 
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        createCircularPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    
    private func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                           y: frame.size.height / 2.0),
                                        radius: 80,
                                        startAngle: -.pi / 2,
                                        endAngle: 3 * .pi / 2,
                                        clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 25
        circleLayer.strokeColor = UIColor.grayest.cgColor
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .butt
        progressLayer.lineWidth = 25
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.gold.cgColor
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    
    func animateGauge(value: CGFloat) {
        
        let timingFunction = CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)
        CATransaction.setAnimationTimingFunction(timingFunction)
        
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = 1
        circularProgressAnimation.toValue = (value * 100 / maxValue) / 100
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}

/// Classe responsavel por adicionar um componente de roleta para cada numero de um Int
class SlotMachine: UIView {
    
    private var roulettes = [NumberRouletteComponent]()
    private var animator = UIViewPropertyAnimator(duration: 1,
                                                  controlPoint1: CGPoint(x: 1, y: 0),
                                                  controlPoint2: CGPoint(x: 0, y: 1))
    private var horizontalView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        view.clipsToBounds = true
        
        return view
    }()

    func show(number: Int) {
        horizontalView.center = center
        addSubview(horizontalView)
        createNumberRoulettesWith(number: number)
    }
    
    private func createNumberRoulettesWith(number: Int) {
        let separatedNumbers = String(number).map { Int(String($0)) }
        
        separatedNumbers.forEach { number in
            addRoulette(with: number ?? 0)
        }

        animate()
    }
    
    private func addRoulette(with number: Int) {
        let numberRoulette = NumberRouletteComponent()
        
        if roulettes.count >= 1  {
            numberRoulette.frame = CGRect(x: (roulettes.last?.frame.origin.x ?? 0) + 32,
                                          y: 0,
                                          width: 32,
                                          height: 64)
        }
        
        roulettes.append(numberRoulette)
        horizontalView.frame.size.width = CGFloat(roulettes.count * 32)
        horizontalView.center.x = UIScreen.main.bounds.size.width / 2
        numberRoulette.setup(number: number)
        
        horizontalView.addSubview(numberRoulette)
    }
    
    private func animate() {
        
        var delay: CGFloat = 0
        roulettes.reversed().forEach { view in
    
            animator.addAnimations({
                 view.frame.origin.y = -view.frame.size.height + 64
            }, delayFactor: delay)
            
            delay += 0.15
            animator.startAnimation()
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.5, options: [.autoreverse], animations: {
            self.roulettes.forEach {
                $0.alpha = 0.4
            }
        }) { _ in
            self.roulettes.forEach {
                $0.alpha = 1
            }
        }
    }
}

class NumberRouletteComponent: UIView {
    
    private var labelArray = [NumberRouletteLabel]()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 24, height: 64))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(number: Int) {
        let numbersArray = Array(number-3...number)
        
        numbersArray.forEach {
            addNumber(abs($0))
        }
    }
    
    public func destroyValues() {
        if labelArray.count > 1 {
            labelArray.reverse()
            labelArray.removeSubrange(1...labelArray.count-1)
            
            if let subviews = self.subviews as? [NumberRouletteLabel] {
                subviews.forEach {
                    $0.text == labelArray[0].text ? nil : $0.removeFromSuperview()
                }
            }
        }
    }
    
    private func addNumber(_ number: Int) {
    
        let label = NumberRouletteLabel()
        if labelArray.count >= 1 {
            label.frame = CGRect(x: 0,
                                 y: (self.labelArray.last?.frame.origin.y ?? 64) + 64,
                                 width: 32,
                                 height: 64)
        }
        
        label.text = "\(number)"
        labelArray.append(label)
        
        frame.size.height = CGFloat(labelArray.count * 64)
        addSubview(labelArray.last ?? NumberRouletteLabel())
    }
    
}

class NumberRouletteLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 24, height: 64))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        font = UIFont.systemFont(ofSize: 32, weight: .bold)
        textAlignment = .center
    }
}
