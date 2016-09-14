//
//  DetailsOrderTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class DetailsOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var total: UILabel!
    
    @IBOutlet weak var cancelOrderLabel: Button!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var vendorProducts:OrderProductList!{
        didSet{
            bindModelToViews1()
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindModelToViews1(){
        
        if let name = vendorProducts?.name {
            nameLabel.text = name
        }
        
        if let name = vendorProducts?.price {
            price.text = name
        }
        if let name = vendorProducts?.quantity {
            quantity.text = name
        }
        if let name = vendorProducts?.total {
            total.text = name
        }
        
    }
    
    @IBAction func cancelOrderButton(sender: AnyObject) {
    }
    
}
