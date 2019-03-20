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
    public enum FontAwesomeWeight {
        case Regular
        case Solid
        case Branding
    }

    public class func fontAwesome(ofSize fontSize: CGFloat, weight: FontAwesomeWeight = .Solid) -> UIFont {
        switch weight {
        case .Regular:
            return UIFont(name: "FontAwesome5Free-Regular", size: fontSize)!
        case .Solid:
            return UIFont(name: "FontAwesome5Free-Solid", size: fontSize)!
        case.Branding:
            return UIFont(name: "FontAwesome5Brands-Regular", size: fontSize)!
        }

    }
    public class func paymentLogo(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: "paymentfont-webfont", size: fontSize)!
    }
}

