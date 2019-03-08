//
//  ViewController.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 11/12/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

/*
#pragma mark - View Life
//视图生命周期
#pragma mark - Setup
//创建视图等
#pragma mark - Lazy Load、Getter、Setter
//懒加载、Getter和Setter
#pragma mark - Event、Callbacks
//事件、回调等
#pragma mark - Delegate And DataSource
//代理和数据源方法
#pragma mark - Private
//私有方法
*/

import UIKit
class MainViewController: UIViewController {


    weak var payLabel: UILabel?


    override func loadView() {
        super.loadView()
        self.navigationController?.isNavigationBarHidden = true
        

        let watermark = UIImageView(image: #imageLiteral(resourceName: "pay_tag"), highlightedImage: nil)
        self.view.addSubview(watermark)
        watermark.translatesAutoresizingMaskIntoConstraints = false
        watermark.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -kDefaultPadding * 4).isActive = true
        watermark.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -kDefaultPadding * 3).isActive = true
        watermark.heightAnchor.constraint(equalToConstant: 80).isActive = true
        watermark.widthAnchor.constraint(equalTo: watermark.heightAnchor, multiplier: 1/1).isActive = true

        let logo = UIImageView(image: #imageLiteral(resourceName: "FILogo"))
        self.view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.trailingAnchor.constraint(equalTo: watermark.leadingAnchor, constant: 0).isActive = true
        logo.centerYAnchor.constraint(equalTo: watermark.centerYAnchor, constant: 10).isActive = true
        logo.heightAnchor.constraint(equalTo: watermark.heightAnchor, multiplier: 1/1).isActive = true
        logo.widthAnchor.constraint(equalTo: logo.heightAnchor, multiplier: 1).isActive = true

        let centerContainer = UIView()
        self.view.addSubview(centerContainer)
        centerContainer.translatesAutoresizingMaskIntoConstraints = false
        centerContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        centerContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        let height = centerContainer.heightAnchor.constraint(equalToConstant: 150)
        let width = centerContainer.widthAnchor.constraint(equalToConstant: 300)
        width.priority = UILayoutPriority.defaultLow
        width.isActive = true
        height.priority = UILayoutPriority.defaultLow
        height.isActive = true

        let pay = UIImageView(image: #imageLiteral(resourceName: "wallet"), highlightedImage: nil)
        let tapPay = UITapGestureRecognizer(target: self, action: #selector(MainViewController.tapOnPay))
        tapPay.numberOfTapsRequired = 1
        tapPay.numberOfTouchesRequired = 1
        centerContainer.addSubview(pay)
        pay.isUserInteractionEnabled = true
        pay.addGestureRecognizer(tapPay)
        pay.translatesAutoresizingMaskIntoConstraints = false
        pay.centerXAnchor.constraint(equalTo: centerContainer.centerXAnchor, constant: 0).isActive = true
        pay.topAnchor.constraint(equalTo: centerContainer.topAnchor, constant: 0).isActive = true
        pay.heightAnchor.constraint(equalToConstant: 80).isActive = true
        pay.widthAnchor.constraint(equalToConstant: 80).isActive = true


        let tipMessage = UILabel()
        tipMessage.numberOfLines = 0
        tipMessage.textAlignment = .center
        tipMessage.text = "Tap here to add your credit card to your Apple Wallet."
        tipMessage.sizeToFit()
        centerContainer.addSubview(tipMessage)
        tipMessage.translatesAutoresizingMaskIntoConstraints = false
        tipMessage.topAnchor.constraint(equalTo: pay.bottomAnchor, constant: kDefaultPadding * 4).isActive = true
        tipMessage.centerXAnchor.constraint(equalTo: pay.centerXAnchor, constant: 0).isActive = true
        tipMessage.widthAnchor.constraint(equalTo: pay.widthAnchor, multiplier: 2/1).isActive = true
        tipMessage.bottomAnchor.constraint(equalTo: centerContainer.bottomAnchor, constant: 0).isActive = true
        payLabel = tipMessage
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @objc func tapOnPay() {
        let vc = WalletViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

