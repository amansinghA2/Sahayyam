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
    @IBOutlet weak var productOfferPrice: UILabel!
    var quanitityCount = Int()
    var str = ""
    
    @IBOutlet weak var wishListImage: UIButton!
    
    var getProductCollectionLists:ProductCollectionList!{
        didSet{
            bindModeltoViews()
        }
    }
    
    var getProductCollectionLists1:ProductCollectionList!{
        didSet{
            bindModeltoViews1()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad)
        {
//         customerProductImage.frame = CGRectMake(self.frame.width - 80, 10, self.frame.width / 2, self.frame.height / 2)
        }else{
           
        customerproductCost.font = customerProductName.font.fontWithSize(12)
        productOfferPrice.font = customerProductName.font.fontWithSize(12)
          customerProductName.font = customerProductName.font.fontWithSize(12)
        }
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
        
        if let customerProductName = getProductCollectionLists?.name {
            self.customerProductName.text = customerProductName
        }
        
        if let customerproductCost = getProductCollectionLists?.price  {
            
            if getProductCollectionLists?.offerPrice != "0"  && getProductCollectionLists?.offerPrice != "0.00" && getProductCollectionLists?.offerPrice != "" {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Rs. " + customerproductCost)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0, attributeString.length))
            self.customerproductCost.attributedText = attributeString
            }else{
            self.customerproductCost.text = "Rs. " + customerproductCost
            }
     }
        
        if let offerPrice = getProductCollectionLists?.offerPrice {
            if offerPrice != "0"  && offerPrice != "0.00" && offerPrice != ""{
                self.productOfferPrice.text = "Rs. " + offerPrice
            }else{
                self.productOfferPrice.text = ""
            }
        }
    }
    
    func bindModeltoViews1(){
        if let customerProductImage1 = getProductCollectionLists1?.image1 {
            if customerProductImage1 != "" {
                self.customerProductImage.imageFromUrl(customerProductImage1)
            } else {
                self.customerProductImage.image = UIImage(named: "v_no_image")
            }
        }
        
        if let customerProductName = getProductCollectionLists1?.name {
            self.customerProductName.text = customerProductName
        }
        
        if let customerproductCost = getProductCollectionLists1?.price {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: customerproductCost)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0, attributeString.length))
            self.customerproductCost.attributedText = attributeString

        }
        
        if let offerPrice = getProductCollectionLists1?.offerPrice {
            if offerPrice != "0"  || offerPrice != "0.00" {
            self.productOfferPrice.text = offerPrice
          }
        }
    }

    @IBAction func addToWishList(sender: AnyObject) {
        
    }
 
    @IBAction func addToCart(sender: AnyObject) {
        
    }

    

}
