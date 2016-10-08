//
//  AddProductViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 16/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var quantityLabel: UITextField!
    @IBOutlet weak var offerPriceLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    
    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideMenuShow(slideMenuButton, viewcontroller: self)
        self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        self.showAnimate()
   
        // Do any additional setup after loading the view.
    }

    var getproductCollectionList:ProductCollectionList!{
        didSet{
            bindModelToViews()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindModelToViews(){
        
        
        
    }
    
    
    @IBAction func cancelButtonClicked(sender: AnyObject) {
        
        self.removeAnimate()
        
    }
    
    func formValidation() -> Bool{
        if (quantityLabel.text?.isBlank == true  || offerPriceLabel.text?.isBlank == true || priceLabel.text?.isBlank == true){
            AlertView.alertView("Alert", message: "Field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        return true
    }
    
    @IBAction func saveButtonClicked(sender: AnyObject) {
        self.removeAnimate()
        self.showHud("Loading...")
        let params = [
        "token":token,
        "device_id":"1234",
        "offerPrice[0]":offerPriceLabel.text!,
        "price[0]":priceLabel.text!,
        "quantity[0]":quantityLabel.text!,
        "selected[0]":getproductCollectionList.product_id,
        "status[0]":"0",
        "product_id":getproductCollectionList.product_id,
        "status":"",
        "service_id":getproductCollectionList.service_id
        ]

        ServerManager.sharedInstance().globalProductAdd(params) { (isSuccessful, error, result , result1) in
            if isSuccessful{
                self.hideHud()
                if let _ = result1!["success"] {
                    self.hideHud()
                    
                    AlertView.alertView("Confirmation", message: "Successfully added to the product list", alertTitle: "OK", viewController: self)
                }else{
                    self.hideHud()
                    AlertView.alertView("Alert", message: "Offer price cannot be more than the product price", alertTitle: "OK", viewController: self)
                }
                
            }else{
                self.hideHud()
            }
        }
        
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
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
