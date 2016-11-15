

import UIKit

class MyProductDetailsTableViewCell: UICollectionViewCell {
    


    @IBOutlet weak var customerProductImage: UIImageView!
    @IBOutlet weak var customerProductName: UILabel!
    @IBOutlet weak var customerproductCost: UILabel!
    @IBOutlet weak var productOfferPrice: UILabel!
    var quanitityCount = Int()
    var str = ""

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
    
    
    func bindModeltoViews1(){
        if let customerProductImage1 = getProductCollectionLists1?.image1 {
            if customerProductImage1 != "" {
                self.customerProductImage.imageFromUrl(customerProductImage1)
            } else {
                self.customerProductImage.image = UIImage(named: "v_no_image")
            }
        }
        
        if let customerProductName = getProductCollectionLists1?.vendorName {
            self.customerProductName.text = customerProductName
        }
        
//        if let customerproductCost = getProductCollectionLists1?.price {
//            self.customerproductCost.text = customerproductCost
//        }
        
        if let customerproductCost = getProductCollectionLists1?.price  {
            if getProductCollectionLists1?.offerPrice != "0"  && getProductCollectionLists1?.offerPrice != "0.00" && getProductCollectionLists1?.offerPrice != "" {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Rs. " + customerproductCost)
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0, attributeString.length))
                self.customerproductCost.attributedText = attributeString
            }else{
                self.customerproductCost.text = "Rs. " + customerproductCost
            }
        }
        
        if let offerPrice = getProductCollectionLists1?.offerPrice {
            if offerPrice != "0"  && offerPrice != "0.00" && offerPrice != ""{
                self.productOfferPrice.text = "Rs. " + offerPrice
            }else{
                self.productOfferPrice.text = ""
            }
        }
        
//        if let offerPrice = getProductCollectionLists1?.offerPrice {
//            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: offerPrice)
//            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
//            attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0, attributeString.length))
//            self.productOfferPrice.attributedText = attributeString
//        }
    }
    
    @IBAction func addToWishList(sender: AnyObject) {
        
    }
    
    @IBAction func addToCart(sender: AnyObject) {
        
    }
    
  
}

