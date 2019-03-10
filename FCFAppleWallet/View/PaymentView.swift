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
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
//        flowLayout.minimumInteritemSpacing = 16;
//        flowLayout.minimumLineSpacing = 16;
//        self.collectionViewLayout = flowLayout;

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = UIScreen.main.bounds.size
        flowLayout.minimumLineSpacing = padding * 2
        flowLayout.minimumInteritemSpacing = padding * 2
        let container = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        container.decelerationRate = .fast
        container.dataSource = self
        container.delegate = self
        container.register(PaymentContactCollectionCell.self, forCellWithReuseIdentifier: kPaymentReceiverIdentifier)
        container.backgroundColor = .red
        if let flowLayout = container.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionHeadersPinToVisibleBounds = true
        }
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    
    }
}

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPaymentReceiverIdentifier, for: indexPath) as? PaymentContactCollectionCell else {
            return UICollectionViewCell()
        }
        cell.loadInfo(name: "haha", avatar: #imageLiteral(resourceName: "001-mastercard"))
        cell.backgroundColor = .cyan
        return cell
    }
}

extension PaymentView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width - 16, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
    }
}

class PaymentContactCollectionCell: UICollectionViewCell {
    
    private var nameLabel: UILabel?
    private var avatar: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        let avatar = UIImageView()
        self.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        avatar.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: padding).isActive = true
        self.avatar = avatar
        
        let name = UILabel()
        self.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: padding).isActive = true
        name.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.nameLabel = name
    }
    
    func loadInfo(name: String, avatar: UIImage) {
        self.nameLabel?.text = name
        self.avatar?.image = avatar
    }
}

