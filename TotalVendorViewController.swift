//
//  TotalVendorViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 25/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class TotalVendorViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var segmentControl: UISegmentedControl!

    @IBOutlet weak var totalVendorListTableView: UITableView!
    
    var paidUnapidList = [PaidUnpaidVendor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp("1", filterName: "", searchtext: "")
        let nib1 = UINib(nibName: "TotalVendorListTableViewCell", bundle: nil)
        self.totalVendorListTableView.registerNib(nib1, forCellReuseIdentifier: "totalVendorListIdentifier")
    }
    
    func setUp(status:String , filterName :String , searchtext:String) {
        
        self.showHud("Loading...")
        
        let params = [
            "token":token,
            "device_id":"1234",
            "filter_name":filterName,
            "searchtext":searchtext,
            "status":status
        ]
        
        ServerManager.sharedInstance().chTotalVendorList(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.paidUnapidList = result!
                self.totalVendorListTableView.delegate = self
                self.totalVendorListTableView.dataSource = self
                self.totalVendorListTableView.reloadData()
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paidUnapidList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        if segmentControl.selectedSegmentIndex == 0 {
//            let cell = tableView.dequeueReusableCellWithIdentifier("totalVendorListIdentifier") as! TotalVendorListTableViewCell
//            cell.paidvendorList = self.paidUnapidList[indexPath.row]
//            return cell
//        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("totalVendorListIdentifier") as! TotalVendorListTableViewCell
           cell.paidvendorList = self.paidUnapidList[indexPath.row]
           cell.addSubscriptionButton.addTarget(self, action: #selector(TotalVendorViewController.subscriptionButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
           cell.changeMobileNoButton.addTarget(self, action: #selector(TotalVendorViewController.mobileNoChangeButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
            return cell
//        }
    }
    
    func mobileNoChangeButtonClicked(sender:UIButton){
        self.performSegueWithIdentifier("changeMobileSegue", sender: nil)
    }
    
    func subscriptionButtonClicked(sender:UIButton) {
        self.performSegueWithIdentifier("addSubsIdentifierSegue", sender: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func segmentControlAction(sender: AnyObject) {
        
                switch segmentControl.selectedSegmentIndex {
                case 0:
                   setUp("1", filterName: "", searchtext: "")
                case 1:
                   setUp("0", filterName: "", searchtext: "")
                default:
                  print("")
                }
        
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
