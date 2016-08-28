//
//  CartListStaticTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 08/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CartListStaticTableViewCell: UITableViewCell {

    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var deliveryCost: UILabel!
    @IBOutlet weak var totalcartPrice: UILabel!
    
    @IBOutlet weak var chekoutbuttonoutlet: Button!

    var cartList:Products!{
        didSet{
            bindModelToViews()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        subTotal.sizeToFit()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindModelToViews(){
        
        if let deliverCharges = cartList?.customerCartDetails {
            var string1 = String()
            for i in deliverCharges {
                print(i)

                string1 = string1.stringByAppendingString(i.title + "         " + i.text + "          " + i.appliedPrice + "\n")

          }
            self.subTotal.text = string1
       }
}


    
}
