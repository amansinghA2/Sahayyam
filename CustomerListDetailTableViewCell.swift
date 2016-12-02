//
//  CustomerListDetailTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerListDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var emaildIdLabel: UILabel!
    
    @IBOutlet weak var registerDateLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var popUpImage: UIButton!
    
    @IBOutlet weak var proddIdLabel: UILabel!
    
    var customerList:CustomerList!{
        didSet{
            bindMOdelToViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindMOdelToViews() {
        
        if let emaildId = customerList.emailId as? String{
            emaildIdLabel.text = emaildId
        }
        
        if let registerDate = customerList.registerDate as? String{
            registerDateLabel.text = registerDate
        }
        
        if let address = customerList.address as? String{
            addressLabel.text = address
        }
        
        if let address = customerList.idCardType as? String{
            if address == "" {
              proddIdLabel.text = "--"
              popUpImage.hidden = true
            }else{
                popUpImage.hidden = false
            proddIdLabel.text = address
            }
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    
}
