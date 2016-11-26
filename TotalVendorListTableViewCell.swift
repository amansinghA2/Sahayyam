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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindModeltoViews() {
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
