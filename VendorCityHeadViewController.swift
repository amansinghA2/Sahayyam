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
    var vendorSubsLIsts = [CHVendorSubsList]()
    var freeUnpaidVendorList = FreeUnpaidVendorList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib1 = UINib(nibName: "AllVendorsTableViewCell", bundle: nil)
        self.vendorSubsListTableView.registerNib(nib1, forCellReuseIdentifier: "allVendorsIdentifier")
        
        let nib2 = UINib(nibName: "VendorsFreeTableViewCell", bundle: nil)
        self.vendorSubsListTableView.registerNib(nib2, forCellReuseIdentifier: "freeVendorsIdentifier")
        
        setUpVendorList()
       
    }
    
    func setUpFreeVendorsList() {
        
        self.showHud("Loading...")
        
        let params = [
        "token":token,
        "device_id":"1234",
        "filter_name":"",
        ]
        
        ServerManager.sharedInstance().chVendorListFree(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.freeUnpaidVendorList = result!
               // self.vendorSubsLIsts = result!
                self.vendorSubsListTableView.delegate = self
                self.vendorSubsListTableView.dataSource = self
                self.vendorSubsListTableView.reloadData()
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
        
    }
    
    func setUpVendorList() {
        self.showHud("Loading...")
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().chVendorListForSbbscription(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.vendorSubsLIsts = result!
                self.vendorSubsListTableView.delegate = self
                self.vendorSubsListTableView.dataSource = self
                self.vendorSubsListTableView.reloadData()
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
        if segmentControl.selectedSegmentIndex == 0 {
            return self.vendorSubsLIsts.count
        }else if segmentControl.selectedSegmentIndex == 1{
            return self.freeUnpaidVendorList.freevendorList.count
        }else{
            return self.freeUnpaidVendorList.unpaidVendorList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if segmentControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("allVendorsIdentifier") as! AllVendorsTableViewCell
            if vendorSubsLIsts.count > 0 {
                cell.vendoSubsLIst = self.vendorSubsLIsts[indexPath.row]
            }else{
                self.toastViewForTextfield("No Vendors")
            }
            
            return cell
        }else if segmentControl.selectedSegmentIndex == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("freeVendorsIdentifier") as! VendorsFreeTableViewCell
           if self.freeUnpaidVendorList.freevendorList.count > 0 {
                cell.freevendorList = self.freeUnpaidVendorList.freevendorList[indexPath.row]
            }else{
                self.toastViewForTextfield("No Vendors")            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("freeVendorsIdentifier") as! VendorsFreeTableViewCell
            if self.freeUnpaidVendorList.unpaidVendorList.count > 0 {
                cell.unpaidVendorList = self.freeUnpaidVendorList.unpaidVendorList[indexPath.row]
            }else{
                self.toastViewForTextfield("No Vendors")
            }
            
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @IBAction func segmentControlAction(sender: AnyObject) {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            setUpVendorList()
        case 1:
            setUpFreeVendorsList()
        default:
            setUpFreeVendorsList()
        }
        
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
