//
//  CustomerBestDealsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 05/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerBestDealsViewController: UIViewController {

    @IBOutlet weak var viewContraint: NSLayoutConstraint!
    @IBOutlet weak var bestDealsAction: Button!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var promoDescriptionLabel: UILabel!
    
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var promotionLists = [DisplayPromotionDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tokenCheck()
        self.showHud("Loading...")
        
        let params = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().customerPromotion(params) { (isSuccessful, error, result) in
            if isSuccessful{
                self.hideHud()
                self.promotionLists = result!
                if self.promotionLists.count != 0 {
                    self.bestDealsAction.setTitle("SHOP NOW", forState: UIControlState.Normal)
                    self.viewContraint.constant = 108
                 self.bindModelToViews()
                }else{
                    self.viewContraint.constant = 0
                    self.nameLabel.text = "No Offers"
                  self.bestDealsAction.setTitle("CHECK FOR BEST DEALS", forState: UIControlState.Normal)
                }
            }else{
                 AlertView.alertViewToGoToLogin("OK", message: "Server Error", alertTitle: "OK", viewController: self)
            }
        }
        
        setBackButtonForNavigation()
        changeNavigationBarColor()
    // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func bindModelToViews() {
        
        for promotionLIst in promotionLists {
            
            if let name = promotionLIst.name as? String{
              nameLabel.text = name
            }
            
            if let name = promotionLIst.promotionDescription as? String{
                promoDescriptionLabel.text = name
            }
            
            if let name = promotionLIst.price as? String{
                
                let str = CustomClass.roundOfDecimal(name)
                if let name = promotionLIst.discountPrice as? String{
                    if promotionLIst.discountType == "P"{
                        priceLabel.text = "On Price: INR " + str  + "    " + "get " + name + " % off"
                    }else{
                        priceLabel.text = "On Price: INR " + str  + "    " + "SAVE Rs. : " + name
                    }
                }
                
            }
            
           
            
        }
        
    }

    @IBAction func bestDealsAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
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
