//
//  BalanceCell.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 12/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class BalanceDetailCell: UITableViewCell {
    weak var contentBackground: UIView?
    weak var statementDate: UILabel?
    weak var period: UILabel?
    weak var closeBalance: UILabel?
    weak var minimumPaymentDue: UILabel?
    weak var dueBy: UILabel?
    weak var paymentTowardsClosingBalance: UILabel?
    weak var accountType: UILabel?
    weak var creditLimit: UILabel?
    weak var purchaseInterestRate: UILabel?
    weak var cashInterestRate: UILabel?

    private weak var container: UIView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadView() {
        let container = UIView()
        container.backgroundColor = UIColor.fiservOrange.combineWith(opacity: .Secondary)
        self.contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding * 2),
            container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding * 2),
            container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        self.container = container

        let contentContainer = UIView()
        container.addSubview(contentContainer)
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        contentContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding).isActive = true
        contentContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding).isActive = true
        contentContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        self.contentBackground = container

        let dateLabel = DetailsLabel(fontWeight: .semibold)
        dateLabel.text = "25 Feb 2019 Statement"
        contentContainer.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: padding * 2).isActive = true
        self.statementDate = dateLabel

        let period = DetailsLabel(fontWeight: .thin, textColor: UIColor.fiservWhite.combineWith(opacity: .Secondary))
        period.text = "Statement period:"
        contentContainer.addSubview(period)
        period.translatesAutoresizingMaskIntoConstraints = false
        period.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding * 2).isActive = true
        period.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let periodLabel = DetailsLabel(fontWeight: .medium, textColor: UIColor.fiservWhite.combineWith(opacity: .Solid))
        periodLabel.text = "haha"
        contentContainer.addSubview(periodLabel)
        periodLabel.translatesAutoresizingMaskIntoConstraints = false
        periodLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        periodLabel.topAnchor.constraint(equalTo: period.topAnchor).isActive = true
        self.period = periodLabel

        let closeBalance = DetailsLabel(fontWeight: .thin, textColor: UIColor.fiservWhite.combineWith(opacity: .Secondary))
        closeBalance.text = "Closing balance:"
        contentContainer.addSubview(closeBalance)
        closeBalance.translatesAutoresizingMaskIntoConstraints = false
        closeBalance.topAnchor.constraint(equalTo: period.bottomAnchor, constant: padding).isActive = true
        closeBalance.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let closeBalanceLabel = DetailsLabel(fontWeight: .medium, textColor: UIColor.fiservWhite.combineWith(opacity: .Solid))
        closeBalanceLabel.text = "hdhah"
        contentContainer.addSubview(closeBalanceLabel)
        closeBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        closeBalanceLabel.topAnchor.constraint(equalTo: closeBalance.topAnchor).isActive = true
        closeBalanceLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        self.closeBalance = closeBalanceLabel

        let minimumDue = DetailsLabel(fontWeight: .thin, textColor: UIColor.fiservWhite.combineWith(opacity: .Secondary))
        minimumDue.text = "Minimum payment due:"
        contentContainer.addSubview(minimumDue)
        minimumDue.translatesAutoresizingMaskIntoConstraints = false
        minimumDue.topAnchor.constraint(equalTo: closeBalance.bottomAnchor, constant: padding).isActive = true
        minimumDue.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let minimumDueLabel = DetailsLabel(fontWeight: .medium, textColor: UIColor.fiservWhite.combineWith(opacity: .Solid))
        contentContainer.addSubview(minimumDueLabel)
        minimumDueLabel.translatesAutoresizingMaskIntoConstraints = false
        minimumDueLabel.topAnchor.constraint(equalTo: minimumDue.topAnchor).isActive = true
        minimumDueLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        self.minimumPaymentDue = minimumDueLabel

        let dueBy = DetailsLabel(fontWeight: .thin, textColor: UIColor.fiservWhite.combineWith(opacity: .Secondary))
        dueBy.text = "Due by:"
        contentContainer.addSubview(dueBy)
        dueBy.translatesAutoresizingMaskIntoConstraints = false
        dueBy.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true
        dueBy.topAnchor.constraint(equalTo: minimumDue.bottomAnchor, constant: padding).isActive = true

        let dueByLabel = DetailsLabel(fontWeight: .medium, textColor: UIColor.fiservWhite.combineWith(opacity: .Solid))
        contentContainer.addSubview(dueByLabel)
        dueByLabel.translatesAutoresizingMaskIntoConstraints = false
        dueByLabel.topAnchor.constraint(equalTo: dueBy.topAnchor).isActive = true
        dueByLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        self.dueBy = dueByLabel

        let paymentsTowardsClosingBalance = DetailsLabel(fontWeight: .thin, textColor: UIColor.fiservWhite.combineWith(opacity: .Secondary))
        let labelAttr: NSMutableAttributedString = NSMutableAttributedString(string: "Payments towards closing balance: \n",
                                                                             attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin), NSAttributedString.Key.foregroundColor: UIColor.fiservWhite.combineWith(opacity: .Secondary)])
        labelAttr.append(NSAttributedString(string: "(updated overnight on business days)",
                                            attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .thin), NSAttributedString.Key.foregroundColor: UIColor.fiservWhite.combineWith(opacity: .Secondary)]))
        paymentsTowardsClosingBalance.attributedText = labelAttr
        paymentsTowardsClosingBalance.numberOfLines = 0
        contentContainer.addSubview(paymentsTowardsClosingBalance)
        paymentsTowardsClosingBalance.translatesAutoresizingMaskIntoConstraints = false
        paymentsTowardsClosingBalance.topAnchor.constraint(equalTo: dueBy.bottomAnchor, constant: padding).isActive = true
        paymentsTowardsClosingBalance.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let paymentsTowardsClosingBalanceLabel = DetailsLabel(fontWeight: .medium, textColor: UIColor.fiservWhite.combineWith(opacity: .Solid))
        contentContainer.addSubview(paymentsTowardsClosingBalanceLabel)
        paymentsTowardsClosingBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        paymentsTowardsClosingBalanceLabel.topAnchor.constraint(equalTo: paymentsTowardsClosingBalance.topAnchor).isActive = true
        paymentsTowardsClosingBalanceLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        self.paymentTowardsClosingBalance = paymentsTowardsClosingBalanceLabel

        let divider = self.addDivider(on: contentContainer, topOf: paymentsTowardsClosingBalance)

        let accountType = DetailsLabel(fontWeight: .thin, textColor: UIColor.fiservWhite.combineWith(opacity: .Secondary))
        accountType.text = "Account type:"
        contentContainer.addSubview(accountType)
        accountType.translatesAutoresizingMaskIntoConstraints = false
        accountType.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: padding).isActive = true
        accountType.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let accountTypeLabel = DetailsLabel(fontWeight: .medium, textColor: UIColor.fiservWhite.combineWith(opacity: .Solid))
        contentContainer.addSubview(accountTypeLabel)
        accountTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        accountTypeLabel.topAnchor.constraint(equalTo: accountType.topAnchor).isActive = true
        accountTypeLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        self.accountType = accountTypeLabel

        let creditLimit = DetailsLabel(fontWeight: .thin, textColor: UIColor.fiservWhite.combineWith(opacity: .Secondary))
        creditLimit.text = "Credit limit:"
        contentContainer.addSubview(creditLimit)
        creditLimit.translatesAutoresizingMaskIntoConstraints = false
        creditLimit.topAnchor.constraint(equalTo: accountType.bottomAnchor, constant: padding).isActive = true
        creditLimit.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let creditLimitLabel = DetailsLabel(fontWeight: .medium, textColor: UIColor.fiservWhite.combineWith(opacity: .Solid))
        contentContainer.addSubview(creditLimitLabel)
        creditLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        creditLimitLabel.topAnchor.constraint(equalTo: creditLimit.topAnchor).isActive = true
        creditLimitLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        self.creditLimit = creditLimitLabel

        let dividerOne = self.addDivider(on: contentContainer, topOf: creditLimit)

        let purchaseInterestRate = DetailsLabel(fontWeight: .thin, textColor: UIColor.fiservWhite.combineWith(opacity: .Secondary))
        purchaseInterestRate.text = "Purchase interest rate:"
        contentContainer.addSubview(purchaseInterestRate)
        purchaseInterestRate.translatesAutoresizingMaskIntoConstraints = false
        purchaseInterestRate.topAnchor.constraint(equalTo: dividerOne.bottomAnchor, constant: padding).isActive = true
        purchaseInterestRate.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let purchaseInterestRateLabel = DetailsLabel(fontWeight: .medium, textColor: UIColor.fiservWhite.combineWith(opacity: .Solid))
        contentContainer.addSubview(purchaseInterestRateLabel)
        purchaseInterestRateLabel.translatesAutoresizingMaskIntoConstraints = false
        purchaseInterestRateLabel.topAnchor.constraint(equalTo: purchaseInterestRate.topAnchor).isActive = true
        purchaseInterestRateLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        self.purchaseInterestRate = purchaseInterestRateLabel

        let cashAdvanceInterestRate = DetailsLabel(fontWeight: .thin, textColor: UIColor.fiservWhite.combineWith(opacity: .Secondary))
        cashAdvanceInterestRate.text = "Cash advance interest rate:"
        contentContainer.addSubview(cashAdvanceInterestRate)
        cashAdvanceInterestRate.translatesAutoresizingMaskIntoConstraints = false
        cashAdvanceInterestRate.topAnchor.constraint(equalTo: purchaseInterestRate.bottomAnchor, constant: padding).isActive = true
        cashAdvanceInterestRate.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let cashAdvanceInterestRateLabel = DetailsLabel(fontWeight: .medium, textColor: UIColor.fiservWhite.combineWith(opacity: .Solid))
        contentContainer.addSubview(cashAdvanceInterestRateLabel)
        cashAdvanceInterestRateLabel.translatesAutoresizingMaskIntoConstraints = false
        cashAdvanceInterestRateLabel.topAnchor.constraint(equalTo: cashAdvanceInterestRate.topAnchor).isActive = true
        cashAdvanceInterestRateLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        self.cashInterestRate = cashAdvanceInterestRateLabel
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentBackground?.layer.cornerRadius = padding * 2
        self.contentBackground?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    func loadCardDetails(period: String, closeBalance: Float, minimumPaymentDue: Float, dueBy: String, ptcb: Float, type: String, creditLimit: Float, purchaseInterestRate: Float, cashInterestRate: Float) {
        self.period?.text = period
        self.closeBalance?.text = "$ \(String(format: "%.2f", closeBalance))"
        self.minimumPaymentDue?.text = "$ \(String(format: "%.2f", minimumPaymentDue))"
        self.dueBy?.text = dueBy
        self.paymentTowardsClosingBalance?.text = "+$ \(String(format: "%.2f", ptcb))"
        self.accountType?.text = type
        self.creditLimit?.text = "$ \(String(format: "%.2f", creditLimit))"
        self.purchaseInterestRate?.text = "\(String(format: "%.2f", purchaseInterestRate))%"
        self.cashInterestRate?.text = "\(String(format: "%.2f", cashInterestRate))%"
    }
}

// MARK: Other Components
class DetailsLabel: UILabel {
    var fontSize: CGFloat
    var fontColor: UIColor
    var fontWeight: UIFont.Weight

    init(frame:CGRect = .zero, fontSize: CGFloat = 12, fontWeight: UIFont.Weight = .regular, textColor: UIColor = UIColor.fiservWhite.combineWith(opacity: .Solid)) {
        self.fontSize = fontSize
        self.fontColor = textColor
        self.fontWeight = fontWeight
        super.init(frame: frame)
        loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadView() {
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.textColor = fontColor
    }
}
