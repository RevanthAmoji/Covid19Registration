//
//  DashboardService.swift
//  SmartHealthAnalytics
//
//  Created by integra on 05/09/18.
//  Copyright © 2018 DES. All rights reserved.
//

import Foundation
import Alamofire

class DashboardService {
    
    /*
      - Calling GetKpiReport Webservice
    */
    func getKpiDashboardData(url:String,strData:String,completion: @escaping (_ : ServiceResult<ServerResponse>) -> Void) {
       

        let authUrl = url
        var request = URLRequest(url: try! authUrl.asURL())
        request.httpMethod = "POST"
      
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // *** Here, Convert Array to NSData format and assign to httpbody ***
//        let data = try! JSONSerialization.data(withJSONObject: dic, options: [])
//
       let dic = strData
        
        let data = Data(dic.utf8)

                //In Papmoniter Service, sending inputs in request body
                request.httpBody = data
        
        AF.request(request).responseJSON { response in
//            print("Upload Personalized KPI Response \(response)")
            switch (response.result) {
            case .success:
                
                do {
                    let responseDecoder = try JSONDecoder().decode(ServerResponse.self, from: response.data!)
                    // print("getAppointmentData Dashboard Response \(String(describing: responseDecoder.data?.count))")
                    completion(ServiceResult.success(value: responseDecoder))
                }
                catch let e {
                    print("decoder error \(e)")
                    completion(ServiceResult.failure(error: e))
                }
            case .failure(let error):
                completion(ServiceResult.failure(error:error))
            }
        }
        
       
    }
    
    func getRelationData(url:String,completion: @escaping (_ : ServiceResult<[RelationModel]>) -> Void) {
       
        let authUrl = url
        var request = URLRequest(url: try! authUrl.asURL())
        request.httpMethod = "GET"
      
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseJSON { response in
//            print("Upload Personalized KPI Response \(response)")
            switch (response.result) {
            case .success:
                
                do {
                    let responseDecoder = try JSONDecoder().decode([RelationModel].self, from: response.data!)
                    // print("getAppointmentData Dashboard Response \(String(describing: responseDecoder.data?.count))")
                    completion(ServiceResult.success(value: responseDecoder))
                }
                catch let e {
                    print("decoder error \(e)")
                    completion(ServiceResult.failure(error: e))
                }
            case .failure(let error):
                completion(ServiceResult.failure(error:error))
            }
        }
        
    }
    
    
    func getLocationData(url:String,completion: @escaping (_ : ServiceResult<[Stadium]>) -> Void) {
       
        let authUrl = url
        var request = URLRequest(url: try! authUrl.asURL())
        request.httpMethod = "GET"
      
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseJSON { response in
//            print("Upload Personalized KPI Response \(response)")
            switch (response.result) {
            case .success:
                
                do {
                    let responseDecoder = try JSONDecoder().decode([Stadium].self, from: response.data!)
                    // print("getAppointmentData Dashboard Response \(String(describing: responseDecoder.data?.count))")
                    completion(ServiceResult.success(value: responseDecoder))
                }
                catch let e {
                    print("decoder error \(e)")
                    completion(ServiceResult.failure(error: e))
                }
            case .failure(let error):
                completion(ServiceResult.failure(error:error))
            }
        }
    }
    
    
    func getSlotsData(url:String,completion: @escaping (_ : ServiceResult<slots>) -> Void) {
       
        let authUrl = url
        var request = URLRequest(url: try! authUrl.asURL())
        request.httpMethod = "GET"
      
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseJSON { response in
//            print("Upload Personalized KPI Response \(response)")
            switch (response.result) {
            case .success:
                
                do {
                    let responseDecoder = try JSONDecoder().decode(slots.self, from: response.data!)
                    // print("getAppointmentData Dashboard Response \(String(describing: responseDecoder.data?.count))")
                    completion(ServiceResult.success(value: responseDecoder))
                }
                catch let e {
                    print("decoder error \(e)")
                    completion(ServiceResult.failure(error: e))
                }
            case .failure(let error):
                completion(ServiceResult.failure(error:error))
            }
        }
    }
}
