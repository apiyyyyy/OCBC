//
//  HomeModel.swift
//  OCBC_Test_App
//
//  Created by Family on 10/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import Foundation


class HomeModel {
    
    let service = APIService.shared
    var transactionList : [Transaction] = []
    var statusCode: StatusCode?
    var profile : Profile?
    
    func getBalance(completion: @escaping(StatusCode, Int) -> ()) {
        
        service.getBalance { (statusCode, balance) in
            
            self.statusCode = statusCode
            completion(statusCode, balance)
        }
    }
    
    func getTransaction(completion : @escaping(StatusCode) -> ()) {
        service.getTransaction { (statusCode, data) in
            self.statusCode = statusCode
            if statusCode.status == SUCCESS{
                for i in 0..<data.count{
                    self.transactionList.append(Transaction.init(data: data[i]))
                }
                print("transaction list \(self.transactionList)")
            }
            completion(statusCode)
        }
    }
    
    
}
