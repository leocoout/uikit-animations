//
//  UberRewardsGauge.swift
//  Animations
//
//  Created by Leonardo Santos on 24/01/20.
//  Copyright © 2020 Leonardo Santos. All rights reserved.
//

import Foundation
import UIKit

class UberRewardsGaugeViewController: UIViewController {
    var number = ""
    let slotMachine = SlotMachine()

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupSlotMachineLayout()
    }
    
    private func setupSlotMachineLayout() {
        slotMachine.frame = view.bounds
        view.addSubview(slotMachine)
        slotMachine.show(number: Int(number) ?? 0)
    }
    
}

/// Classe responsavel por adicionar um componente de roleta para cada numero de um Int
class SlotMachine: UIView {
    
    private var roulettes = [NumberRouletteComponent]()
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
        
        var delay: Double = 0
        roulettes.reversed().forEach { view in
            UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseInOut, animations: {
                view.frame.origin.y = -view.frame.size.height + 64
            }, completion: { _ in
                view.destroyValues()
            })
            
            delay += 0.1
        }
    }
}

class NumberRouletteComponent: UIView {
    
    private var labelArray = [NumberRouletteLabel]()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 32, height: 64))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(number: Int) {
        let numbersArray = Array(number-3...number)
        
        numbersArray.forEach {
            addNumber($0)
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
        super.init(frame: CGRect(x: 0, y: 0, width: 32, height: 64))
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
