//
//  PaymentDetailsTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class PaymentDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var viewInvoiceButtonLabel: Button!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var transactionIdLabel: UILabel!
    @IBOutlet weak var paymentmethodLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    var vendorPayment:VendorPayment!{
        didSet{
            bindMOdelToViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindMOdelToViews() {
        
        if let name = vendorPayment.date as? String{
            dateLabel.text = name
        }
        
        if let priceMonthCustomer1 = vendorPayment.orderID as? String{
            orderIdLabel.text = priceMonthCustomer1
        }
        if let name = vendorPayment.amount as? String{
            amountLabel.text = name
        }
        if let name = vendorPayment.transactionID as? String{
            transactionIdLabel.text = String(name)
        }
        if let name = vendorPayment.paymentMethod as? String{
            paymentmethodLabel.text = name
        }
        if let name = vendorPayment.status as? String{
            statusLabel.text = name
        }
     
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
