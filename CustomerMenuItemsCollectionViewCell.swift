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
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: customerproductCost)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0, attributeString.length))
            self.customerproductCost.attributedText = attributeString
        }
        
        if let offerPrice = getProductCollectionLists?.offerPrice {
//            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: offerPrice)
//            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
//            attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0, attributeString.length))
            self.productOfferPrice.text = offerPrice
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
        
        if let customerProductName = getProductCollectionLists1?.prodnName {
            self.customerProductName.text = customerProductName
        }
        
        if let customerproductCost = getProductCollectionLists1?.price {
            self.customerproductCost.text = customerproductCost
        }
        
        if let offerPrice = getProductCollectionLists1?.offerPrice {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: offerPrice)
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0, attributeString.length))
            self.productOfferPrice.attributedText = attributeString
        }
    }

    @IBAction func addToWishList(sender: AnyObject) {
        
    }
 
    @IBAction func addToCart(sender: AnyObject) {
        
    }

    

}
