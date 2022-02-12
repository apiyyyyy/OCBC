//
//  TransferModel.swift
//  OCBC_Test_App
//
//  Created by Afi Permana on 12/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import Foundation



class TransferModel {
    
    var statusCode: StatusCode?
    let service = APIService.shared
    var listPayees : [Payees] = []
    var accountNum = ""
    
    func getPayeesList() {
        service.getPayees { statusCode, data in
            self.statusCode = statusCode
            if statusCode.status == SUCCESS {
                for i in 0..<data.count {
                    self.listPayees.append(Payees.init(data: data[i]))
                }
            }
        }
    }
    
    func doTransfer(receipentAccNo: String, ammount: Int, description: String, completion: @escaping(StatusCode) -> ()) {
        
        let params : [String:Any] = [
            "receipientAccountNo": receipentAccNo,
            "amount": ammount,
            "description": description
        ]
        
        service.doTransfer(parameters: params) { statusCode in
            
            self.statusCode = statusCode
            
            completion(statusCode)
        }
        
    }
    
    
    
    
}
