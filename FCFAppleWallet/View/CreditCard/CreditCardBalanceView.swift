//
//  CreditCardBalanceView.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 13/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class CreditCardBalanceView: UIView {
    var container: UIView?
    let shapeLayer = CAShapeLayer()
    let gradient = CAGradientLayer()
    
    weak var balanceLabel: BalanceLabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let center = self.container?.center, let height = self.container?.frame.height {
            let bottomCenter = CGPoint(x: center.x, y: height * 3.28/5)
            let circularPath = UIBezierPath(arcCenter: bottomCenter,
                                            radius: height/1.65,
                                            startAngle: -1.2*CGFloat.pi,
                                            endAngle: -1.8*CGFloat.pi,
                                            clockwise: true)
            let trackLayer = CAShapeLayer()
            trackLayer.path = circularPath.cgPath
            trackLayer.strokeColor = UIColor.fiservBlack.combineWith(opacity: .BTPressed).cgColor
            trackLayer.lineWidth = padding
            trackLayer.fillColor = UIColor.clear.cgColor
            trackLayer.lineCap = .round
            self.layer.addSublayer(trackLayer)

            gradient.frame =  CGRect(x: 0, y: 0, width: self.container?.frame.width ?? 0.0, height: height + 5)
            gradient.colors = [UIColor.fiservOrange.combineWith(opacity: .BTPressed).cgColor, UIColor.fiservOrange.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 1)
            gradient.endPoint = CGPoint(x: 0.75, y: 1)
            
            shapeLayer.path = circularPath.cgPath
            shapeLayer.strokeColor = UIColor.fiservOrange.cgColor
            shapeLayer.lineWidth = padding
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineCap = .round
            shapeLayer.strokeEnd = 0

            gradient.mask = shapeLayer
            self.layer.addSublayer(gradient)
        }
    }
    
    fileprivate func loadView() {
        let container = UIView()
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.container = container
        
        let availableLabel = BalanceLabel()
        availableLabel.textColor = .fiservOrange
        availableLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.addSubview(availableLabel)
        availableLabel.translatesAutoresizingMaskIntoConstraints = false
        availableLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: padding).isActive = true
        availableLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.balanceLabel = availableLabel
        
        let available = UILabel()
        available.textColor = .fiservOrange
        available.text = "Balance"
        available.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        self.addSubview(available)
        available.translatesAutoresizingMaskIntoConstraints = false
        available.topAnchor.constraint(equalTo: availableLabel.bottomAnchor, constant: padding/2).isActive = true
        available.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        let minLabel = UILabel()
        minLabel.text = "Min."
        minLabel.textColor = .fiservOrange
        minLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        self.addSubview(minLabel)
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        minLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: padding).isActive = true
        minLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
        let maxLabel = UILabel()
        maxLabel.text = "Max."
        maxLabel.textAlignment = .right
        maxLabel.textColor = .fiservOrange
        maxLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        self.addSubview(maxLabel)
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: padding).isActive = true
        maxLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }

    func startAnimation(with progress: Float) {
        let strockAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strockAnimation.toValue = progress // Target value
        strockAnimation.duration = 2
        strockAnimation.fillMode = CAMediaTimingFillMode.forwards
        strockAnimation.isRemovedOnCompletion = false
        shapeLayer.add(strockAnimation, forKey: "urSoBasic")
    }
}
