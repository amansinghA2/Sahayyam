//
//  CustomerMenuDescriptionViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 01/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerMenuDescriptionViewController: UIViewController {

    @IBOutlet weak var productDetailsImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productSellingPrice: UILabel!

    @IBOutlet weak var productStocks: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!

    var getProductList = ProductCollectionList()
    var getDetailsProducts = ProductDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tokenCheck()
        
        print(getProductList)
        self.changeNavigationBarColor()
        let params:[String : AnyObject] = [
        "token":token,
        "device_id":"1234",
        "product_id":getProductList.product_id,
        "width":"",
        "height":"",
        ]
  
        print(params)
        
        ServerManager.sharedInstance().customerProductDetails(params) { (isSuccessful, error, result) in
            
            if isSuccessful{
            
            if let details = result {
            self.getDetailsProducts = details
              }
            
                if self.getProductList.image1 != "" {
                if let image = self.getProductList.image1 as? String{
                    self.productDetailsImage.imageFromUrl(image)
                }
                }else{
                    self.productDetailsImage.image = UIImage(named: "v_no_image")
                }
                
                if let name = self.getDetailsProducts.name as? String{
                    self.productName.text = name
                }

                
                if let price = self.getDetailsProducts.price as? String{
                    self.productSellingPrice.text = price
                }

                if let stock = self.getDetailsProducts.stock as? String{
                   self.productStocks.text = stock
                }
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SegmentButtonAction(sender: AnyObject) {
        
       segmentSelected()
  
        
    }

    func segmentSelected() {
        
        switch self.segmentControl.selectedSegmentIndex {
        case 0:

            let params:[String:AnyObject]? = [
                "product_id":self.getProductList.product_id,
                "device_id":"1234",
                "token":token,
                ]

            ServerManager.sharedInstance().customerAddtoWishlist(params, completionClosure: { (isSuccessful, error, result) in

            })

            AlertView.alertView("Alert", message: "Product is added to Wishlist", alertTitle: "OK", viewController: self)

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

                            print(params)

                            ServerManager.sharedInstance().customerAddToCart(params) { (isSuccessful, error, result) in

                            }
                        }else{
                            self.toastViewForTextfield("Not a valid number to enter")
                        }
                    }else{
                        self.toastViewForTextfield("Cannot be left blank")
                    }
                }
            }

            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
            alertController.addTextFieldWithConfigurationHandler { (textField) in
                textField.placeholder = "Number Of Items"
            }

            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        default:
            let params:[String:AnyObject]? = [
                "product_id":self.getProductList.product_id,
                "device_id":"1234",
                "token":token,
                ]

            ServerManager.sharedInstance().customerAddtoWishlist(params, completionClosure: { (isSuccessful, error, result) in

            })
            
            AlertView.alertView("Alert", message: "Product is added to Wishlist", alertTitle: "OK", viewController: self)
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
