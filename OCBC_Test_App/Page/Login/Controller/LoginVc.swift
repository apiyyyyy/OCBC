//
//  LoginVc.swift
//  OCBC_Test_App
//
//  Created by Family on 08/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import UIKit

class LoginVc: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var loginModel = LoginModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }
    
    @IBAction func loginSegue(_ sender: UIButton) {
        self.loadingProcess(loading: true)
        
        loginModel.doLogin(username: usernameTextField.text!, password: passwordTextField.text!) { (statusCode) in
            print(statusCode.status)
            
            if statusCode.status == SUCCESS {
                
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.usernameTextField.text = ""
                self.passwordTextField.text = ""
                self.loadingProcess(loading: false)
            }else {
                self.showError(message: "Invalid Username / Password")
                self.loadingProcess(loading: false)
            }
        }
    }
    
    @IBAction func usernameChanged(_ sender: UITextField) {
        buttonReady()
    }
    
    @IBAction func passwordChanged(_ sender: UITextField) {
        buttonReady()
    }
    
    func prepareUI(){
        
        loginButton.setBorderButton()
        registerButton.setBorderButton()
        showError(message: "")
        loadingProcess(loading: false)
        buttonReady()
        hideKeyboardWhenTappedAround()
    }
    
    func showError(message: String) {
        if message != "" {
            passwordErrorLabel.text = message
            passwordErrorLabel.isHidden = false
        }else {
            passwordErrorLabel.isHidden = true
        }
    }
    
    func buttonReady() {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            loginButton.setButton(active: true)
        }else {
            loginButton.setButton(active: false)
        }
    }
    
    func loadingProcess(loading : Bool) {
        if loading {
            loginButton.isEnabled = false
            loadingIndicator.startAnimating()
        }else {
            loginButton.isEnabled = true
            loadingIndicator.stopAnimating()
        }
    }
    
}
