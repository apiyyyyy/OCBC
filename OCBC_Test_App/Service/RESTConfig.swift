//
//  RESTConfig.swift
//  OCBC_Test_App
//
//  Created by Family on 11/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import Foundation


struct RESTConfig{
    static let shared = RESTConfig()
    
    enum Header {
        case NONTOKEN
        case TOKEN
    }
    
    enum HTTPMethod: String {
        case POST = "POST"
        case GET = "GET"
    }
    
    func requestConfig(endpoint: String, method: HTTPMethod, header: Header, parameters: [String:Any]?) -> URLRequest {
        var request = URLRequest(url: NSURL.init(string: endpoint)! as URL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = defineHeader(header: header)
        if parameters != nil {
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameters!, options: [])
        }
        return request
    }
    
    func defineHeader(header: Header) -> [String:String] {
        if header == Header.NONTOKEN {
            let headers = [
                "Content-Type" : "application/json",
                "Accept" : "application/json"
            ]
            return headers
        }else if header == Header.TOKEN {
            let headers = [
                "Content-Type" : "application/json",
                "Accept" : "application/json",
                "Authorization" : AUTHORIZATION_TOKEN
            ]
            return headers
        }
        return [:]
    }
    
}
