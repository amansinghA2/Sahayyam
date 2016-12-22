//
//  CHMainMenuViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 02/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CHMainMenuViewController: UIViewController {

    @IBOutlet weak var addVendorOutlet: UIImageView!
    
    @IBOutlet weak var vendorsOutlet: UIImageView!
    
    @IBOutlet weak var subscriptionsPaymentOutlet: UIImageView!
    
    @IBOutlet weak var changePasswordOutlet: UIImageView!
    
    @IBOutlet weak var updateProfileOutlet: UIImageView!
    
    @IBOutlet weak var logoutOutlet: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addVendor(sender: AnyObject) {
       self.performSegueWithIdentifier("addVendorSegue", sender: nil) 
    }
    
    @IBAction func VendorsList(sender: AnyObject) {
       self.performSegueWithIdentifier("vendorsCHSegue", sender: nil)
    }
    
    @IBAction func SubscriptionAction(sender: AnyObject) {
       self.performSegueWithIdentifier("goToSubsPayment", sender: nil)
    }
    
    @IBAction func ChangePasswordAction(sender: AnyObject) {
       self.performSegueWithIdentifier("changePasswordSegue", sender: nil)
    }
    
    @IBAction func updateProfileAction(sender: AnyObject) {
       self.performSegueWithIdentifier("chprofileUpdateSegue", sender: nil)
    }
    
    @IBAction func dashboardAction(sender: AnyObject) {
        self.performSegueWithIdentifier("dashBoardSegue", sender: nil)
    }
    
    @IBAction func aboutUsAction(sender: AnyObject) {
        self.performSegueWithIdentifier("aboutUsSegue", sender: nil)
    }
    
    @IBAction func addCustomerAction(sender: AnyObject) {
        
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().chAddCustomerGetdataUrl(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                if let dict = dictResult!["cityheadVendor"] {
                    if dict as! NSObject == 0  {
                        AlertView.alertView("Alert", message: "No vendors", alertTitle: "OK", viewController: self)
                        self.hideHud()
                    }else{
                        self.performSegueWithIdentifier("addCustomerSegue", sender: nil)
                        self.hideHud()
                    }
  
                }
            }else{
                self.hideHud()
            }
            
            // Do any additional setup after loading the view.
        }

        
    }
    
    @IBAction func switchProfileAction(sender: AnyObject) {
        self.performSegueWithIdentifier("switchSegueIdentifier", sender: nil)
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        alertControllerToLogout()
    }
    
    func alertControllerToLogout() {
        
        let alertController = UIAlertController(title: "Alert", message: "Do You wish to logout", preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            let params = [
                "token":token,
                "device_id":"1234"
            ]
            
            ServerManager.sharedInstance().loginLogout(params) { (isSuccessful, error, result) in
                if isSuccessful {
                    self.hideHud()
                    self.performSegueWithIdentifier("loginSegue", sender: nil)
                }
            }
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        if segue.identifier == "chprofileUpdateSegue" {
            let vc = segue.destinationViewController as! CityHeadProfileViewController
            vc.isLogin = "customerDropDown"
        }else if segue.identifier == "aboutUsSegue" {
            let vc = segue.destinationViewController as! AboutUsViewController
            vc.fromCityHeadApp = "fromCityHead"
        }
    }
    

}
