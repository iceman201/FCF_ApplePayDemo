//
//  Extension.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 13/12/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

import UIKit

extension UIViewController {
    func getValueFromPlist(identifier: String) -> String? {
        if let filePath = Bundle.main.path(forResource: "Info", ofType:"plist") {
            let value = NSDictionary(contentsOfFile:filePath)?[identifier] as? String
            return value
        } else {
            return nil
        }
    }
}
