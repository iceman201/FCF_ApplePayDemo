//
//  CreditCardView.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 5/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class CreditCardPickerView: UIView, UIScrollViewDelegate {

    weak var scrollView: UIScrollView? {
        didSet {
            scrollView?.delegate = self
        }
    }
    weak var pageControl: UIPageControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadViews() {
        let container = UIScrollView()
        container.backgroundColor = .green
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding * 2).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        self.scrollView = container
        
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .red
        self.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: padding).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }

}
