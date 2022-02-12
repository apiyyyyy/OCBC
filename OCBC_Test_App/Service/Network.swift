//
//  Network.swift
//  OCBC_Test_App
//
//  Created by Family on 08/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import Foundation
import SwiftyJSON


let BASE_SERVER : String = "https://green-thumb-64168.uc.r.appspot.com/"


let LOGIN : String = BASE_SERVER + "login"
let REGISTER : String = BASE_SERVER + "register"
let TRANSFER : String = BASE_SERVER + "transfer"
let BALANCE : String = BASE_SERVER + "balance"
let PAYEES : String = BASE_SERVER + "payees"
let TRANSACTION : String = BASE_SERVER + "transactions"
let FAILED = "failed"
let SUCCESS = "success"


struct StatusCode {
    
    var code:Int
    var status: String
     
    init(code:Int, status:String) {
        self.code = code
        self.status = status
    }
    
    init(json:JSON){
        self.code = json["code"].int ?? 500
        self.status = json["status"].string ?? FAILED
    }
}

