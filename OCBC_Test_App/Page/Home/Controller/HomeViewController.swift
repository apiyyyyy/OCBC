//
//  HomeViewController.swift
//  OCBC_Test_App
//
//  Created by Family on 10/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var accNoLabel: UILabel!
    @IBOutlet weak var accNameLabel: UILabel!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var makeTransferButton: UIButton!
    
    let homeModel = HomeModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBalance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareUI()
    }
    
    
    func getBalance() {
        
        homeModel.getBalance { (statusCode, balance ) in
            if statusCode.status == FAILED {
                showAlertDismiss(title: "Invalid Token", message: "please try again", view: self)
                print(statusCode)
            }else if statusCode.status == SUCCESS {
                ACCOUNT_BALANCE = balance
                self.balanceLabel.text = "\(ACCOUNT_BALANCE)"
            }
        }
    }
    
    func getListTransaction() {
        homeModel.getTransaction { statusCode in
            if statusCode.status == SUCCESS {
                DispatchQueue.main.async {
                    self.historyTableView.reloadData()
                }
            }
        }
    }
    
    func getNewList() {
        homeModel.getTransaction { statusCode in
            if statusCode.status == SUCCESS {
                DispatchQueue.main.async {
                    self.historyTableView.reloadRows(at: [IndexPath(row: 1, section: 1)], with: .top)
                 }
            }
        }
    }
    
    func prepareUI() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        makeTransferButton.setBorderButton()
        topView.layer.cornerRadius = 10
        
        accNoLabel.text = ACCOUNT_NO_REK
        accNameLabel.text = ACCOUNT_NAME
        
        refreshControl.attributedTitle = NSAttributedString(string: "pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        historyTableView.refreshControl = refreshControl
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { Timer in
            self.getListTransaction()
            self.refreshControl.endRefreshing()
        }
    }
    
    @IBAction func logoutSegue(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Do you want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeModel.transactionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = homeModel.transactionList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionListCell", for: indexPath) as! TransactionListCell
        
        cell.accNoLabel.text = data.sender.accountNo
        cell.nameLabel.text = data.sender.accountHolder
        
        if data.sender.accountNo == "" && data.sender.accountHolder == "" {
            cell.accNoLabel.text = "-"
            cell.nameLabel.text = "-"
        }
        
        
        if data.transactionType == "received" {
            cell.transactionLabel.textColor = .green
            cell.transactionLabel.text = "+ \(data.amount)"
        }else{
            cell.transactionLabel.textColor = .red
            cell.transactionLabel.text = "- \(data.amount)"
        }
        return cell
    }
    
    
}
