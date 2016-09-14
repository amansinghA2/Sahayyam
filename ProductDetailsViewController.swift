//
//  CustomerMenuDescriptionViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 01/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var productDetailsImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var productSellingPrice: UILabel!
    
    @IBOutlet weak var productStocks: UILabel!
    
    @IBOutlet weak var detailsDescription: UILabel!
    
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
                    if result != nil {
                        self.getDetailsProducts = result!
                        print(self.getDetailsProducts)
                    }
                }else{
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
        
        if let price = self.getDetailsProducts.price as? String{
            self.productSellingPrice.text = "Selling Price : " + price
        }
        
        if let stock = self.getDetailsProducts.stock as? String{
            self.productStocks.text = stock + " units in stock"
        }
        
        if let detailsDescription = self.getDetailsProducts.productDescription as? String{
            self.detailsDescription.text = "Details: " + detailsDescription
        }
        
    }
    
    @IBAction func editProductAction(sender: AnyObject) {
        
        
        
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
