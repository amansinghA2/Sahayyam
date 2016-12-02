//
//  LocalProductStatusViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 22/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class LocalProductStatusViewController: UIViewController {

    
    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    
    @IBOutlet weak var approvedProductLabel: UILabel!
    
    @IBOutlet weak var pendingProductLabel: UILabel!
    
    @IBOutlet weak var rejectedProductLabel: UILabel!
    var productCountDetails = ProductApprovalStatus()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideMenuShow(slideMenuButton, viewcontroller: self)
        revealTouch(self)
        self.showHud("Loading...")
        
        let params = [
        "token":token,
        "device_id":"1234",
        ]
        
        ServerManager.sharedInstance().vendorProductCount(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.productCountDetails = result!
                self.approvedProductLabel.text = String(self.productCountDetails.Product_Approved_count)
                self.pendingProductLabel.text = String(self.productCountDetails.Product_Pending_count)
                self.rejectedProductLabel.text = String(self.productCountDetails.Product_Rejected_count)
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getDetails(sender: AnyObject) {
       
       self.performSegueWithIdentifier("localProductDetailSegue", sender: nil)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "localProductDetailSegue" {
            let vc = segue.destinationViewController as! LocalProductsDetailViewController
        }
        
    }
 

}
