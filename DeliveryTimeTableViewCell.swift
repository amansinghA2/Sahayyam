//
//  DeliveryTimeTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 22/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class DeliveryTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var deliveryTimeCell: UILabel!
    
//    var cartList:Products!{
//        didSet{
//            bindModelToViews()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    
    func bindModelToViews() {
      
//        if let deliveryTime = cartList?.checkoutDeliveryTime {
//          
//        }
        
    }
    
}
