//
//  TransactionListCell.swift
//  OCBC_Test_App
//
//  Created by Family on 11/02/22.
//  Copyright © 2022 Afi. All rights reserved.
//

import UIKit

class TransactionListCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accNoLabel: UILabel!
    @IBOutlet weak var transactionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
