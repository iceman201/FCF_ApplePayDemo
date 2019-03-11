//
//  EXTUserInterface.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 5/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

// MARK: UI Components
extension UIViewController {
    func addDivider(on headerView: UIView, topOf headerTopContainerView: UIView) -> UIView {
        let divider = UIView()
        divider.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        headerView.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: headerTopContainerView.bottomAnchor, constant: padding * 2).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding * 2).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding * 2).isActive = true
        return divider
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIView {
    func drawButtonShadow() {
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: defaultCornerRadius)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)//CGSizeMake(0.0f, 5.0f);
        self.layer.shadowOpacity = 0.7
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}


// MARK: UI Style sheet
let padding: CGFloat = 8
let defaultCornerRadius: CGFloat = 6

extension UIColor {
    open class var fiservOrange: UIColor {
        return UIColor(displayP3Red: 232/255, green: 111/255, blue: 45/255, alpha: 1)
    }
}
