//
//  BalanceLabel.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 13/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit



class BalanceLabel: UILabel {
    enum CounterAnimationType {
        /*
         Calculation:
         EaseIn    -> f(x) = x^3
         EaseOut   -> f(x) = (1-x)^3
         Linear    -> f(x) = x
         */
        case EaseIn
        case EaseOut
        case Linear
    }
    enum CounterType {
        case Int
        case Float
    }
    
    var start: Float = 0.0
    var end: Float = 0.0
    var progress: TimeInterval!
    var duration: TimeInterval!
    var lastUpdate: TimeInterval!
    var timer: Timer?
    var counterType: CounterType!
    var counterAnimation: CounterAnimationType!
    
    var velocity: Float = 3.0
    var currentValue: Float  {
        if self.progress >= duration {
            return self.end
        }
        let percentage = Float(self.progress / self.duration)
        let update = updateCounter(counterValue: percentage)
        return self.start + (update * (end - start))
    }
    
    func counting(fromValue: Float, toValue: Float, withDuration: TimeInterval, animationType: CounterAnimationType, counterType: CounterType) {
        self.start = fromValue
        self.end = toValue
        self.duration = withDuration
        self.counterAnimation = animationType
        self.counterType = counterType
        self.progress = 0
        self.lastUpdate = Date.timeIntervalSinceReferenceDate
        
        invalidateTimer()
        if duration == 0 {
            updateLabel(value: toValue)
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(BalanceLabel.updateValue), userInfo: nil, repeats: true)
    }

    @objc func updateValue() {
        let current = Date.timeIntervalSinceReferenceDate
        progress = progress + (current - lastUpdate)
        lastUpdate = current
        if self.progress >= self.duration {
            invalidateTimer()
            self.progress = self.duration
        }
        updateLabel(value: self.currentValue)
    }
    
    func invalidateTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
    func updateCounter(counterValue: Float) -> Float {
        guard let type = self.counterAnimation else { return 0 }
        switch type {
        case .EaseIn:
            return counterValue
        case .EaseOut:
            return powf(counterValue, velocity)
        case .Linear:
            return 1.0 - powf(1.0 - counterValue, velocity)
        }
    }
    
    func updateLabel(value: Float) {
        guard let type = self.counterType else { return }
        switch type {
        case .Float:
            let balance = NSMutableAttributedString(string: "-\(FontAwesome.dollarSign.rawValue)", attributes: [NSAttributedString.Key.font : UIFont.fontAwesome(ofSize: 11)])
            balance.append(NSMutableAttributedString(string: " \(String(format: "%.2f", value))", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .bold)]))
            self.attributedText = balance
        case .Int:
            let balance = NSMutableAttributedString(string: "-\(FontAwesome.dollarSign.rawValue)", attributes: [NSAttributedString.Key.font : UIFont.fontAwesome(ofSize: 11)])
            balance.append(NSMutableAttributedString(string: " \(Int(value))", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .bold)]))
            self.attributedText = balance
        }
    }

}
