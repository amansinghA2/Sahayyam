//
//  TotalVendorListTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 25/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class TotalVendorListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var addSubscriptionButton: Button!
    
    @IBOutlet weak var changeMobileNoButton: Button!
    
    @IBOutlet weak var vendorImage: UIImageView!
    
    @IBOutlet weak var vendorNameLabel: UILabel!
    
    @IBOutlet weak var vendorMobileNoLabel: UILabel!
    
    @IBOutlet weak var vendorEmailIdLabel: UILabel!
    
    @IBOutlet weak var vendorCreatedByLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var noCustomerLabel: UILabel!
    
    
    var paidvendorList:PaidUnpaidVendor!{
        didSet{
            bindModeltoViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindModeltoViews() {
        
        if let vendorName = paidvendorList.name as? String {
            vendorNameLabel.text = vendorName
        }
        
        if let vendorName = paidvendorList.telephone as? String {
            vendorMobileNoLabel.text = vendorName
        }
        
        if let vendorName = paidvendorList.email as? String {
            vendorEmailIdLabel.text = vendorName
        }
        
        if let vendorName = paidvendorList.createBy as? String {
            vendorCreatedByLabel.text = vendorName
        }
        
        if let vendorName = paidvendorList.address as? String {
            addressLabel.text = vendorName
        }
        
        if let vendorName = paidvendorList.customer as? String {
            noCustomerLabel.text = vendorName
        }
        
        if let image = paidvendorList.image as? String {
            if image != "" {
                vendorImage.imageFromUrl(BASE_URL + image)
            }else{
                
            }
        }
  
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
