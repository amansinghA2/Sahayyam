//
//  CustomerListTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerListTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var customerListButtonlabel: UIButton!
    
    
    @IBOutlet weak var blockUnblockButton: UIButton!
    
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
        
        if let name = customerList.name as? String{
            nameLabel.text = name
        }
        
        if let mobileNumber = customerList.mobileNumber as? String{
            numberLabel.text = mobileNumber
        }
        
    }
    

    @IBAction func blockunblockButton(sender: AnyObject) {
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
