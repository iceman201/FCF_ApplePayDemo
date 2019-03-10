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
    var amountLabel: UILabel!
    
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
        container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        let top = UILabel()
        top.text = "hahahah"
        top.textColor = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1)
        container.addSubview(top)
        top.translatesAutoresizingMaskIntoConstraints = false
        top.topAnchor.constraint(equalTo: container.topAnchor, constant: padding).isActive = true
        top.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding * 2).isActive = true
        top.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        
        let sub = UILabel()
        sub.textColor = #colorLiteral(red: 0.2156862745, green: 0.2156862745, blue: 0.2156862745, alpha: 1).withAlphaComponent(0.5)
        sub.text = "lalala"
        container.addSubview(sub)
        sub.translatesAutoresizingMaskIntoConstraints = false
        sub.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding * 2).isActive = true
        sub.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding).isActive = true
        
        let balance = UILabel()
        balance.text = "gaga"
        container.addSubview(balance)
        balance.translatesAutoresizingMaskIntoConstraints = false
        balance.topAnchor.constraint(equalTo: container.topAnchor, constant: padding).isActive = true
        balance.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding * 2).isActive = true
        
        let date = UILabel()
        date.text = "jhjh"
        container.addSubview(date)
        date.translatesAutoresizingMaskIntoConstraints = false
        date.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        date.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
