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
    
    weak var seletor: UIView!
    
    private var segmentButtons = [UIButton]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = frame.height/2
    }
    
    func setSegmentControl() {
        
        segmentButtons.removeAll()
        subviews.forEach({ $0.removeFromSuperview() })
        self.segmentTitles?.forEach({ (title) in
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(TransactionSegmentControl.tapSegmentButton), for: .touchUpInside)
            segmentButtons.append(button)
        })
        
        self.layoutIfNeeded()
        let seletorWidth = frame.width / CGFloat(segmentButtons.count)
        let segmentSeletor = UIView(frame: CGRect(x: 0, y: 0, width: seletorWidth, height: frame.height))
        segmentSeletor.layer.cornerRadius = frame.height / 2
        segmentSeletor.backgroundColor = .blue
        self.addSubview(segmentSeletor)
        self.seletor = segmentSeletor
        
        let segmentStack = UIStackView(arrangedSubviews: segmentButtons)
        segmentStack.axis = .horizontal
        segmentStack.alignment = .fill
        segmentStack.distribution = .fillProportionally
        self.addSubview(segmentStack)
        segmentStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentStack.topAnchor.constraint(equalTo: self.topAnchor),
            segmentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            segmentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            segmentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc func tapSegmentButton(button: UIButton) {
        for (i, eachBtn) in segmentButtons.enumerated() {
            eachBtn.setTitleColor(.green, for: .normal)
            if eachBtn == button {
                let selectorStartPoint = frame.width / CGFloat(segmentButtons.count) * CGFloat(i)
                eachBtn.setTitleColor(.black, for: .normal)
                UIView.animate(withDuration: 0.3, animations: {
                    self.seletor.frame.origin.x = selectorStartPoint
                })
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setSegmentControl()
    }
}
