//
//  LoginModel.swift
//  OCBC_Test_App
//
//  Created by Family on 08/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class LoginModel {
    
    var statusCode:StatusCode?
    let service = APIService.shared
    
    func doLogin(username: String, password: String, completion: @escaping (StatusCode) -> ()) {
        
        let parameters:[String:Any] = [
            "username": username,
            "password": password
        ]
        
        service.doLogin(parameters: parameters) { (statusCode) in
            
            self.statusCode = statusCode
            completion(statusCode)
        }
    }
    
    
    
    
}
