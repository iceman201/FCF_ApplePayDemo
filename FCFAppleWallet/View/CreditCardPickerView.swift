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

    public var cards: [CreditCard]?

    private let gap: CGFloat = padding * 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        guard let _ = cards else { return }
        
        loadViews()
        let one = CreditCard()
        one.loadContent(cardName: "L. SMITH",
                        cardNumber: "• • • •     • • • •     • • • •     7768",
                        cardDate: "06/23",
                        cardProvider: PaymentLogo.mastercard)
        
        let two = CreditCard()
        two.loadContent(cardName: "T S. GIBSON",
                        cardNumber: "• • • •     • • • •     • • • •     3321",
                        cardDate: "06/23",
                        cardProvider: PaymentLogo.visa)
        let three = CreditCard()
        three.loadContent(cardName: "J S. SWOFFORD", cardNumber: "• • • •     • • • • • •     21101", cardDate: "95", cardProvider: PaymentLogo.americanExpress)
        cards = [one, two, three]
        self.pageControl?.numberOfPages = cards?.count ?? 0
        self.pageControl?.currentPage = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadViews() {
        let container = UIScrollView()
        container.showsVerticalScrollIndicator = false
        container.showsHorizontalScrollIndicator = false
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding * 2).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        self.scrollView = container
        
        let pageControl = UIPageControl()
        self.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: padding).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.pageControl = pageControl
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        loadCreditCard(cards: self.cards!)
    }

    func loadCreditCard(cards: [CreditCard]) {
        self.setNeedsLayout()
        self.scrollView?.contentSize = CGSize(width: self.scrollView!.frame.width * CGFloat(cards.count), height: 0)
        self.scrollView?.isPagingEnabled = true
        for index in 0 ..< cards.count {
            let width = self.frame.width - gap * 2
            let leadingAndTrailingSpace = (gap / 2 * CGFloat(index * 2) + gap / 2)
            let cardSpace = width * CGFloat(index)
            cards[index].frame = CGRect(x: leadingAndTrailingSpace + cardSpace, y: 0, width: width, height: self.scrollView!.frame.height - padding)
            self.scrollView?.addSubview(cards[index])
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round((scrollView.contentOffset.x - gap / 2) / self.frame.width)
        pageControl?.currentPage = Int(pageIndex)

        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x - gap

        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y

        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset

        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
//        guard let cards = self.cards else { return }
//
//        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {
//
//            cards[0].transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
//            cards[1].transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
//
//        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
//            cards[1].transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
//            cards[2].transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
//
//        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
//            cards[2].transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
//            cards[3].transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
//
//        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
//            cards[3].transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
//            cards[4].transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
//        }
    }

    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if (self.pageControl?.currentPage == 0) {
            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1

            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl?.pageIndicatorTintColor = pageUnselectedColor


            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            cards?[pageControl!.currentPage].backgroundColor = bgColor

            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl?.currentPageIndicatorTintColor = pageSelectedColor
        }
    }

    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {

        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha

        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}
