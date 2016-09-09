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
//                string1 = string1.stringByAppendingString(i.title + "         " + i.text + "                                      " + i.appliedPrice + "\n")
//                
//            }
//            totalPrice.text = string1
//        }
        
        var string1 = String()
        var string2 = String()
        var string3 = String()
        
        if let total = orderdetailList?.orderTotals {
            
            for i in total {
                if i.title != "" {
                string1 = string1.stringByAppendingString(i.title + "         " + i.text + "          " + i.appliedPrice + "\n")
            }
            }
        }
        
        if let total = orderdetailList?.extraDeliveryTotals {
            
            for i in total {
                 if i.title != "" {
                string2 = string2.stringByAppendingString(i.title + "         " + i.text + "          " + i.appliedPrice + "\n")
                
            }
            }
            
        }
        
            if let total1 = orderdetailList?.extraOrderCosts{
                for i in total1 {
                    if i.title != "" {
                  string3 = string3.stringByAppendingString("Grand Total" + "            " + i.text + "          " + i.appliedPrice )
                }
              }
            }
        
        
//        stringByTrimmingCharactersInSet(
//            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        grandTotalLabel.text = string1 + string2 + string3
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
