//
//  CreditCard.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 6/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class CreditCard: UIView {
    weak var cardNumber: UILabel? {
        didSet {
            // reformat credit card number
        }
    }
    weak var cardName: UILabel?
    weak var cardDate: UILabel?
    weak var cardProviderLogo: UILabel?
    weak var logo: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadView() {
        self.layer.cornerRadius = padding * 2
        
        let companyLogo = UIImageView()
        companyLogo.image = UIImage(named: "FILogo")
        companyLogo.contentMode = .scaleAspectFill
        self.addSubview(companyLogo)
        companyLogo.translatesAutoresizingMaskIntoConstraints = false
        companyLogo.topAnchor.constraint(equalTo: self.topAnchor, constant: padding * 2).isActive = true
        companyLogo.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 3).isActive = true
        companyLogo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/6).isActive = true
        companyLogo.widthAnchor.constraint(equalTo: companyLogo.heightAnchor, multiplier: 2.1/1).isActive = true
        self.logo = companyLogo
        
        //
        
        let providerLogo = UILabel()
        providerLogo.textColor = UIColor(hexString: "#007bc1")
        providerLogo.font = UIFont.fontAwesome(ofSize: 46, isBrandIcon: true)
        let v = CALayer()
        v.frame = CGRect(x: 0, y: 0, width: 45, height: 30)
        v.backgroundColor = UIColor.white.cgColor
        self.addSubview(providerLogo)
        providerLogo.layer.insertSublayer(v, below: providerLogo.layer)//(v)
        
        
        providerLogo.translatesAutoresizingMaskIntoConstraints = false
        providerLogo.topAnchor.constraint(equalTo: companyLogo.topAnchor).isActive = true
        providerLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding * 2).isActive = true
        self.cardProviderLogo = providerLogo
        
        let number = UILabel()
        number.textColor = .white
        number.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.addSubview(number)
        number.translatesAutoresizingMaskIntoConstraints = false
        number.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: padding * 2).isActive = true
        number.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.cardNumber = number
        
        let cardHolder = UILabel()
        cardHolder.textColor = UIColor.white.withAlphaComponent(0.8)
        cardHolder.text = "Card Holder"
        cardHolder.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        self.addSubview(cardHolder)
        cardHolder.translatesAutoresizingMaskIntoConstraints = false
        cardHolder.leadingAnchor.constraint(equalTo: number.leadingAnchor).isActive = true
        cardHolder.topAnchor.constraint(equalTo: number.bottomAnchor, constant: padding * 2).isActive = true
        
        let cardName = UILabel()
        cardName.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        cardName.textColor = .white
        self.addSubview(cardName)
        cardName.translatesAutoresizingMaskIntoConstraints = false
        cardName.topAnchor.constraint(equalTo: cardHolder.bottomAnchor, constant: padding).isActive = true
        cardName.leadingAnchor.constraint(equalTo: cardHolder.leadingAnchor).isActive = true
        self.cardName = cardName
        
        
    }
    
    public func loadContent(cardName: String, cardNumber: String, cardDate: String, cardProvider: String) {
        self.cardName?.text = cardName
        self.cardNumber?.text = cardNumber
        self.cardDate?.text = cardDate
        self.cardProviderLogo?.text = cardProvider
    }

}
