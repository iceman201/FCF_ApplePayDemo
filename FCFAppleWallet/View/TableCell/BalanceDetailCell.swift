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
//    weak var

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        loadView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadView() {
        let container = UIView()
        container.backgroundColor = .fiservOrange
        self.contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding * 2),
            container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding * 2),
            container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])

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

        let period = DetailsLabel(fontWeight: .thin, textColor: UIColor.white.withAlphaComponent(0.8))
        period.text = "Statement period:"
        contentContainer.addSubview(period)
        period.translatesAutoresizingMaskIntoConstraints = false
        period.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding * 2).isActive = true
        period.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let periodLabel = DetailsLabel()
        periodLabel.text = "haha"
        contentContainer.addSubview(periodLabel)
        periodLabel.translatesAutoresizingMaskIntoConstraints = false
        periodLabel.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor).isActive = true
        periodLabel.topAnchor.constraint(equalTo: period.topAnchor).isActive = true
        self.period = periodLabel

        let closeBalance = DetailsLabel(fontWeight: .thin, textColor: UIColor.white.withAlphaComponent(0.8))
        closeBalance.text = "Closing balance:"
        contentContainer.addSubview(closeBalance)
        closeBalance.translatesAutoresizingMaskIntoConstraints = false
        closeBalance.topAnchor.constraint(equalTo: period.bottomAnchor, constant: padding).isActive = true
        closeBalance.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let minimumDue = DetailsLabel(fontWeight: .thin, textColor: UIColor.white.withAlphaComponent(0.8))
        minimumDue.text = "Minimum payment due:"
        contentContainer.addSubview(minimumDue)
        minimumDue.translatesAutoresizingMaskIntoConstraints = false
        minimumDue.topAnchor.constraint(equalTo: closeBalance.bottomAnchor, constant: padding).isActive = true
        minimumDue.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let dueBy = DetailsLabel(fontWeight: .thin, textColor: UIColor.white.withAlphaComponent(0.8))
        dueBy.text = "Due by:"
        contentContainer.addSubview(dueBy)
        dueBy.translatesAutoresizingMaskIntoConstraints = false
        dueBy.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true
        dueBy.topAnchor.constraint(equalTo: minimumDue.bottomAnchor, constant: padding).isActive = true

        let paymentsTowardsClosingBalance = DetailsLabel(fontWeight: .thin, textColor: UIColor.white.withAlphaComponent(0.8))
        let labelAttr: NSMutableAttributedString = NSMutableAttributedString(string: "Payments towards closing balance: \n", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin), NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.8)])
        labelAttr.append(NSAttributedString(string: "(updated overnight on business days)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 10, weight: .thin), NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.8)]))
        paymentsTowardsClosingBalance.attributedText = labelAttr
        paymentsTowardsClosingBalance.numberOfLines = 0
        contentContainer.addSubview(paymentsTowardsClosingBalance)
        paymentsTowardsClosingBalance.translatesAutoresizingMaskIntoConstraints = false
        paymentsTowardsClosingBalance.topAnchor.constraint(equalTo: dueBy.bottomAnchor, constant: padding).isActive = true
        paymentsTowardsClosingBalance.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let divider = self.addDivider(on: contentContainer, topOf: paymentsTowardsClosingBalance)

        let accountType = DetailsLabel(fontWeight: .thin, textColor: UIColor.white.withAlphaComponent(0.8))
        accountType.text = "Account type:"
        contentContainer.addSubview(accountType)
        accountType.translatesAutoresizingMaskIntoConstraints = false
        accountType.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: padding).isActive = true
        accountType.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let creditLimit = DetailsLabel(fontWeight: .thin, textColor: UIColor.white.withAlphaComponent(0.8))
        creditLimit.text = "Credit limit:"
        contentContainer.addSubview(creditLimit)
        creditLimit.translatesAutoresizingMaskIntoConstraints = false
        creditLimit.topAnchor.constraint(equalTo: accountType.bottomAnchor, constant: padding).isActive = true
        creditLimit.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let dividerOne = self.addDivider(on: contentContainer, topOf: creditLimit)

        let purchaseInterestRate = DetailsLabel(fontWeight: .thin, textColor: UIColor.white.withAlphaComponent(0.8))
        purchaseInterestRate.text = "Purchase interest rate:"
        contentContainer.addSubview(purchaseInterestRate)
        purchaseInterestRate.translatesAutoresizingMaskIntoConstraints = false
        purchaseInterestRate.topAnchor.constraint(equalTo: dividerOne.bottomAnchor, constant: padding).isActive = true
        purchaseInterestRate.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true

        let cashAdvanceInterestRate = DetailsLabel(fontWeight: .thin, textColor: UIColor.white.withAlphaComponent(0.8))
        cashAdvanceInterestRate.text = "Cash advance interest rate:"
        contentContainer.addSubview(cashAdvanceInterestRate)
        cashAdvanceInterestRate.translatesAutoresizingMaskIntoConstraints = false
        cashAdvanceInterestRate.topAnchor.constraint(equalTo: purchaseInterestRate.bottomAnchor, constant: padding).isActive = true
        cashAdvanceInterestRate.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor).isActive = true





    }
}

class DetailsLabel: UILabel {
    var fontSize: CGFloat
    var fontColor: UIColor
    var fontWeight: UIFont.Weight

    init(frame:CGRect = .zero, fontSize: CGFloat = 12, fontWeight: UIFont.Weight = .regular, textColor: UIColor = .white) {
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
