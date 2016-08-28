//
//  WishLIstTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 05/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class WishLIstTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productStock: UILabel!
    
    @IBOutlet weak var wishlistImage: UIImageView!
//    @IBOutlet weak var productImageLabel: UIImageView!
    
    @IBOutlet weak var addToCartOutlet: UIButton!
    
    @IBOutlet weak var removeButtonOutlet: UIButton!
    
    var wishList:WishlistProductList!{
        didSet{
            bindModelToViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func bindModelToViews(){
      
        if let productName = wishList?.name {
            self.productName.text! = productName
            print(self.productName.text)
        }
        
        if let productPrice = wishList?.price {
            self.productPrice.text = productPrice
        }
        
        if let productStock = wishList?.stock1 {
            self.productStock.text =  "Stock remaining" + String(productStock)
        }
        
//        if let productImageLabel = wishList?.cartQuantity {
//            print(productQuantity)
//            self.productQuantity.text = String(productQuantity)
//        }

        if let customerProductImage1 = wishList?.thumb {
            self.wishlistImage.imageFromUrl(customerProductImage1)
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func addToCart(sender: AnyObject) {
    }
    
    @IBAction func removeFromWishlist(sender: AnyObject) {

    }
    
    
}
