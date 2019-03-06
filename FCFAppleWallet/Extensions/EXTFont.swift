//
//  EXTFont.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 5/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    public static func fontAwesomeIcon(name: FontAwesome) -> String {
        let toIndex = name.rawValue.index(name.rawValue.startIndex, offsetBy: 1)
        return String(name.rawValue[name.rawValue.startIndex..<toIndex])
    }
}

public extension UIFont {
    public class func fontAwesome(ofSize fontSize: CGFloat, isBrandIcon: Bool = false) -> UIFont {
        return UIFont(name: isBrandIcon ? "FontAwesome5Brands-Regular" : "FontAwesome5Free-Solid", size: fontSize)!
    }
}

