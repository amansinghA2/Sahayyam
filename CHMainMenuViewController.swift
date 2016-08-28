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

//        circularImage(addVendorOutlet)
//        circularImage(vendorsOutlet)
//        circularImage(subscriptionsPaymentOutlet)
//        circularImage(changePasswordOutlet)
//        circularImage(updateProfileOutlet)
//        circularImage(logoutOutlet)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addVendor(sender: AnyObject) {
        
    }
    
    @IBAction func VendorsList(sender: AnyObject) {
        
    }
    
    @IBAction func SubscriptionAction(sender: AnyObject) {
        
    }
    
    @IBAction func ChangePasswordAction(sender: AnyObject) {
        
    }
    
    
    @IBAction func updateProfileAction(sender: AnyObject) {
        
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        
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
