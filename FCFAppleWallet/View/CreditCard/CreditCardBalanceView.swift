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

    override init(frame: CGRect) {
        super.init(frame: frame)

        let container = UIView()
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.container = container
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)


        if let center = self.container?.center, let height = self.container?.frame.height {
            let bottomCenter = CGPoint(x: center.x, y: height * 3.2/5)
            let circularPath = UIBezierPath(arcCenter: bottomCenter,
                                            radius: height/1.6,
                                            startAngle: -1.2*CGFloat.pi,
                                            endAngle: -1.8*CGFloat.pi,
                                            clockwise: true)

            shapeLayer.path = circularPath.cgPath
            shapeLayer.strokeColor = UIColor.fiservOrange.cgColor
            shapeLayer.lineWidth = padding / 2
            shapeLayer.strokeEnd = 0

            self.layer.addSublayer(shapeLayer)
            self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CreditCardBalanceView.tapOnIt)))
        }
    }

    @objc func tapOnIt() {
        let strockAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strockAnimation.toValue = 1
        strockAnimation.duration = 2
        strockAnimation.fillMode = CAMediaTimingFillMode.forwards
        strockAnimation.isRemovedOnCompletion = false
        shapeLayer.add(strockAnimation, forKey: "urSoBasic")
    }

}
