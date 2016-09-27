//
//  VendorCityHeadViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorCityHeadViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var vendorSubsListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        let nib1 = UINib(nibName: "AllVendorsTableViewCell", bundle: nil)
        self.vendorSubsListTableView.registerNib(nib1, forCellReuseIdentifier: "allVendorsIdentifier")
        
        let nib2 = UINib(nibName: "VendorsFreeTableViewCell", bundle: nil)
        self.vendorSubsListTableView.registerNib(nib2, forCellReuseIdentifier: "freeVendorsIdentifier")
        
    }

    func setUp() {
        
        let params = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().chVendorListForSbbscription(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                
            }
        }
        
        
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("")
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func segmentControlAction(sender: AnyObject) {
        
//        switch segmentControl.selectedSegmentIndex {
//        case 0:
//           
//        default:
//            
//        }
        
    }
    
    func vendorDetails() {
        
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
