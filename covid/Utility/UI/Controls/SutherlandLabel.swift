//
//  SutherlandLabel.swift
//  Citygo
//
//  Created by Piotr Shalatonin on 9/14/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import UIKit

class SutherlandLabel: UILabel, Localizable {
    @IBInspectable
    var localizableKey: String? {
        didSet {
            if let key = localizableKey {
               LocalizationManager.shared.apply(localizableKey: key, for: self)
            }
        }
    }

//    @IBInspectable
//    public var styles: String = "" {
//        didSet {
//            StylesManager.shared.apply(styles: styles, for: self)
//        }
//    }
}
