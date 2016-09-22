//
//  CartListStaticTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 08/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CartListStaticTableViewCell: UITableViewCell {


    @IBOutlet weak var totalShowLabel: UILabel!
    @IBOutlet weak var subTotalShowLabel: UILabel!
    @IBOutlet weak var deliverychargesShowLabel: UILabel!
    @IBOutlet weak var priceShowLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    @IBOutlet weak var deliveryChargesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var chekoutbuttonoutlet: Button!

    var cartList:Products!{
        didSet{
            bindModelToViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindModelToViews(){
      
        if let deliverCharges = cartList?.customerCartDetails {
        let offerPrice = deliverCharges[0]
        let deliveryCharges = deliverCharges[1]
        let subTotal = deliverCharges[2]
        let total = deliverCharges[3]
        
        if offerPrice.title != "" {
            offerPriceLabel.text = offerPrice.title
        }
        
        if deliveryCharges.title != "" {
            deliveryChargesLabel.text = deliveryCharges.title
        }
        
        if subTotal.title != "" {
            subTotalLabel.text = subTotal.title
        }
        
        if total.title != "" {
            totalLabel.text = total.title
        }
        
        if offerPrice.title != "" {
            priceShowLabel.text = offerPrice.text
        }
        
        if deliveryCharges.title != "" {
            deliverychargesShowLabel.text = deliveryCharges.text
        }
        
        if subTotal.title != "" {
            subTotalShowLabel.text = "Rs. " + subTotal.text + ".00"
        }
        
        if total.title != "" {
            totalShowLabel.text = "Rs. " + total.text + ".00"
        }

        }

//
//            var string1 = String()
//            for i in deliverCharges {
//                if i.title != "" {
//                string1 = string1.stringByAppendingString(i.title + "         " + "Rs. " + i.text   + "          " + i.appliedPrice + "\n")
//
//          }
//        }
//            self.subTotal.text = string1
//       }
    }


    
}
