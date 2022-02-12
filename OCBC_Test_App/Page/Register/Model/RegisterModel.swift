//
//  RegisterModel.swift
//  OCBC_Test_App
//
//  Created by Family on 10/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import Foundation


class RegisterModel {
    
    let service = APIService.shared
    var statusCode : StatusCode?
    
    func doRegis(username: String, password: String, completion: @escaping (StatusCode) -> ()){
        
        let params: [String:Any] = [
            "username": username,
            "password": password,
        ]
        
        service.doRegister(parameters: params) { (statusCode) in
            
            self.statusCode = statusCode
            completion(statusCode)
        }
    }
}
