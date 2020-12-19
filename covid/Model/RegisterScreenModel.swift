//
//  RegisterScreenModel.swift
//  covid
//
//  Created by venkata baisani on 26/11/20.
//

import Foundation

struct RegisterScreenModel {
    
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
    
//    init(symptoms: String, dateSymptomsStarted: String) {
//        self.symptoms = symptoms
//        self.dateSymptomsStarted = dateSymptomsStarted
//    }
    
}


struct slots:Codable {
    
    var AvailableDates:[AvailableDates]?
    var Data:[Datas]?
   
}

struct AvailableDates:Codable {
    
    var Text:String?
    var Value:String?
   
}

struct Datas:Codable {
    
    var HospitalID:String?
    var SlotStart:String?
    var SlotEnd:String?
    var SlotID:String?
    var AppointmentDate:String?
    var AppointmentDateStr:String?
    var Address:String?
    var AvailableSlots:String?
}


struct ServerResponse:Codable {
    
    var isSuccess:Bool?
    var Message:String?
   
}

struct RelationModel:Codable {
    var Text:String?
    var Value:String?
}
