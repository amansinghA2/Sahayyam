//
//  CustomerMenuItemsCollectionViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerMenuItemsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var addToWishlist: UIButton!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var customerProductImage: UIImageView!
    @IBOutlet weak var customerProductName: UILabel!
    @IBOutlet weak var customerproductCost: UILabel!
    var quanitityCount = Int()
    var str = ""
    
    @IBOutlet weak var wishListImage: UIButton!
    
    var getProductCollectionLists:ProductCollectionList!{
        didSet{
            bindModeltoViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        customerProductImage.image = nil
    }
    
    func bindModeltoViews(){
        if let customerProductImage1 = getProductCollectionLists?.image1 {
            if customerProductImage1 != "" {
             self.customerProductImage.imageFromUrl(image_base_url + customerProductImage1)
            } else {
              self.customerProductImage.image = UIImage(named: "v_no_image")
            }
        }
        
        if let customerProductName = getProductCollectionLists?.prodnName {
            self.customerProductName.text = customerProductName
        }
        
        if let customerproductCost = getProductCollectionLists?.price {
            self.customerproductCost.text = customerproductCost
        }

    }

    
 
    @IBAction func addToWishList(sender: AnyObject) {
        
    }
 
    @IBAction func addToCart(sender: AnyObject) {
        
    }

    

}
