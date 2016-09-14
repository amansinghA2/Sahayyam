//
//  OrderDetailsTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    var orderProducts:OrderProductList!{
        didSet{
            bindModelToViews()
        }
    }
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindModelToViews(){
        
        if let name = orderProducts?.name {
            nameLabel.text = name 
        }

        if let name = orderProducts?.price {
            priceLabel.text = name
        }
        if let name = orderProducts?.quantity {
            quantityLabel.text = name
        }
        if let name = orderProducts?.total {
            totalLabel.text = name
        }
        
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
