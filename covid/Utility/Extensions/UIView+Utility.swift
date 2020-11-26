//
//  UIView+Utility.swift
//  Citygo
//
//  Created by Piotr Shalatonin on 9/25/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import UIKit

extension UIView {
    func insertInto(container: UIView) {
        insertInto(container: container, top: 0, right: 0, left: 0, bottom: 0)
    }

    func insertInto(container: UIView, top: CGFloat, right: CGFloat, left: CGFloat, bottom: CGFloat) {
        container.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: container.topAnchor, constant: top).isActive = true
        rightAnchor.constraint(equalTo: container.rightAnchor, constant: right).isActive = true
        leftAnchor.constraint(equalTo: container.leftAnchor, constant: left).isActive = true
        bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: bottom).isActive = true
    }
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidthV: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColorV: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    // Find the Top Most Viewcontroller
    func findViewController() -> UIViewController? {
           if let nextResponder = self.next as? UIViewController {
               return nextResponder
           } else if let nextResponder = self.next as? UIView {
               return nextResponder.findViewController()
           } else {
               return nil
           }
       }
}

