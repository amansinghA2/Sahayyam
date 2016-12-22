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
    
    var pendingInvoiceList:PendingInvoiceList! {
        didSet{
            bindModelToViews()
        }
    }

    func bindModelToViews() {
        if let name = pendingInvoiceList.vendor_name as? String{
            nameLabel.text = name
        }
        
        if let name = pendingInvoiceList.shop_name as? String{
            shopNameLabel.text = name
        }
        
        if let name = pendingInvoiceList.telephone as? String{
            mobileNumber.text = name
        }
        
        if let name = pendingInvoiceList.address as? String{
            addressLabel.text = name
        }
        
        if let name = pendingInvoiceList.email as? String{
            emailIdLabel.text = name
        }
        
        if let name = pendingInvoiceList.city as? String{
            cityLabel.text = name
        }
        
        if let name = pendingInvoiceList.order_no as? String{
            orderNoLabel.text = name
        }
        
        if let name = pendingInvoiceList.invoice_no as? String{
            invoiceNumberLabel.text = name
        }
        
        if let name = pendingInvoiceList.invoice_amt as? String{
            invoiceAmountLabel.text = name
        }
        
        if let name = pendingInvoiceList.create_date as? String{
            invoiceDateLabel.text = name
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
}
