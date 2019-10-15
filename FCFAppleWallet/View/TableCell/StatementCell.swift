//
//  StatementCell.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 19/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class StatementCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadView() {
        self.selectionStyle = .none
        let container = UIView()
        // Add bottom corner radius
        container.backgroundColor = UIColor.fiservOrange.combineWith(opacity: .Secondary)
        self.contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding * 2).isActive = true
        container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding * 2).isActive = true
        container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

        let available = UILabel()
        available.text = "Statement Period:"
        available.textColor = UIColor.fiservWhite
        available.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        container.addSubview(available)
        available.translatesAutoresizingMaskIntoConstraints = false
        available.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding * 2).isActive = true
        available.topAnchor.constraint(equalTo: container.topAnchor, constant: padding * 2).isActive = true

        let availableLable = UILabel()
        let availableAttr = NSMutableAttributedString(string: "Last 6 months",
                                                      attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .regular),
                                                                   NSAttributedString.Key.foregroundColor : UIColor.fiservWhite])

        availableAttr.append(NSMutableAttributedString(string: FontAwesome.chevronRight.rawValue,
                                                           attributes: [NSAttributedString.Key.font : UIFont.fontAwesome(ofSize: 12),
                                                                        NSAttributedString.Key.foregroundColor : UIColor.fiservWhite]))
        availableLable.attributedText = availableAttr
        container.addSubview(availableLable)
        availableLable.translatesAutoresizingMaskIntoConstraints = false
        availableLable.topAnchor.constraint(equalTo: available.topAnchor).isActive = true
        availableLable.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding * 2).isActive = true

        let _ = container.addDivider(on: container, topOf: availableLable)

        let document = UILabel()
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        style.lineSpacing = padding
        let logoAttr = NSMutableAttributedString(string: "\(FontAwesome.filePdf.rawValue)\n",
                                                 attributes: [NSAttributedString.Key.font : UIFont.fontAwesome(ofSize: 30, weight: .Regular),
                                                              NSAttributedString.Key.foregroundColor: UIColor.fiservWhite.withAlphaComponent(0.8),
                                                              NSAttributedString.Key.paragraphStyle: style])
        logoAttr.append(NSMutableAttributedString(string: "Statements",
                                           attributes: [NSAttributedString.Key.foregroundColor : UIColor.fiservWhite,
                                                        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .medium),
                                                        NSAttributedString.Key.paragraphStyle: style]))
        document.numberOfLines = 0
        document.attributedText = logoAttr
        container.addSubview(document)
        document.translatesAutoresizingMaskIntoConstraints = false
        document.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding * 2).isActive = true
        document.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding * 2).isActive = true
    }
}
