//
//  Style.swift
//  CitygoCustomStyles
//
//  Created by Piotr Shalatonin on 9/2/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import UIKit

protocol Style {
    func apply(_ control: AnyObject)
}

extension Style {
    func applyFont(_ font: UIFont, for control: AnyObject) {
        switch control {
        case let label as UIKit.UILabel:
            label.font = font
        case let textField as UIKit.UITextField:
            textField.font = font
        case let textView as UIKit.UITextView:
            textView.font = font
        case let button as UIKit.UIButton:
            button.titleLabel?.font = font
        default: break
        }
    }

    func applyTextColor(_ color: UIColor, for control: AnyObject) {
        switch control {
        case let label as UIKit.UILabel:
            label.textColor = color
        case let textField as UIKit.UITextField:
            textField.textColor = color
        case let textView as UIKit.UITextView:
            textView.textColor = color
        case let button as UIKit.UIButton:
            button.setTitleColor(color, for: .normal)
        default: break
        }
    }
}
