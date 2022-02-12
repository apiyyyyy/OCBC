//
//  TransferVC.swift
//  OCBC_Test_App
//
//  Created by Afi Permana on 12/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import UIKit

class TransferVC: UIViewController {

    @IBOutlet weak var payeeTextField: UITextField!
    @IBOutlet weak var ammountTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var makeTransferButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let transferModel = TransferModel()
    var pickerPayees = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPayeesList()
    }
    
    
    func prepareUI(){
        makeTransferButton.setBorderButton()
        showError(message: "")
        createPicker()
        buttonReady()
    }
    
    func getPayeesList() {
        transferModel.getPayeesList()
    }
    
    func showError(message: String) {
        if message != "" {
            errorLabel.text = message
            errorLabel.isHidden = false
        }else {
            errorLabel.isHidden = true
        }
    }
    
    func buttonReady() {
        
        if payeeTextField.text != "" && ammountTextField.text != "" {
            makeTransferButton.setButton(active: true)
        }else{
            makeTransferButton.setButton(active: false)
        }
    }
    
    func createPicker() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(endEdit))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        pickerPayees.dataSource = self
        pickerPayees.delegate = self
        payeeTextField.inputView = pickerPayees
        payeeTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func endEdit() {
        self.view.endEditing(true)
    }
    
    @IBAction func payeeChanged(_ sender: Any) {
        buttonReady()
    }
    
    @IBAction func ammountChanged(_ sender: Any) {
        buttonReady()
    }
    
    @IBAction func makeTransferAction(_ sender: UIButton) {
        
        let ammount:Int! = Int(ammountTextField.text!)
        
        transferModel.doTransfer(receipentAccNo: transferModel.accountNum, ammount: ammount, description: descriptionTextField.text!) { statusCode in
            
            if statusCode.status == SUCCESS {
                let alert = UIAlertController(title: "Success", message: "Your transfer is Success", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                    self.navigationController?.popViewController(animated: true)
                }))
                    
                self.present(alert, animated: true, completion: nil)
            }else if statusCode.status == FAILED && statusCode.code == 400 {
                self.showError(message: "Insufficient balance")
            }
        }
    
    }
}

extension TransferVC: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return transferModel.listPayees.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return transferModel.listPayees[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        payeeTextField.text = transferModel.listPayees[row].name
        transferModel.accountNum = transferModel.listPayees[row].accountNo
        buttonReady()
    }
    
    
}
