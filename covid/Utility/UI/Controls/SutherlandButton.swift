//
//  SutherlandButton.swift
//  Sutherland
//
//  Created by Piotr Shalatonin on 9/28/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import UIKit

enum SutherlandButtonType: Int {
    case primary = 0
    case secondary = 1
}

class SutherlandButton: UIButton {
    
    @IBInspectable
    var localizableKey: String? {
        didSet {
            if let key = localizableKey {
                LocalizationManager.shared.apply(localizableKey: key, for: self)
            }
        }
    }
    
    func btnEnable(boolVal: Bool) {
        self.isEnabled = boolVal
        if boolVal {
            self.setTitleColor(UIColor.Citygo.buttonfieldsactive, for: .normal)
            self.backgroundColor = UIColor.Citygo.buttonfieldsInactive
        } else {
            self.setTitleColor(UIColor.Citygo.buttonfieldsInactive, for: .normal)
            self.backgroundColor = UIColor.Citygo.buttonInactiveBacground
        }
        self.layer.borderColor = UIColor.Citygo.buttonBorderColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
    }
    func btnHover(boolVal: Bool){
        self.isEnabled = boolVal
        if boolVal {
            self.setTitleColor(UIColor.Citygo.buttonfieldsactive, for: .normal)
            self.backgroundColor = UIColor.Citygo.buttonHoverStateColor
        } else {
            self.setTitleColor(UIColor.Citygo.buttonfieldsInactive, for: .normal)
            self.backgroundColor = UIColor.Citygo.buttonfieldsactive
        }
        self.layer.borderColor = UIColor.Citygo.buttonHoverStateColor.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
    }
}
