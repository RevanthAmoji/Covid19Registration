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
//    lazy var infoLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont.Citygo.latoinfo400
//        label.textColor = UIColor.Citygo.formtitles
//        return label
//    }()

    fileprivate var infoLabel : UILabel?
    
    fileprivate var errorLabelHieght : NSLayoutConstraint?
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           setupTextField()
       }

       required init?(coder: NSCoder) {
            super.init(coder: coder)
          // setupTextField()
       }

       override func prepareForInterfaceBuilder() {
           super.prepareForInterfaceBuilder()
          // self.setupTextField()
       }

       private func setupTextField() {
         
        if self.infoLabel?.superview != nil{
            return
        }
        infoLabel = UILabel()
        infoLabel?.text = "info text"
        infoLabel?.textAlignment = self.textAlignment
        infoLabel?.textColor = UIColor.red
        infoLabel?.font = UIFont(name: (self.font?.fontName ?? "helvetica")!, size: 12)
        infoLabel?.sizeToFit()
        infoLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(infoLabel!)

        let trailingConstraint = NSLayoutConstraint.init(item: infoLabel!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint.init(item: infoLabel!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        errorLabelHieght = NSLayoutConstraint.init(item: infoLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)

        self.addConstraints([trailingConstraint,topConstraint])
        infoLabel?.addConstraint(errorLabelHieght!)
        
        errorLabelHieght?.constant = 15
        
        self.setNeedsDisplay()
       }
    
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
