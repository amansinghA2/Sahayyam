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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func totalVendorAction(sender: AnyObject) {
        
        
        
    }
    
    
    @IBAction func totalCustomerAction(sender: AnyObject) {
    }
    
    
    @IBAction func b2BAction(sender: AnyObject) {
    }
    
    @IBAction func b2CAction(sender: AnyObject) {
    }
    
    @IBAction func vendorRegFeesAction(sender: AnyObject) {
    }

    @IBAction func freeUnpaidVendorAction(sender: AnyObject) {
    }
    
    @IBAction func productDetailsAction(sender: AnyObject) {
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
