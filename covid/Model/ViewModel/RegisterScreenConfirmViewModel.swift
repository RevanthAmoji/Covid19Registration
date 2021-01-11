//
//  RegisterScreenConfirmViewModel.swift
//  covid
//
//  Created by venkata baisani on 02/12/20.
//

import Foundation

class RegisterScreenConfirmViewModel: NSObject {
    
    func validateEmailAddress(email: String) -> Bool {
        let regPlateString = email.isEmailValidate
        return regPlateString
    }
}
