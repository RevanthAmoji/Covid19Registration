//
//  SutherlandTextField.swift
//  Citygo
//
//  Created by Piotr Shalatonin on 9/14/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import UIKit

enum CitygoTextFieldState {
    case placeholder
    case normal
    case active
    case validation
    case error
    case disabled
}
extension CitygoTextFieldState {
var imageString: String {
    get {
        switch self {
        case .placeholder:
            return ""
        case .normal:
            return ""
        case .active:
            return ""
        case .validation:
            return "like"
        case .error:
            return "error-circle"
        case .disabled:
            return ""
        }
    }
    set {
       // newValue
        print(newValue)
    }
}
}
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
  
     public func showIconWithToolTip(uiState: CitygoTextFieldState) {
           let imageName = uiState.imageString
           let paddingView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(40), height: self.frame.size.height))
           let button = UIButton(type: .custom)
           button.setImage(UIImage(named: imageName), for: .normal)
           // button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
           button.frame = CGRect(x: CGFloat(0), y: CGFloat(paddingView.frame.size.height/2-10), width: CGFloat(20), height: CGFloat(20))
           if  uiState == .error {
               button.addTarget(self, action: #selector(self.showCustomToolTip(_:)), for: .touchUpInside)
           }
           paddingView.addSubview(button)
           rightView = paddingView
           rightViewMode = .always
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
            self.layer.borderColor = UIColor.init(hex: Colors.redColor.rawValue).cgColor
        } else {
            self.layer.borderWidth = 0
            self.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
