//
//  VendorRegTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 15/12/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorRegTableViewCell: UITableViewCell {

    @IBOutlet weak var mobileNoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var regnDateLabel: UILabel!
    
    var vendRegDetails:VendorRegDetails! {
        didSet{
            bindModelToViews()
        }
    }

    func bindModelToViews() {
        if let amount1 = vendRegDetails.telephone as? String{
            mobileNoLabel.text = amount1
        }

        if let amount1 = vendRegDetails.email_id as? String{
            emailLabel.text = amount1
        }
        
        if let amount1 = vendRegDetails.amount as? String{
            amountLabel.text = amount1
        }
        
        if let amount1 = vendRegDetails.registration_date as? String{
            regnDateLabel.text = amount1
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
