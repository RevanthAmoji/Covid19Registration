//
//  RegisterScreenThreeModel.swift
//  covid
//
//  Created by venkata baisani on 24/11/20.
//

import Foundation

class RegisterScreenThreeModel: NSObject {
    
    func validateEmailAddress(email: String) -> Bool {
        let regPlateString = email.isEmailValidate
        return regPlateString
    }
}
