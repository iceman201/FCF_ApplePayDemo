//
//  BalanceCell.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 12/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class BalanceCell: UITableViewCell {
    weak var contentBackground: UIView?
    weak var period: UILabel?
//    weak var

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
