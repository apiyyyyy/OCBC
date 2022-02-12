//
//  Global.swift
//  OCBC_Test_App
//
//  Created by Family on 09/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import Foundation
import UIKit


var AUTHORIZATION_TOKEN: String = ""
var ACCOUNT_BALANCE:Int = 0
var ACCOUNT_NAME: String = ""
var ACCOUNT_NO_REK: String = ""

func showAlertDismiss(title: String, message: String, view: UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    view.present(alert, animated: true)
}

func getCurrentDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    
    formatter.locale = Locale(identifier: "id_ID")
    formatter.dateFormat = "d MMMM yyyy"
    
    return formatter.string(from: date)
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension UIButton {
    func setButton(active: Bool) {
        if active {
            self.isUserInteractionEnabled = true
            self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.setTitleColor(#colorLiteral(red: 0.9564630389, green: 0.9463896155, blue: 0.9277232885, alpha: 1), for: .normal)
        } else {
            self.isUserInteractionEnabled = false
            self.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
            self.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        }
    }
    
    func setBorderButton() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.cornerRadius = 20
    }

}
