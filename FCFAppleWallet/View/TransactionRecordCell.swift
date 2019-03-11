//
//  TransactionRecordCell.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 5/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class TransactionRecordCell: UITableViewCell {
    var topLineLabel: UILabel!
    var subLineLabel: UILabel!
    var dateLineLabel: UILabel!
    var balanceLabel: UILabel!
    var contentBackground: UIView!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadView()
    }
    
    fileprivate func loadView() {
        self.selectionStyle = .none
        
        let divider = UIView()
        divider.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        self.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 2).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding * 2).isActive = true
        
        
        let container = UIView()
        self.contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: padding * 2).isActive = true
        container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -padding * 2).isActive = true
        container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.contentBackground = container
        
        let top = UILabel()
        top.textColor = .white
        container.addSubview(top)
        top.translatesAutoresizingMaskIntoConstraints = false
        top.topAnchor.constraint(equalTo: container.topAnchor, constant: padding).isActive = true
        top.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding).isActive = true
        top.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        self.topLineLabel = top
        
        let sub = UILabel()
        sub.textColor = UIColor.white.withAlphaComponent(0.6)
        container.addSubview(sub)
        sub.translatesAutoresizingMaskIntoConstraints = false
        sub.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding).isActive = true
        sub.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding).isActive = true
        self.subLineLabel = sub
        
        let balance = UILabel()
        balance.textColor = .white
        container.addSubview(balance)
        balance.translatesAutoresizingMaskIntoConstraints = false
        balance.topAnchor.constraint(equalTo: container.topAnchor, constant: padding).isActive = true
        balance.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding).isActive = true
        self.balanceLabel = balance
        
        let date = UILabel()
        date.textColor = UIColor.white.withAlphaComponent(0.6)
        container.addSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false
        date.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding).isActive = true
        date.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding).isActive = true
        self.dateLineLabel = date
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
