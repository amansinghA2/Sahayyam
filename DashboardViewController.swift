//
//  DashboardViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 24/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var totalVendorActiveField: UILabel!
    @IBOutlet weak var totalVendorInactiveField: UILabel!
    @IBOutlet weak var totalCustomerActiveField: UILabel!
    @IBOutlet weak var totalCustomerInactiveField: UILabel!
    
    @IBOutlet weak var b2BField: UILabel!
    @IBOutlet weak var b2CField: UILabel!
    
    @IBOutlet weak var vendorRegFeesField: UILabel!
    
    @IBOutlet weak var freeVendorField: UILabel!
    @IBOutlet weak var unpaidVendorField: UILabel!
    
    @IBOutlet weak var servicesDetailField: UILabel!
    @IBOutlet weak var categoriesDetailsField: UILabel!
    @IBOutlet weak var subCategoryField: UILabel!
    @IBOutlet weak var productDetailsField: UILabel!
    var countList = VendorDashboardCountList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showHud("Loading...")
        
        let params = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().chDashboardCountList(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.countList = result!
                self.totalVendorActiveField.text = self.countList.activeVendor
                self.totalVendorInactiveField.text = self.countList.inactiveVendor
                self.totalCustomerActiveField.text = self.countList.activeCustomer
                self.totalCustomerInactiveField.text = self.countList.inactiveCustomer
                self.b2BField.text = self.countList.b2b_fs
                self.b2CField.text = self.countList.b2c_fs
                self.vendorRegFeesField.text = self.countList.total_amonut_fees
                self.freeVendorField.text = self.countList.free_vendor
                self.unpaidVendorField.text = self.countList.unpaid_vendor
                self.servicesDetailField.text = self.countList.service_count
                self.categoriesDetailsField.text = self.countList.category_count
                self.subCategoryField.text = self.countList.subcategory_count
                self.productDetailsField.text = self.countList.product_count
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
    
    @IBAction func totalVendorAction(sender: AnyObject) {
        self.performSegueWithIdentifier("totalVendorSegue", sender: nil)
    }
    
    @IBAction func totalCustomerAction(sender: AnyObject) {
        toastViewForTextfield("Access Denied by policy")
    }
    
    @IBAction func b2BAction(sender: AnyObject) {
        self.performSegueWithIdentifier("chb2bIdentifier", sender: nil)
    }
    
    @IBAction func b2CAction(sender: AnyObject) {
        self.performSegueWithIdentifier("chb2cIdentifier", sender: nil)
    }
    
    @IBAction func vendorRegFeesAction(sender: AnyObject) {
        self.performSegueWithIdentifier("vendorRegIdentifier", sender: nil)
    }
    
    @IBAction func freeUnpaidVendorAction(sender: AnyObject) {
        self.performSegueWithIdentifier("freeUnpaidVendorSegue", sender: nil)
    }
    
    @IBAction func productDetailsAction(sender: AnyObject) {
      self.performSegueWithIdentifier("servicesDetailsIdentifier", sender: nil)
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
