//
//  CreditCard.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 6/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class CreditCard: UIView {
    weak var cardNumber: UILabel?
    weak var cardName: UILabel?
    weak var cardDate: UILabel?
    weak var cardProviderLogo: UILabel?
    weak var logo: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadView() {
        
    }

}
