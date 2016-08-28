//
//  OrderDetailsFotterTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class OrderDetailsFotterTableViewCell: UITableViewCell {

    @IBOutlet weak var grandTotalLabel: UILabel!

    var orderdetailList:CustomerOrderDetails!{
        didSet{
            bindModelToViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        grandTotalLabel.sizeToFit()
        // Initialization code
    }

    func bindModelToViews(){
        
//        if let deliverCharges = cartList?.customerCartDetails {
//            
//            self.total = deliverCharges[3]
//            self.expressDeliveryString = self.total.text
//            
//            var string1 = String()
//            for i in deliverCharges {
//                string1 = string1.stringByAppendingString(i.title + "         " + i.text + "          " + i.appliedPrice + "\n")
//                
//            }
//            totalPrice.text = string1
//        }
        
        if let total = orderdetailList?.orderTotals {
            var string1 = String()
            for i in total {
                string1 = string1.stringByAppendingString(i.title + "         " + i.text + "          " + i.appliedPrice + "\n")
                
            }
            grandTotalLabel.text = string1.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
