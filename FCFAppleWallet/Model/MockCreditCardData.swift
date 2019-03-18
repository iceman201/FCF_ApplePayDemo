//
//  MockCreditCardData.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 11/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import Foundation

class CreditCard: NSObject {
    var name: String
    var number: String
    var provider: PaymentLogo
    var expiryDate: String
    var cardDetails: (period: String, closeBalance: Float, minimumPayDue: Float, dueBy: String, ptcb: Float, type: String, creditLimit: Float, purchaseRate: Float, cashRate: Float)

    init(name: String, number: String, provider: PaymentLogo, expiryDate: String, cardDetails: (period: String, closeBalance: Float, minimumPayDue: Float, dueBy: String, ptcb: Float, type: String, creditLimit: Float, purchaseRate: Float, cashRate: Float)) {
        self.name = name
        self.number = number
        self.provider = provider
        self.expiryDate = expiryDate
        self.cardDetails = cardDetails
        super.init()
    }

    static func generateCards() -> [CreditCard] {
        let nameList = ["T S. GIBSON", "J S. SWOFFORD", "L. SMITH"]
        let cardNumber = ["• • • •     • • • • • •     21101", "• • • •     • • • •     • • • •     7768", "• • • •     • • • •     • • • •     3321"]
        let cardDate = ["95", "06/23", "06/23"]
        let provider: [PaymentLogo] = [PaymentLogo.americanExpress, PaymentLogo.visa, PaymentLogo.mastercard]
        let cardDetails: [(period: String,
            closeBalance: Float,
            minimumPayDue: Float,
            dueBy: String,
            ptcb: Float,
            type: String,
            creditLimit: Float,
            purchaseRate: Float,
            cashRate: Float)] = [(period: "28 Jan 2019 - 25 Feb 2019",
                                  closeBalance: 593393.00,
                                  minimumPayDue: 3500.00,
                                  dueBy: "22 Mar 2019",
                                  ptcb: 600.00, type: "Platinum Airpoint Visa",
                                  creditLimit: 1000000.00,
                                  purchaseRate: 20.5,
                                  cashRate: 23.60),

                                 (period: "01 Feb 2019 - 02 Mar 2019",
                                  closeBalance: 3393.00,
                                  minimumPayDue: 5000.00,
                                  dueBy: "30 Mar 2019",
                                  ptcb: 1000.00,
                                  type: "Cashback Visa",
                                  creditLimit: 50000.00,
                                  purchaseRate: 20.5,
                                  cashRate: 23.60),

                                 (period: "28 Jan 2019 - 25 Feb 2019",
                                  closeBalance: 15093.00,
                                  minimumPayDue: 3500.00,
                                  dueBy: "22 Mar 2019",
                                  ptcb: 70.00,
                                  type: "Airpoint MasterCard",
                                  creditLimit: 20000.00,
                                  purchaseRate: 20.5,
                                  cashRate: 23.60)]

        var result = [CreditCard]()

        for i in 0..<nameList.count {
            let card = CreditCard(name: nameList[i], number: cardNumber[i], provider: provider[i], expiryDate: cardDate[i], cardDetails: cardDetails[i])
            result.append(card)
        }
        return result
    }
}
