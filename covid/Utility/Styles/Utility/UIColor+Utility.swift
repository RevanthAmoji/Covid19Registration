//
//  UIColor+Utility.swift
//  CitygoCustomStyles
//
//  Created by Piotr Shalatonin on 9/3/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexCode: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if (hexCode.hasPrefix("#")) {
            hexCode = String(hexCode.dropFirst())
        }

        if (hexCode.lengthOfBytes(using: String.Encoding.utf8) != 6) {
            self.init(red: CGFloat(1.0), green: CGFloat(0.0), blue: CGFloat(5.0), alpha: CGFloat(1.0) )
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexCode).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

    convenience init( rgbValue: Int, alpha: CGFloat = 1.0 ) {
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha )
    }
}
