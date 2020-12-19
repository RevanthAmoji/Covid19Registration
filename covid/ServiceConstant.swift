//
//  ServiceConstant.swift
//  SmartHealthAnalytics
//
//  Created by integra on 05/09/18.
//  Copyright © 2018 DES. All rights reserved.
//

import Foundation

enum Endpoint {
    
    static let mainServer = "https://covid19api.sutherlandglobal.com/api"
    
    
    static let account = mainServer + "/Account"
    
    static let relation = mainServer + "/Scheduling?DD_Group=CC_Relationship"
    
    static let errorMessage = "Something went wrong, Please try again"
}
    
enum ServiceResult<Value> {
    case success(value: Value)
    case failure(error: Error)
}
