//
//  UIFont+Styles.swift
//  Citygo
//
//  Created by Piotr Shalatonin on 9/9/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import UIKit

/*
 The font-weight values from thinnest to thickest are
 ultralight
 thin
 light
 regular
 medium
 semibold
 bold
 heavy
 black
 */

extension UIFont {
    enum Citygo {
        static let quicksand700 = citygoFont(name: .quicksandregular, size: 22.0)
        static let quicksandSemiBold700 = citygoFont(name: .quicksandsemibold, size: 22.0)
        static let quicksandBold700 = citygoFont(name: .quicksandbold, size: 22.0)
        
        static let lato400 = citygoFont(name: .latoregular, size: 16.0)
        static let lato700 = citygoFont(name: .latoregular, size: 16.0)
        static let latoinfo400 = citygoFont(name: .latoitalic, size: 12.0)
        static let latobtn700 = citygoFont(name: .latobold, size: 16.0)
        
        private static func citygoFont(name fontName: Citygo.FontFamily, size fontSize: CGFloat) -> UIFont {
            if let font = UIFont(name: fontName.rawValue, size: fontSize) {
                return font
            } else {
                return UIFont.systemFont(ofSize: fontSize)
            }
        }

        private enum FontSize: CGFloat {
            case titleHeadline1 = 22.0
            case titleHeadline2 = 20.0
            case titleHeadline3 = 18.0

            case bodyNormal = 14.0
            case bodyMedium = 12.0
            case bodySmall = 10.0
        }

        private enum FontFamily: String {
            case quicksandbold = "Quicksand-Bold"
            case quicksandmedium = "Quicksand-Medium"
            case quicksandregular = "Quicksand-Regular"
            case quicksandsemibold = "Quicksand-SemiBold"
            case quicksandligh = "Quicksand-Light"
            
            case latoitalic = "Lato-Italic"
            case latolightitalic = "Lato-LightItalic"
            case latothin = "Lato-Thin"
            case latobold = "Lato-Bold"
            case latoblack = "Lato-Black"
            case latoregular = "Lato-Regular"
            case latoblackitalic = "Lato-BlackItalic"
            case latobolditalic = "Lato-BoldItalic"
            case latolight = "Lato-Light"
            case latothinitalic = "Lato-ThinItalic"
        }
    }
}

/*
 
 SingletonData.shared.firstNamePatient = tfPatientFirstName.text
 SingletonData.shared.lastNamePatient = tfPatientLastName.text
 
 
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
 */
enum titles {
    
    static let symptoms = "Has \(SingletonData.shared.firstNamePatient ?? "") \(SingletonData.shared.lastNamePatient ?? "") developed coronavirus symptions?"
   
    static let dateSymptomsStarted = "Date symptoms started"
    
    static let proritizedForTesting = "Has \(SingletonData.shared.firstNamePatient ?? "") \( SingletonData.shared.lastNamePatient ?? "") been proritized for testing?"
    
    static let firstTimeTesting = "Is this \(SingletonData.shared.firstNamePatient ?? "") \( SingletonData.shared.lastNamePatient ?? "")'s first time taking a test?"
    
    static let contactWithAnyOne = "Has \(SingletonData.shared.firstNamePatient ?? "") \( SingletonData.shared.lastNamePatient ?? "") been in contact with anyone who has tested positive in the last 15 days?"
    
    
    static let medicalCondition = "Does \(SingletonData.shared.firstNamePatient ?? "") \( SingletonData.shared.lastNamePatient ?? "") have a chronic medical condition?"
    
    static let pregnant = "Is \(SingletonData.shared.firstNamePatient ?? "") \( SingletonData.shared.lastNamePatient ?? "") pregnant?"
    
    static let highRiskCategory = "Is \(SingletonData.shared.firstNamePatient ?? "") \( SingletonData.shared.lastNamePatient ?? "") over 65 years of age, or part of a high risk category?"
    
    static let smoker = "Does \(SingletonData.shared.firstNamePatient ?? "") \( SingletonData.shared.lastNamePatient ?? "") smoke, chew, or vape?"
    
    static let primaryCareProvider = "Does \(SingletonData.shared.firstNamePatient ?? "") \( SingletonData.shared.lastNamePatient ?? "") have a primary care provider?"
    
    
    static let careFacility = "Does \(SingletonData.shared.firstNamePatient ?? "") \( SingletonData.shared.lastNamePatient ?? "") live in a group setting e.g. Care Facility"
       
}

