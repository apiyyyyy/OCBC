//
//  RegisterViewController.swift
//  OCBC_Test_App
//
//  Created by Family on 10/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let registerModel = RegisterModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       prepareUi()
    }
    
    @IBAction func userNameTextFieldChanged(_ sender: Any) {
        buttonReady()
    }
    
    @IBAction func passwordChanged(_ sender: Any) {
        buttonReady()
    }
    
    @IBAction func confirmPassChanged(_ sender: Any) {
        buttonReady()
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        
        registerModel.doRegis(username: usernameTextField.text!, password: passwordTextField.text!) { (statusCode) in
            
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
            self.confirmPassTextField.text = ""
            
            if statusCode.status == SUCCESS {
                
                let alert = UIAlertController(title: "Register success", message: "You can now login", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                    self.navigationController?.popViewController(animated: true)
                }))
                    
                self.present(alert, animated: true, completion: nil)
            }else{
                showAlertDismiss(title: "Register Failed", message: "try again later", view: self)
                
                print("error \(statusCode)")
            }
        }
    }
    
    func prepareUi() {
        registerButton.setBorderButton()
        buttonReady()
        hideKeyboardWhenTappedAround()
    }
    
    func buttonReady() {
        if usernameTextField.text != "" && passwordTextField.text != "" && confirmPassTextField.text != "" {
            if passwordTextField.text == confirmPassTextField.text {
                registerButton.setButton(active: true)
            }
        }else{
            registerButton.setButton(active: false)
        }
    }
}
