//
//  CartListTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 08/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CartListTableViewCell: UITableViewCell {

    @IBOutlet weak var quantitytextField: UITextField!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UITextField!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var removeButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImage.layer.borderWidth = 1.0
        productImage.layer.cornerRadius = 5
        productImage.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).CGColor
        
    }

    var cartList:Products!{
        didSet{
          bindModelToViews()
        }
    }
    
    func bindModelToViews(){
        
        if let productName = cartList?.name {
            self.productName.text! = productName
            print(self.productName.text)
        }
        
        if let productPrice = cartList?.price {
            self.productPrice.text = productPrice
        }
        
        if let productQuantity = cartList?.cartQuantity {
            print(productQuantity)
           self.productQuantity.text = String(productQuantity)
        }
        
        if cartList?.image != "" {
            if let customerProductImage1 = cartList?.image{
                self.productImage.imageFromUrl(customerProductImage1)
            }
        }else{
            self.productImage.image = UIImage(named: "v_no_image")
        }

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func removeFromCartAction(sender: AnyObject) {
        
     
    }
}
