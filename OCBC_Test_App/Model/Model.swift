//
//  Model.swift
//  OCBC_Test_App
//
//  Created by Family on 10/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Profile : Encodable {
    
    var userName : String
    var token : String
    var accountNo : String
    
    init(data: JSON) {
        self.userName = data["username"].string ?? ""
        self.token = data["token"].string ?? ""
        self.accountNo = data["accountNo"].string ?? ""
    }
}

struct Payees : Encodable {
    var id : String
    var name : String
    var accountNo : String
    
    init(data: JSON) {
        self.id = data["id"].string ?? ""
        self.name = data["name"].string ?? ""
        self.accountNo = data["accountNo"].string ?? ""
    }
}

struct Transaction: Encodable {
    
    var transactionId : String
    var amount : Double
    var transactionDate : String
    var description : String
    var transactionType : String
    var sender : Sender
    
    init(transactionId:String, amount: Double, transactionDate: String, description: String, transactionType: String, sender:Sender){
        self.transactionId = transactionId
        self.amount = amount
        self.transactionDate = transactionDate
        self.description = description
        self.transactionType = transactionType
        self.sender = sender
    }
    
    init(data: JSON) {
        self.transactionId = data["transactionId"].string ?? ""
        self.amount = data["amount"].double ?? 0
        self.transactionDate = data["transactionDate"].string ?? ""
        self.description = data["description"].string ?? ""
        self.transactionType = data["transactionType"].string ?? ""
        self.sender = Sender.init(data: data["sender"])
    }
}

struct Sender : Encodable {
    
    var accountNo: String
    var accountHolder : String
    
    init(accountNo: String, accountHolder: String){
        self.accountHolder = accountHolder
        self.accountNo = accountNo
    }
    
    init(data: JSON) {
        self.accountNo = data["accountNo"].string ?? ""
        self.accountHolder = data["accountHolder"].string ?? ""
    }
}
