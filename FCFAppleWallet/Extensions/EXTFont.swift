//
//  EXTFont.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 5/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    public class func fontAwesome(ofSize fontSize: CGFloat, isBrandIcon: Bool = false) -> UIFont {
        return UIFont(name: isBrandIcon ? "FontAwesome5Brands-Regular" : "FontAwesome5Free-Solid", size: fontSize)!
    }
    public class func paymentLogo(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "paymentfont-webfont", size: fontSize)!
    }
}

