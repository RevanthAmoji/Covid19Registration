//
//  EmailAddressViewModel.swift
//  covid
//
//  Created by venkata baisani on 18/11/20.
//

import Foundation

class EmailAddressViewModel: NSObject {
    
    func validateEmailAddress(email: String) -> Bool {
        let regPlateString = email.isEmailValidate
        return regPlateString
    }
    func validatePhoneNumber(phone: String) -> Bool {
        let regPlateString = phone.isPhoneValidate
        return regPlateString
    }
}
