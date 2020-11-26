//
//  SingletonData.swift
//  covid
//
//  Created by venkata baisani on 26/11/20.
//

import Foundation

class SingletonData {
    
    static let shared = SingletonData()
    private init() {
    }
        
    var symptoms:String?
    var dateSymptomsStarted:String?
    var proritizedForTesting:String?
    var firstTimeTesting:String?
    var contactWithAnyOne:String?
    var medicalCondition:String?
    var pregnant:String?
    var highRiskCategory:String?
    var smoker:String?
    var primaryCareProvider:String?
    var careFacility:String?
    var careProvider:String?
    var addressLineOne:String?
    var addressLineTwo:String?
    var city:String?
    var state:String?
    var zipCode:String?
    var phoneNumber:String?
    var emailAddress:String?

}
