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
    var AvailableSlots:Int?
}


struct ServerResponse:Codable {
    
    var isSuccess:Bool?
    var Message:String?
   
}

struct RelationModel:Codable {
    var Text:String?
    var Value:String?
}


struct MyScheduleTests:Codable {
    
    var SlotNo:Int?
    var PatientName:String?
    var ClinicName:String?
    var ClinicAddress:String?
    var TestDate:String?
    var TestTime:String?
    var PatientRelationship:String?
    var Latidude:String?
    var Logitude:String?
}

struct AccountDetails:Codable {
    var StatusCode:Int?
    var Message:String?
    var Data:[AccountData]?
}

struct AccountData:Codable {
    var EmailAddress:String?
    var PatientRelationshipVal:String?
    var PatientRelationshipText:String?
    var PatientAge:String?
    var PatientFirstName:String?
    var PatientLastName:String?
    var PatientConsent:String?
    var GuardianFullName:String?
    var HasCoronasymptoms:Int?
    var SymptomsStartedDate:String?
    var ProritizedTesting:String?
    var IsFirstTimeTest:String?
    var ContactedLast15days:String?
    var MedicalCondition:String?
    var IsPregnant:String?
    var IsHighriskCategory:String?
    var IsSmoke:String?
    var hasPrimarycareProv:Int?
    var PrimaryCareName:String?
    var PrimaryCareAddLine1:String?
    var PrimaryCareAddLine2:String?
    var PrimaryCareCity:String?
    var PrimaryCareState:String?
    var PrimaryCareZipcode:String?
    var PrimaryCareEmail:String?
    var PrimaryCarePhone:String?
    var hasCareFacility:Int?
    var PatientDOB:String?
    var PatientGenderVal:String?
    var PatientGenderText:String?
    var PatientEthnicityVal:String?
    var PatientEthnicityText:String?
    var PatientAddLine1:String?
    var PatientAddLine2:String?
    var PatientCity:String?
    var PatientState:Int?
    var PatientZipcode:String?
    var PatienthasMedicalInsu:String?
    var PatientInsuranceName:String?
    var PatientPolicyno:String?
    var PatientPolicyholderName:String?
    var PatienthasvalididentificationVal:String?
    var PatienthasvalididentificationText:String?
    var PatientIdentificationName:String?
    var Password:String?
}
