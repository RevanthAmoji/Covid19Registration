//
//  String+Utility.swift
//  Citygo
//
//  Created by venkata baisani on 28/10/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import Foundation

extension String {
    var isRegisterPlate: Bool {
        let regex = "[0-9A-Z]{2}\\-[0-9]{3}\\-[0-9A-Z]{2}"
        let regPred = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = regPred.evaluate(with: self)
        return isValid
    }//{0,61}
    var isModelValidate: Bool {
        let regex = "[0-9A-Za-z]{2,15}"
        let regPred = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = regPred.evaluate(with: self)
        return isValid
    }
    var isEmailValidate:Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regPred = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = regPred.evaluate(with: self)
        return isValid
    }
}
