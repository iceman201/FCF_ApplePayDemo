//
//  EXTUserInterface.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 5/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit

// MARK: UI Components
extension UIView {
    func addDivider(on headerView: UIView, topOf headerTopContainerView: UIView, color: UIColor = .white) -> UIView {
        let divider = UIView()
        divider.backgroundColor = color.withAlphaComponent(0.8)
        headerView.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.topAnchor.constraint(equalTo: headerTopContainerView.bottomAnchor, constant: padding * 2).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        divider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding * 2).isActive = true
        divider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding * 2).isActive = true
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
    enum ColorOpacity: Float {
        case Solid = 1.0                // 100%
        case Primary = 0.9              // 90%
        case Secondary = 0.6            // 60%
        case Teriary = 0.4              // 40%
        case Disable = 0.3              // 30%
        case Divider = 0.2              // 20%
        case BTPressed = 0.1            // 10%
        case AlternativeBG = 0.05       // 5%
    }
    
    open class var fiservOrange: UIColor {
        return UIColor(displayP3Red: 232/255, green: 111/255, blue: 45/255, alpha: 1)
    }
    open class var fiservWhite: UIColor {
        //Note: Somehow Apple white doesn't contain blue index
        return UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    open class var fiservBlack: UIColor {
        //Note: Somehow Apple white doesn't contain blue index
        return UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
    }
    
    func combineWith(opacity: ColorOpacity) -> UIColor {
        
        let rgbCGColour = self.cgColor
        let rgbColours = rgbCGColour.components
        guard let red = rgbColours?[0],
            let green = rgbColours?[1],
            let blue = rgbColours?[2] else {
                print("Error")
                return self
        }

        let combineRed = (red*255) * CGFloat(opacity.rawValue) + CGFloat(1 - opacity.rawValue) * 255
        let combineGreen = (green*255) * CGFloat(opacity.rawValue) + CGFloat(1 - opacity.rawValue) * 255
        let combineBlue = (blue*255) * CGFloat(opacity.rawValue) + CGFloat(1 - opacity.rawValue) * 255
        
        return UIColor(displayP3Red: combineRed/255.0, green: combineGreen/255.0, blue: combineBlue/255.0, alpha: 1)
    }
}

/* linear equations
 opacity x Overlay + (1-opacity) * Background

Variables:
c - color (unknown)
f - opacity (unknown)

Equations:
c * f + (1 − f) * 255 = 160. (blending with white)
c * f + (1 − f) * 0 = 73. (blending with black)

Rearrange to get:
c * f − 255 f = −95.
c * f = 73.
255 f = 168.

Therefore:
f = 168/255 ≈ 65.9%.
c = 6205/56 ≈ 110.8.
*/
