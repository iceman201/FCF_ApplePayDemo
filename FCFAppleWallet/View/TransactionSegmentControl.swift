//
//  TransactionSegmentControl.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 11/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class TransactionSegmentControl: UIControl {
    var segmentTitles: [String]! {
        didSet {
            setSegmentControl()
        }
    }
    var selectedIndex: Int = 0
    var segmentBackgroundColor: UIColor?

    private weak var segmentSeletor: UIView!
    private weak var bottomEdge: UIView!

    private var segmentColor: UIColor
    private var segmentSelectedColor: UIColor = UIColor.fiservWhite.combineWith(opacity: .Solid)
    private var segmentUnselectedColor: UIColor = UIColor.fiservOrange.combineWith(opacity: .Solid)

    private var segmentButtons = [UIButton]()
    private let cornerSize = CGSize(width: padding, height: padding)
    private let edgeCornerSize = CGSize(width: padding * 3, height: padding * 3)
    private var shapePath: CGPath? {
        didSet {
            if let seletor = self.segmentSeletor {
                let rectShape = CAShapeLayer()
                rectShape.bounds = seletor.frame
                rectShape.position = seletor.center
                rectShape.path = shapePath
                seletor.layer.backgroundColor = segmentColor.cgColor
                seletor.layer.mask = rectShape
            }
        }
    }
    private var contentShapePath: CGPath? {
        didSet {
            if let edge = self.bottomEdge {
                let rectShape = CAShapeLayer()
                rectShape.bounds = edge.frame
                rectShape.position = edge.center
                rectShape.path = contentShapePath
                edge.layer.backgroundColor = segmentColor.cgColor
                edge.layer.mask = rectShape
            }
        }
    }

    init(frame: CGRect, segmentColor: UIColor) {
        self.segmentColor = segmentColor
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.contentShapePath = UIBezierPath(roundedRect: self.bottomEdge.bounds, byRoundingCorners: [.topRight], cornerRadii: edgeCornerSize).cgPath
        self.shapePath = UIBezierPath(roundedRect: self.segmentSeletor.bounds, byRoundingCorners: [.topRight], cornerRadii: cornerSize).cgPath
    }
    
    func setSegmentControl() {
        segmentButtons.removeAll()
        subviews.forEach({ $0.removeFromSuperview() })
        self.segmentTitles?.forEach({ (title) in
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
            button.setTitle(title, for: .normal)
            button.setTitleColor(segmentUnselectedColor, for: .normal)
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .bottom
            button.addTarget(self, action: #selector(TransactionSegmentControl.tapSegmentButton), for: .touchUpInside)
            segmentButtons.append(button)
        })
        segmentButtons.first?.setTitleColor(segmentSelectedColor, for: .normal)
        let seletorWidth = frame.width / CGFloat(segmentButtons.count)
        let segmentSeletor = UIView(frame: CGRect(x: 0, y: 0, width: seletorWidth, height: frame.height))
        self.addSubview(segmentSeletor)
        self.segmentSeletor = segmentSeletor

        let segmentStack = UIStackView(arrangedSubviews: segmentButtons)
        segmentStack.axis = .horizontal
        segmentStack.alignment = .fill
        segmentStack.distribution = .fillEqually
        self.addSubview(segmentStack)
        segmentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentStack.topAnchor.constraint(equalTo: self.topAnchor),
            segmentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            segmentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            segmentStack.heightAnchor.constraint(equalToConstant: padding * 4)
        ])

        let bottomEdge = UIView()
        bottomEdge.backgroundColor = segmentColor
        self.addSubview(bottomEdge)
        bottomEdge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomEdge.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomEdge.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomEdge.topAnchor.constraint(equalTo: segmentStack.bottomAnchor),
            bottomEdge.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        self.bottomEdge = bottomEdge
    }
    
    @objc func tapSegmentButton(button: UIButton) {
        for (i, eachBtn) in segmentButtons.enumerated() {
            eachBtn.setTitleColor(segmentUnselectedColor, for: .normal)
            if eachBtn == button {
                let selectorStartPoint = frame.width / CGFloat(segmentButtons.count) * CGFloat(i)
                eachBtn.setTitleColor(segmentSelectedColor, for: .normal)
                eachBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
                selectedIndex = i
                UIView.animate(withDuration: 0.2, animations: {
                    self.segmentSeletor.frame.origin.x = selectorStartPoint
                })
                UIView.animate(withDuration: 0.5, animations: {
                    switch i {
                    case 0: // First segment
                        self.shapePath = UIBezierPath(roundedRect: self.segmentSeletor.bounds, byRoundingCorners: [.topRight], cornerRadii: self.cornerSize).cgPath
                        self.contentShapePath = UIBezierPath(roundedRect: self.bottomEdge.bounds, byRoundingCorners: [.topRight], cornerRadii: self.edgeCornerSize).cgPath
                    case self.segmentButtons.count - 1: // Last segment
                        self.shapePath = UIBezierPath(roundedRect: self.segmentSeletor.bounds, byRoundingCorners: [.topLeft], cornerRadii: self.cornerSize).cgPath
                         self.contentShapePath = UIBezierPath(roundedRect: self.bottomEdge.bounds, byRoundingCorners: [.topLeft], cornerRadii: self.edgeCornerSize).cgPath
                    default:
                        self.shapePath = UIBezierPath(roundedRect: self.segmentSeletor.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: self.cornerSize).cgPath
                        self.contentShapePath = UIBezierPath(roundedRect: self.bottomEdge.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: self.edgeCornerSize).cgPath
                    }
                })
            }
        }
        sendActions(for: .valueChanged)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setSegmentControl()
    }
}
