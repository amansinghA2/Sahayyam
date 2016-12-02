//
//  OrderDetailsFotterTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class OrderDetailsFotterTableViewCell: UITableViewCell {


    @IBOutlet weak var expressDeliveryLabel: UILabel!
    @IBOutlet weak var expressDeliveryShowLabel: UILabel!
    @IBOutlet weak var totalShowLabel: UILabel!
    @IBOutlet weak var subTotalShowLabel: UILabel!
    @IBOutlet weak var deliverychargesShowLabel: UILabel!
    @IBOutlet weak var priceShowLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    @IBOutlet weak var deliveryChargesLabel: UILabel!
    @IBOutlet weak var grandTotalShowLabel: UILabel!
    @IBOutlet weak var grandTotalLabel: UILabel!

    
    
    var orderdetailList:CustomerOrderDetails!{
        didSet{
            bindModelToViews()
        }
    }
    
    var vendorOrderList:CustomerOrderDetails!{
        didSet{
            bindModelToViews1()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindModelToViews(){
        if let deliverCharges = orderdetailList?.orderTotals {
            
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
            
            if deliveryCharges.title != "" {
                subTotalLabel.text = subTotal.title
            }
            
            if total.title != "" {
                totalLabel.text = total.title
            }
            
            if offerPrice.title != "" {
                priceShowLabel.text = offerPrice.text + " /-"
            }
            
            if deliveryCharges.title != "" {
                deliverychargesShowLabel.text = deliveryCharges.text + " /-"
            }
            
            if deliveryCharges.title != "" {
                subTotalShowLabel.text = subTotal.text + " /-"
            }
            
            if total.title != "" {
                totalShowLabel.text = total.text + " /-"
            }
    }
        
        if let total = orderdetailList?.extraDeliveryTotals {
                   for i in total {
                    if i.title != "" {
                    expressDeliveryLabel.text = "Express Delivery Cost"
                    expressDeliveryShowLabel.text = i.text + " /-"
                    }
            }
        }
        
        if let total = orderdetailList?.extraOrderCosts {
            for i in total {
                grandTotalLabel.text = "Grand Total"
                grandTotalShowLabel.text = i.text + " /-"
            }
        }
        
        
    }
    
    func bindModelToViews1(){
        if let deliverCharges = vendorOrderList?.orderTotals {
            
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
            
            if deliveryCharges.title != "" {
                subTotalLabel.text = subTotal.title
            }
            
            if total.title != "" {
                totalLabel.text = total.title
            }
            
            if offerPrice.title != "" {
                priceShowLabel.text = offerPrice.text + " /-"
            }
            
            if deliveryCharges.title != "" {
                deliverychargesShowLabel.text = deliveryCharges.text + " /-"
            }
            
            if deliveryCharges.title != "" {
                subTotalShowLabel.text = subTotal.text + " /-"
            }
            
            if total.title != "" {
                totalShowLabel.text = total.text + " /-"
            }
        }
        
//        if let total = vendorOrderList?.extraDeliveryTotals {
//            for i in total {
//                if i.title != "" {
//                    expressDeliveryLabel.text = "Express Delivery Cost"
//                    expressDeliveryShowLabel.text = i.text
//                }
//            }
//        }
        
//        if let total = vendorOrderList?.extraOrderCosts {
//            for i in total {
//                grandTotalLabel.text = "Grand Total"
//                grandTotalShowLabel.text = i.text
//            }
//        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
