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
    
    weak var cardProviderLogo: UIImageView?
    weak var expiryLabel: UILabel?
    weak var logo: UIImageView?
    
    var backgroundView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadView() {
        self.layer.cornerRadius = padding * 2
        
        let background = UIView()
        background.layer.cornerRadius = self.layer.cornerRadius
        self.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        background.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        background.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.backgroundView = background
        
        let number = UILabel()
        number.textColor = .white
        number.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.addSubview(number)
        number.translatesAutoresizingMaskIntoConstraints = false
        number.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: padding).isActive = true
        number.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.cardNumber = number
        
        let chip = UIImageView()
        chip.image = UIImage(named: "cardchip")
        chip.contentMode = .scaleAspectFit
        self.addSubview(chip)
        chip.translatesAutoresizingMaskIntoConstraints = false
        chip.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 3).isActive = true
        chip.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/6).isActive = true
        chip.widthAnchor.constraint(equalTo: chip.heightAnchor, multiplier: 1.5/1).isActive = true
        chip.bottomAnchor.constraint(equalTo: number.topAnchor, constant: -padding).isActive = true
        self.logo = chip
        
        let paywave = UILabel()
        paywave.textColor = .white
        paywave.font = UIFont.paymentLogo(ofSize: 20)
        paywave.text = PaymentLogo.contactless.rawValue
        self.addSubview(paywave)
        paywave.translatesAutoresizingMaskIntoConstraints = false
        paywave.bottomAnchor.constraint(equalTo: number.topAnchor, constant: -padding * 2).isActive = true
        paywave.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding * 2).isActive = true

        let cardHolder = UILabel()
        cardHolder.textColor = UIColor.white.withAlphaComponent(0.8)
        cardHolder.text = "Card Holder"
        cardHolder.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        self.addSubview(cardHolder)
        cardHolder.translatesAutoresizingMaskIntoConstraints = false
        cardHolder.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 3).isActive = true
        cardHolder.topAnchor.constraint(equalTo: number.bottomAnchor, constant: padding * 2).isActive = true
        
        let cardName = UILabel()
        cardName.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        cardName.textColor = .white
        self.addSubview(cardName)
        cardName.translatesAutoresizingMaskIntoConstraints = false
        cardName.topAnchor.constraint(equalTo: cardHolder.bottomAnchor, constant: padding).isActive = true
        cardName.leadingAnchor.constraint(equalTo: cardHolder.leadingAnchor, constant: 0).isActive = true
        self.cardName = cardName
        
        let expiry = UILabel()
        expiry.textColor = UIColor.white.withAlphaComponent(0.8)
        expiry.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        self.addSubview(expiry)
        expiry.translatesAutoresizingMaskIntoConstraints = false
        expiry.leadingAnchor.constraint(equalTo: cardName.trailingAnchor, constant: padding * 2).isActive = true
        expiry.topAnchor.constraint(equalTo: number.bottomAnchor, constant: padding * 2).isActive = true
        self.expiryLabel = expiry
        
        let date = UILabel()
        date.textColor = .white
        date.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.addSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false
        date.topAnchor.constraint(equalTo: expiry.bottomAnchor, constant: padding).isActive = true
        date.leadingAnchor.constraint(equalTo: expiry.leadingAnchor).isActive = true
        self.cardDate = date
        
        let providerLogo = UIImageView()
        self.addSubview(providerLogo)
        providerLogo.translatesAutoresizingMaskIntoConstraints = false
        providerLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding * 2).isActive = true
        providerLogo.widthAnchor.constraint(equalToConstant: 60).isActive = true
        providerLogo.heightAnchor.constraint(equalToConstant: 60).isActive = true
        providerLogo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
        self.cardProviderLogo = providerLogo
        
    }
    
    public func loadContent(cardName: String, cardNumber: String, cardDate: String, cardProvider: PaymentLogo) {
        self.cardName?.text = cardName
        self.cardNumber?.text = cardNumber
        self.cardDate?.text = cardDate
        self.expiryLabel?.text = cardProvider == .americanExpress ? "Since" : "Valid Thru"
        
        switch cardProvider {
        case .mastercard:
            self.cardProviderLogo?.image = UIImage(named: "001-mastercard")
        case .visa:
            self.cardProviderLogo?.image = UIImage(named: "002-visa")
        case .americanExpress:
            self.cardProviderLogo?.image = UIImage(named: "003-american-express")
        default:
            return
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let gradientLayer = CAGradientLayer()
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // Bottom right corner.
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        // This example uses a Color Literal and a UIColor from RGB values.
        gradientLayer.colors = [#colorLiteral(red: 0, green: 0.8416796875, blue: 0.3993097909, alpha: 0.8988045302).cgColor, #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1).cgColor]
        // Rasterize this static layer to improve app performance.
        gradientLayer.shouldRasterize = true
        gradientLayer.cornerRadius = padding * 2
        // Apply the gradient to the backgroundGradientView.
        self.backgroundView?.layer.addSublayer(gradientLayer)
        
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: padding * 2)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)//CGSizeMake(0.0f, 5.0f);
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
}
