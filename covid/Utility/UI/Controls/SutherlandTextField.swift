//
//  SutherlandTextField.swift
//  Citygo
//
//  Created by Piotr Shalatonin on 9/14/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import UIKit

class SutherlandTextField: UITextField {
//    @IBInspectable
//    public var styles: String = "" {
//        didSet {
//            StylesManager.shared.apply(styles: styles, for: self)
//        }
//    }
    @IBInspectable var leftPadingCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: newValue, height: self.frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    @IBInspectable var rightPaddingCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: newValue, height: self.frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    public func hideIcon() {
        let paddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(10), height: self.frame.size.height))
        rightView = paddingView
        rightViewMode = .never
      }
       @objc func showCustomToolTip(_ sender: UIButton?) {
          
       }
  
    func showBoaderColor(isEnable: Bool) {
        if isEnable {
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.Citygo.redColor.cgColor
        } else {
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
