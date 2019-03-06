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
    
    fileprivate func addDivider(on headerView: UIView, topOf headerTopContainerView: UIView) -> UIView {
        let divider = UIView()
        divider.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        headerView.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: headerTopContainerView.bottomAnchor, constant: padding * 2).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding).isActive = true

        return divider
    }

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white

        let content = UITableView()
        self.view.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        content.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        content.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        content.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.contentTable = content


        let headerView = UIView(frame: CGRect(origin: self.view.frame.origin, size: CGSize(width: self.view.frame.width, height: 666)))
        content.tableHeaderView = headerView
        content.tableHeaderView?.layoutIfNeeded()

        let headerTopContainerView = CreditCardPickerView()
        headerTopContainerView.backgroundColor = .gray
        headerView.addSubview(headerTopContainerView)
        headerTopContainerView.translatesAutoresizingMaskIntoConstraints = false
        headerTopContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding * 2).isActive = true
        headerTopContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding * 2).isActive = true
        headerTopContainerView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: padding * 2).isActive = true
        headerTopContainerView.heightAnchor.constraint(equalTo: headerTopContainerView.widthAnchor, multiplier: 1.0/1.5).isActive = true

//        let divider = addDivider(on: headerView, topOf: headerTopContainerView)

        






//        NSLayoutConstraint(item: headerContainerView, attribute: .bottom, relatedBy: .equal, toItem: headerView, attribute: .top, multiplier: 1, constant: 0).isActive = true
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
//        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
//        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
//        let heightAnchor = headerView.heightAnchor.constraint(lessThanOrEqualToConstant: 30)
//        heightAnchor.priority = .defaultHigh
//        heightAnchor.isActive = true

//        let headerContainerView = UIView()
//        headerContainerView.backgroundColor = .black
//        headerView.addSubview(headerContainerView)
//        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
//        headerContainerView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: padding * 2).isActive = true
//        headerContainerView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: padding * 2).isActive = true
//        headerContainerView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
//        headerContainerView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTable?.delegate = self
        contentTable?.dataSource = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Apply pay"

    }
}

extension WalletViewController: UITableViewDelegate {

}

extension WalletViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        return cell

    }
}
