//
//  PendingInvoiceTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class PendingInvoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var shopNameLabel: UILabel!
    
    @IBOutlet weak var mobileNumber: UILabel!
    
    @IBOutlet weak var emailIdLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var orderNoLabel: UILabel!
    
    @IBOutlet weak var invoiceNumberLabel: UILabel!
    
    @IBOutlet weak var invoiceAmountLabel: UILabel!
    
    @IBOutlet weak var invoiceDateLabel: UILabel!
    
    @IBOutlet weak var payOnlineButton: Button!
    
    @IBOutlet weak var payOfflineButton: Button!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
}
