//
//  UserDefaults.swift
//  covid
//
//  Created by venkata baisani on 29/12/20.
//

import Foundation
import UIKit


class UserData {
    static let shared = UserData()
    private init() {
    }
    
    func setIsUserLogin(boolVal:Bool? = false){
        UserDefaults.standard.set(boolVal, forKey: "IsLogin")
        UserDefaults.standard.synchronize()
    }
    func getIsUserLogin() -> Bool? {
        let boolVal = UserDefaults.standard.value(forKey: "IsLogin") as? Bool
        return boolVal
    }
    
    func setUserDetails(UserName:String, password:String){
        UserDefaults.standard.set(UserName, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
        UserDefaults.standard.synchronize()
    }
    func getPassword() -> String {
        return UserDefaults.standard.value(forKey: "password") as! String
    }
    func getUserName() -> String {
        return UserDefaults.standard.value(forKey: "username") as! String
    }
    
    func nilUserDetails(){
        UserDefaults.standard.set(false, forKey: "IsLogin")
        UserDefaults.standard.set("", forKey: "username")
        UserDefaults.standard.set("", forKey: "password")
    }
}
