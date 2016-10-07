//
//  CustomerMenuDescriptionViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 01/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerMenuDescriptionViewController: UIViewController {
    @IBOutlet weak var offerPriceConstraint: NSLayoutConstraint!

    @IBOutlet weak var productDetailsImage: UIImageView!
    
    @IBOutlet weak var staticSellingpriceLabel: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productOfferPrice: UILabel!
    @IBOutlet weak var productSellingPrice: UILabel!

    @IBOutlet weak var productStocks: UILabel!
    
    @IBOutlet weak var detailsDescription: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!

    var getProductList:ProductCollectionList!
    
    var getDetailsProducts:ProductDetails!{
        didSet{
            bindModelToViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenCheck()
        setBackButtonForNavigation()
        self.changeNavigationBarColor()
        
        self.showHud("Loading...")
        
        let params:[String : AnyObject] = [
        "token":token,
        "device_id":"1234",
        "product_id":getProductList.product_id,
        "width":"200",
        "height":"200",
        ]

        print(params)
        if Reachability.isConnectedToNetwork(){
            ServerManager.sharedInstance().customerProductDetails(params) { (isSuccessful, error, result) in
            if isSuccessful{
                self.hideHud()
                self.staticSellingpriceLabel.text = "Selling Price: "
                if result != nil {
                self.getDetailsProducts = result!
                print(self.getDetailsProducts)
             }
            }else{
                self.hideHud()
                AlertView.alertViewWithPopup("Alert", message: error!, alertTitle: "OK", viewController: self)
                self.hideHud()
            }
          }
        }
        else{
            self.hideHud()
            AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
        }
        
    }

    override func viewWillAppear(animated: Bool) {
        
 
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func bindModelToViews() {
    
        if let customerProductImage1 = self.getDetailsProducts.detailsImage as? String{
            if customerProductImage1 != "" {
                self.productDetailsImage.imageFromUrl(image_base_url + customerProductImage1)
            } else {
                self.productDetailsImage.image = UIImage(named: "v_no_image")
            }
        }
        
        if let name = self.getDetailsProducts.name as? String{
            self.productName.text = name
        }
        
        
        if let customerproduct = self.getDetailsProducts.price  as? String{
            if getDetailsProducts?.offerPrice != "0"  && getDetailsProducts?.offerPrice != "0.00" && getDetailsProducts?.offerPrice != "" {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "Rs. " + customerproduct)
                attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, attributeString.length))
                attributeString.addAttribute(NSStrikethroughColorAttributeName, value: UIColor.lightGrayColor(), range: NSMakeRange(0, attributeString.length))
                self.productSellingPrice.attributedText =  attributeString
                self.offerPriceConstraint.constant = 21
            }else{
                self.offerPriceConstraint.constant = 0
                self.productSellingPrice.text = "Rs. " + customerproduct
            }
        }
        
        if let offerPrice = getDetailsProducts?.offerPrice {
            if offerPrice != "0"  && offerPrice != "0.00" {
                self.offerPriceConstraint.constant = 21
                self.productOfferPrice.text = "Offer Price : " + "Rs. " + offerPrice
                
            }else{
                self.offerPriceConstraint.constant = 0
                self.productOfferPrice.text = ""
            }
        }
        
//        if let price = self.getDetailsProducts.price as? String{
//            if getDetailsProducts?.offerPrice != "0"  && getDetailsProducts?.offerPrice != "0.00" && getDetailsProducts?.offerPrice != ""  {
//                self.productSellingPrice.text = "Selling Price : " + self.getDetailsProducts.offerPrice
//            }else{
//             self.productSellingPrice.text = "Selling Price : " + price
//            }
//        }
        
        if let stock = self.getDetailsProducts.stock as? String{
            self.productStocks.text = stock + " units in stock"
        }
        
        if let detailsDescription = self.getDetailsProducts.productDescription as? String{
            self.detailsDescription.text = "Details: " + detailsDescription
        }
        
    }
    
    @IBAction func SegmentButtonAction(sender: UISegmentedControl) {
        segmentSelected()
        
        if (sender.selectedSegmentIndex == self.segmentControl.selectedSegmentIndex) {
            sender.selectedSegmentIndex =  UISegmentedControlNoSegment;
            self.segmentControl.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
        else {
            self.segmentControl.selectedSegmentIndex = sender.selectedSegmentIndex;
        }
      
    }

    func segmentSelected() {
        
           if Reachability.isConnectedToNetwork(){
        switch self.segmentControl.selectedSegmentIndex {
        case 0:
            let params:[String:AnyObject]? = [
                "product_id":self.getProductList.product_id,
                "device_id":"1234",
                "token":token,
                ]
            ServerManager.sharedInstance().customerAddtoWishlist(params, completionClosure: { (isSuccessful, error, result) in
                
                if isSuccessful {
                    if let isSuccess = result!["success"] as? Bool{
                        if let total = result!["total"] as? Bool {
                            if isSuccess == true && total == false{
                                self.toastViewForTextfield("Product successfully added to wishlist")
                            }
                        }
                    }
                    
                    if let isSuccess1 = result!["info"] as? Bool{
                        if let total = result!["total"] as? Bool {
                            if isSuccess1 == false && total == true{
                                self.toastViewForTextfield("Product already added to wishlist")
                            }
                        }
                    }
                    
                    if let isSuccess1 = result!["success"] as? Bool{
                        if let total = result!["total"] as? Bool {
                            if isSuccess1 == true && total == true{
                                self.toastViewForTextfield("Product already added to wishlist")
                            }
                        }
                    }
                    
                }else{
                    AlertView.alertViewWithPopup("Alert", message: error!, alertTitle: "OK", viewController: self)
                    self.hideHud()
                }
                
            })
        case 1:
            let alertController = UIAlertController(title: "Items", message: "Quantity to be added to cart", preferredStyle: .Alert)
            let confirmAction = UIAlertAction(title: "OK", style: .Default) { (_) in
                if let field = alertController.textFields![0] as? UITextField {
                    if field.text?.isBlank == false{
                        if field.text?.isPhoneNumber == true {
                            let params:[String:AnyObject]? = [
                                "product_id":self.getProductList.product_id,
                                "device_id":"1234",
                                "token":token,
                                "quantity":Int(field.text!)!
                            ]
                            
                            ServerManager.sharedInstance().customerAddToCart(params) { (isSuccessful, error, result) in
                                
                                if isSuccessful{
                                    
                                }else{
                                    AlertView.alertViewWithPopup("Alert", message: error!, alertTitle: "OK", viewController: self)
                                    self.hideHud()
                                }
                                
                            }
                        }else{
                            self.toastViewForTextfield("Not a valid number to enter")
                        }
                    }else{
                        self.toastViewForTextfield("Cannot be left blank")
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in
              self.segmentControl.selectedSegmentIndex = UISegmentedControlNoSegment
            }
            
            alertController.addTextFieldWithConfigurationHandler { (textField) in
                textField.placeholder = "Number Of Items"
                textField.text = "1"
                textField.keyboardType = .PhonePad
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        default:
            print("Nothing")
    }
    }
    else{
    self.hideHud()
    AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
      }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
