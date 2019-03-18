//
//  CreditCardView.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 5/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

protocol CreditCardScrollingDelegate {
    func getSelectCardBalance(balance: Float)
    func getCardLimitPercentage(percentage: Float)
    func getCurrectSelectIndex(index: Int)
}

class CreditCardPickerView: UIView, UIScrollViewDelegate {
    private let gap: CGFloat = padding * 2
    weak var scrollView: UIScrollView? {
        didSet {
            scrollView?.delegate = self
        }
    }
    weak var pageControl: UIPageControl?
    var delegate: CreditCardScrollingDelegate?
    var cardBalances: [Float] = [0.00]
    var creditLimits: [Float] = [0.00]
    var balanceLabel: BalanceLabel?
    
    
    private var currentBalance: Float = 0.00 {
        didSet {
            delegate?.getSelectCardBalance(balance: self.currentBalance)
        }
    }
    
    private var currentCreditLimit: Float = 0.00 {
        didSet {
            delegate?.getCardLimitPercentage(percentage: self.currentBalance/self.currentCreditLimit)
        }
    }

    private var currentSelectIndex: Int = 0 {
        didSet {
            self.pageControl?.currentPage = self.currentSelectIndex
            delegate?.getCurrectSelectIndex(index: self.currentSelectIndex)
        }
    }

    public var cards: [CreditCardView]? {
        didSet {
            loadViews()
            self.pageControl?.numberOfPages = cards?.count ?? 0
            self.pageControl?.currentPage = 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        container.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -padding * 3).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        self.scrollView = container

//        let balance = BalanceLabel()
//        balance.textColor = .fiservOrange
//        self.addSubview(balance)
//        balance.translatesAutoresizingMaskIntoConstraints = false
//        balance.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
//        balance.topAnchor.constraint(equalTo: container.bottomAnchor, constant: padding).isActive = true
//        self.balanceLabel = balance
//        self.currentBalance = self.cardBalances.first ?? 0.00
        
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.fiservOrange.withAlphaComponent(0.3)
        pageControl.currentPageIndicatorTintColor = .fiservOrange
        self.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: padding).isActive = true
        pageControl.topAnchor.constraint(equalTo: container.bottomAnchor, constant: padding).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.pageControl = pageControl
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let card = self.cards {
            loadCreditCard(cards: card)
        }
    }

    func loadCreditCard(cards: [CreditCardView]) {
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
        self.currentBalance = self.cardBalances.first ?? 0.00
        self.currentCreditLimit = self.creditLimits.first ?? 0.00
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex: Int = Int(round((scrollView.contentOffset.x - gap / 2) / self.frame.width))
        self.currentSelectIndex = pageIndex

        self.currentBalance = self.cardBalances[pageIndex]
        self.currentCreditLimit = self.creditLimits[pageIndex]

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
