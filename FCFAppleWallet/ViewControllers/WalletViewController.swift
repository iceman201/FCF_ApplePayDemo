//
//  WalletViewController.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 5/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class WalletViewController: UIViewController {
    weak var contentTable: UITableView?
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        
        let content = UITableView()
        content.backgroundColor = .green
        self.view.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        content.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        content.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        content.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.contentTable = content
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTable?.delegate = self
        contentTable?.dataSource = self
    }
}

extension WalletViewController: UITableViewDelegate {
    
}

extension WalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
