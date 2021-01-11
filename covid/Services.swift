//
//  Services.swift
//  SmartHealthAnalytics
//
//  Created by integra on 05/09/18.
//  Copyright © 2018 DES. All rights reserved.
//

import Foundation

/*
    Collection to hold all services in place
*/
class Services {
    
    static var services: [String: AnyObject] = [:]
    
    class func getDashboardService() -> DashboardService {
        if services[String(describing: DashboardService.self)] == nil {
            services[String(describing: DashboardService.self)] = DashboardService()
        }
        return services[String(describing: DashboardService.self)] as! DashboardService
    }
    
}
