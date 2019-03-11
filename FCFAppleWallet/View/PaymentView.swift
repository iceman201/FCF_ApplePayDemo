//
//  PaymentView.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 10/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

class PaymentView: UIView {

    var sectionTitle: UILabel?
    let kPaymentReceiverIdentifier = "kPaymentReceiverIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        let title = UILabel()
        title.textColor = .fiservOrange
        self.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.sectionTitle = title

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = UIScreen.main.bounds.size
        flowLayout.minimumLineSpacing = padding * 2
        flowLayout.minimumInteritemSpacing = padding * 2

        let container = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        container.decelerationRate = .fast
        container.backgroundColor = .clear
        container.showsHorizontalScrollIndicator = false
        container.dataSource = self
        container.delegate = self
        container.register(PaymentContactCollectionCell.self, forCellWithReuseIdentifier: kPaymentReceiverIdentifier)
        if let flowLayout = container.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionHeadersPinToVisibleBounds = true
        }
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

// MARK: Collection Delegate
extension PaymentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item + 1)
    }
}

extension PaymentView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPaymentReceiverIdentifier,
                                                            for: indexPath) as? PaymentContactCollectionCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0 {
            cell.loadInfo(name: nil, avatar: #imageLiteral(resourceName: "Add"))
        } else {
            cell.loadInfo(name: "haha", avatar: #imageLiteral(resourceName: "001-mastercard"))
        }
        cell.backgroundColor = .cyan
        return cell
    }
}

extension PaymentView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: padding * 10, height: padding * 10)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 16, left: 0, bottom: 16, right: 0)
    }
}

// MARK: PaymentCollectionCell
class PaymentContactCollectionCell: UICollectionViewCell {
    
    private var nameLabel: UILabel?
    private var avatar: UIImageView?
    private var avatarCenterY: NSLayoutConstraint?
    private var height: CGFloat = padding * 5
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        self.layer.cornerRadius = defaultCornerRadius
        
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFit
        avatar.backgroundColor = .brown
        self.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        let avatarCenter = avatar.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -padding)
        avatarCenter.isActive = true
        self.avatarCenterY = avatarCenter
        avatar.heightAnchor.constraint(lessThanOrEqualToConstant: height).isActive = true
        avatar.widthAnchor.constraint(equalTo: avatar.heightAnchor).isActive = true
        self.avatar = avatar
        
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 12)
        self.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: padding).isActive = true
        name.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.nameLabel = name
    }
    
    func loadInfo(name: String?, avatar: UIImage) {
        self.avatar?.image = avatar
        if let name = name {
            self.nameLabel?.text = name
        } else {
            self.nameLabel?.removeFromSuperview()
            self.avatarCenterY?.constant = 0
            self.avatar?.heightAnchor.constraint(lessThanOrEqualToConstant: padding * 3.5).isActive = true
        }
    }
}

