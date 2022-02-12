//
//  APIService.swift
//  OCBC_Test_App
//
//  Created by Family on 10/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIService {
    static let shared = APIService()

    let tokenHeader: HTTPHeaders = [
        "Authorization" : AUTHORIZATION_TOKEN
    ]
    
    func doLogin(parameters:[String:Any], completion: @escaping (StatusCode) -> ()) {

        AF.request(LOGIN, method: .post
            , parameters: parameters, headers: .default).responseData {
                response in
                switch response.result {
                case .success:
                    let json = JSON(response.data!)
                    let statusCode = StatusCode.init(json: json)
                    AUTHORIZATION_TOKEN = json["token"].string ?? ""
                    ACCOUNT_NAME = json["username"].string ?? ""
                    ACCOUNT_NO_REK = json["accountNo"].string ?? ""
                    completion(statusCode)
                case .failure:
                    let json = JSON(response.data)
                    print("Login API Error \(json)")
            }
        }
    }
    
    func doRegister(parameters:[String:Any], completion: @escaping (StatusCode) -> ()){
        
        AF.request(REGISTER, method: .post, parameters: parameters, headers: .default).responseData {
            response in
            let json = JSON(response)
            print("json regis \(json)")
            switch response.result {
            case .success:
                let statusCode = StatusCode.init(json: json)
                completion(statusCode)
                
            case .failure:
                print("Register API Error \(json)")
            }
        }
    }
    
    func doTransfer(parameters: [String:Any], completion: @escaping (StatusCode) -> ()) {
        
        let request: URLRequest = RESTConfig.shared.requestConfig(endpoint: TRANSFER, method: .POST, header: .TOKEN, parameters: parameters)
        
        AF.request(request).responseData {
            response in
            let json = JSON(response.data!)
            switch response.result {
            case .success:
                let statusCode = StatusCode.init(json: json)
                completion(statusCode)
                
            case .failure:
                print("Transfer API Error \(json)")
            }
        }
    }
    
    func getBalance(completion: @escaping (StatusCode, Int) -> ()) {
        
        let request: URLRequest = RESTConfig.shared.requestConfig(endpoint: BALANCE, method: .GET, header: .TOKEN, parameters: nil)
        
        AF.request(request).responseData {
            response in
            let json = JSON(response.data!)
            print("json balance \(json)")
            switch response.result {
            case.success :
                let statusCode = StatusCode.init(json: json)
                let data = json["balance"].int ?? 0
                completion(statusCode, data)
                
            case.failure:
                print("Balance API Error \(json)")
            }
        }
    }
    
    func getPayees(completion: @escaping (StatusCode, JSON) -> ()) {
        
        let request:URLRequest = RESTConfig.shared.requestConfig(endpoint: PAYEES, method: .GET, header: .TOKEN, parameters: nil)
        
        AF.request(request).responseData {
            response in
            let json = JSON(response.data!)
            
            switch response.result {
            case .success:
                
                let statusCode = StatusCode(json: json)
                let data = json["data"]
                
                completion(statusCode, data)
                
            case .failure:
                print("Payees API Error \(json)")
            }
            
        }
    }
    
    func getTransaction(completion: @escaping (StatusCode, JSON) -> ()) {
        
        let request: URLRequest = RESTConfig.shared.requestConfig(endpoint: TRANSACTION, method: .GET, header: .TOKEN, parameters: nil)
        
        AF.request(request).responseData {
            response in
            let json = JSON(response.data!)
            switch response.result {
            case .success(_):
                let statusCode = StatusCode(json: json)
                let data = json["data"]
                
                completion(statusCode, data)
            case .failure(_):
                print("Transaction API Error \(json)")
            }
        }
    }
    
    
    
    
}
