//
//  FreeUnpaidVendorViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 25/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class FreeUnpaidVendorViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var freeUnpaidListTableView: UITableView!
    var unpaidList = [UnpaidVendorList]()
    var freeList = [FreeVendorList]()
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib2 = UINib(nibName: "VendorsFreeTableViewCell", bundle: nil)
        self.freeUnpaidListTableView.registerNib(nib2, forCellReuseIdentifier: "freeVendorsIdentifier")
        
        freeToPaidFunction()
 
    }
    
    func paidUnpaidVendorFunction() {
        self.showHud("Loading...")
        let params = [
            "token":token,
            "device_id":"1234",
            "filter_name":""
        ]
        
        ServerManager.sharedInstance().chUnpaidvendorList(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.unpaidList = result!
                self.freeUnpaidListTableView.delegate = self
                self.freeUnpaidListTableView.dataSource = self
                self.freeUnpaidListTableView.reloadData()
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
 
    }
    
    func freeToPaidFunction() {
        
        self.showHud("Loading...")
        
        let params = [
            "token":token,
            "device_id":"1234",
            "filter_name":""
        ]

        ServerManager.sharedInstance().chfreeToPaidList(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.freeList = result!
                self.freeUnpaidListTableView.delegate = self
                self.freeUnpaidListTableView.dataSource = self
                self.freeUnpaidListTableView.reloadData()
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
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return self.freeList.count
        case 1:
            return self.unpaidList.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if segmentControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("freeVendorsIdentifier") as! VendorsFreeTableViewCell
            
            if freeList.count > 0 {
            cell.freevendorList = self.freeList[indexPath.row]
            }
            
            return cell
        }else if segmentControl.selectedSegmentIndex == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("freeVendorsIdentifier") as! VendorsFreeTableViewCell
            
            if unpaidList.count > 0 {
                cell.unpaidVendorList = self.unpaidList[indexPath.row]
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("freeVendorsIdentifier") as! VendorsFreeTableViewCell
            
//            if unpaidList.count > 0 {
//                cell.unpaidVendorList = self.unpaidList[indexPath.row]
//            }
            
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
            freeToPaidFunction()
        case 1:
            paidUnpaidVendorFunction()
        default:
            print("")
        }
        
    }
}
