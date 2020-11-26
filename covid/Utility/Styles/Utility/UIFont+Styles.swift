//
//  UIFont+Styles.swift
//  Citygo
//
//  Created by Piotr Shalatonin on 9/9/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import UIKit

/*
 The font-weight values from thinnest to thickest are
 ultralight
 thin
 light
 regular
 medium
 semibold
 bold
 heavy
 black
 */

extension UIFont {
    enum Citygo {
        static let quicksand700 = citygoFont(name: .quicksandregular, size: 22.0)
        
        static let lato400 = citygoFont(name: .latoregular, size: 16.0)
        static let lato700 = citygoFont(name: .latoregular, size: 16.0)
        static let latoinfo400 = citygoFont(name: .latoitalic, size: 12.0)
        
        private static func citygoFont(name fontName: Citygo.FontFamily, size fontSize: CGFloat) -> UIFont {
            if let font = UIFont(name: fontName.rawValue, size: fontSize) {
                return font
            } else {
                return UIFont.systemFont(ofSize: fontSize)
            }
        }

        private enum FontSize: CGFloat {
            case titleHeadline1 = 22.0
            case titleHeadline2 = 20.0
            case titleHeadline3 = 18.0

            case bodyNormal = 14.0
            case bodyMedium = 12.0
            case bodySmall = 10.0
        }

        private enum FontFamily: String {
            case quicksandbold = "Quicksand-Bold"
            case quicksandmedium = "Quicksand-Medium"
            case quicksandregular = "Quicksand-Regular"
            case quicksandsemibold = "Quicksand-SemiBold"
            case quicksandligh = "Quicksand-Light"
            
            case latoitalic = "Lato-Italic"
            case latolightitalic = "Lato-LightItalic"
            case latothin = "Lato-Thin"
            case latobold = "Lato-Bold"
            case latoblack = "Lato-Black"
            case latoregular = "Lato-Regular"
            case latoblackitalic = "Lato-BlackItalic"
            case latobolditalic = "Lato-BoldItalic"
            case latolight = "Lato-Light"
            case latothinitalic = "Lato-ThinItalic"
        }
    }
}
