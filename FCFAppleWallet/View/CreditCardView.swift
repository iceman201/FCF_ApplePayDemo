//
//  CreditCardView.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 5/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class CreditCardView: UIView {

    var scrollView: UIScrollView?
    var pageControl: UIPageControl?

    override func awakeFromNib() {
        super.awakeFromNib()
        loadViews()
    }

    private func loadViews() {
        let container = UIScrollView()
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView = container
    }

}
