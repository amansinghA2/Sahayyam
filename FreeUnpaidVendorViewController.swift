//
//  FreeUnpaidVendorViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 25/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class FreeUnpaidVendorViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var freeUnpaidListTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // setUp()
        
        let nib2 = UINib(nibName: "VendorsFreeTableViewCell", bundle: nil)
        self.freeUnpaidListTableView.registerNib(nib2, forCellReuseIdentifier: "freeVendorsIdentifier")
        
    }
    
//    func setUp() {
//        
//        let params = [
//            "token":token,
//            "device_id":"1234"
//        ]
//        
//        ServerManager.sharedInstance().chVendorListForSbbscription(params) { (isSuccessful, error, result, dictResult) in
//            if isSuccessful {
//                self.vendorSubsLIsts = result!
//                self.hideHud()
//            }else{
//                self.hideHud()
//            }
//        }
    
        //        let params = [
        //        "token":token,
        //        "device_id":"1234",
        //        "amount":"1234",
        //        "seller_id":"1234",
        //        "customer_no":"1234",
        //        "seller_group_id":"1234",
        //        "totalmonth":"1234",
        //        "mTotalMonthDay":"1234",
        //        "current_date":"1234",
        //        "expiry_date":"1234",
        //        "remainingdays":"1234",
        //        "order_id":"1234",
        //        "sub_type":"1234",
        //        "product_id":"1234",
        //        "subscriptin_dur":"1234",
        //        "fess":"1234"
        //        ]
        //
        //        ServerManager.sharedInstance().paidSubscriptionInfo(params) { (isSuccessful, error, result, dictResult) in
        //            if isSuccessful {
        //
        //            }
        //        }
        
    //}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 4
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if segmentControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("freeVendorsIdentifier") as! VendorsFreeTableViewCell
            
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("freeVendorsIdentifier") as! VendorsFreeTableViewCell
            
            
            
            return cell
        }
        
       
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    @IBAction func segmentControlAction(sender: AnyObject) {
    }
}
