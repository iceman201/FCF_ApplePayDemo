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
        title.font = UIFont.systemFont(ofSize: 12)
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
        container.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPaymentReceiverIdentifier,
                                                            for: indexPath) as? PaymentContactCollectionCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0 {
          /*  - (UIImage *)imageFromString:(NSString *)string attributes:(NSDictionary *)attributes size:(CGSize)size
            {
                UIGraphicsBeginImageContextWithOptions(size, NO, 0);
                [string drawInRect:CGRectMake(0, 0, size.width, size.height) withAttributes:attributes];
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                return image;
            }*/
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor(hexString: "#FDC830").cgColor,
                                    UIColor(hexString: "#f7797d").cgColor,
                                    UIColor(hexString: "#F37335").cgColor]
            gradientLayer.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
            gradientLayer.cornerRadius = 64/2
            gradientLayer.backgroundColor = UIColor.clear.cgColor
            UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, false, 0.0)
            let context = UIGraphicsGetCurrentContext()
            gradientLayer.render(in: context!)
            
            let icon = "\(FontAwesome.plus)" as NSString
            icon.draw(in: CGRect(x: 6, y: 3, width: 64, height: 64), withAttributes: [NSAttributedString.Key.font: UIFont.fontAwesome(ofSize: 64), NSAttributedString.Key.foregroundColor: UIColor.fiservWhite.combineWith(opacity: .Solid)])
            
            let iconImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndPDFContext()
            
            cell.loadInfo(name: nil, avatar: iconImage!)
        } else {
            cell.loadInfo(name: "haha", avatar: UIImage(named: "\(indexPath.row)")!)
        }
        return cell
    }
}

extension PaymentView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: padding * 9, height: padding * 9)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding * 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding * 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: padding, left: padding, bottom: padding, right: 0)
    }
}

// MARK: PaymentCollectionCell
class PaymentContactCollectionCell: UICollectionViewCell {
    
    private weak var nameLabel: UILabel?
    private weak var avatar: UIImageView?
    private weak var avatarCenterY: NSLayoutConstraint?
    private weak var height: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        self.layer.cornerRadius = defaultCornerRadius * 1.5
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let avatar = UIImageView()
        avatar.contentMode = .scaleAspectFit
        self.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        let avatarCenter = avatar.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -padding)
        avatarCenter.isActive = true
        self.avatarCenterY = avatarCenter
        let heightAnchor = avatar.heightAnchor.constraint(equalToConstant: padding * 5)
        heightAnchor.isActive = true
        self.height = heightAnchor
        avatar.widthAnchor.constraint(equalTo: avatar.heightAnchor).isActive = true
        self.avatar = avatar
        
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 12)
        name.adjustsFontSizeToFitWidth = true
        name.textColor = UIColor.fiservOrange
        self.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: padding / 2).isActive = true
        name.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.nameLabel = name
    }
    
    func loadInfo(name: String?, avatar: UIImage) {
        self.avatar?.image = avatar
        if let name = name {
            self.nameLabel?.text = name
        } else {
            self.drawButtonShadow()
            self.nameLabel?.isHidden = true
            self.avatarCenterY?.constant = 0
            self.height?.constant = padding * 3
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let avatar = self.avatar else { return }
        avatar.layer.cornerRadius = avatar.frame.height / 2
        avatar.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatar?.image = nil
        self.nameLabel?.text = nil
        self.layer.shadowOpacity = 0.0
        self.nameLabel?.isHidden = false
        self.avatarCenterY?.constant = -padding
        self.height?.constant = padding * 5
        self.avatar?.widthAnchor.constraint(equalTo: self.avatar!.heightAnchor).isActive = true
        self.layoutIfNeeded()
    }
}

