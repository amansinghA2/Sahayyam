//
//  VendorCityHeadViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorCityHeadViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate{

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var vendorSubsListTableView: UITableView!
    var vendorSubsLIsts = [CHVendorSubsList]()
    var unpaidList = [UnpaidVendorList]()
    var freeList = [FreeVendorList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSearchBar()
        
        let nib1 = UINib(nibName: "AllVendorsTableViewCell", bundle: nil)
        self.vendorSubsListTableView.registerNib(nib1, forCellReuseIdentifier: "allVendorsIdentifier")
        
        let nib2 = UINib(nibName: "VendorsFreeTableViewCell", bundle: nil)
        self.vendorSubsListTableView.registerNib(nib2, forCellReuseIdentifier: "freeVendorsIdentifier")
        
        setUpVendorList("")
       
    }
    
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        searchBar.placeholder = "Enter Mobile No. or Name"
        self.navigationItem.titleView = searchBar
    }
    
    // Search Bar delegates
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            setUpVendorList(searchText)
        case 1:
            freeToPaidFunction(searchText)
        case 2:
            paidUnpaidVendorFunction(searchText)
        default:
            print("")
        }
    
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    func paidUnpaidVendorFunction(filterName:String) {
        
        self.showHud("Loading...")
        
        let params = [
            "token":token,
            "device_id":"1234",
            "filter_name":filterName
        ]
        
        ServerManager.sharedInstance().chUnpaidvendorList(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.unpaidList = result!
                self.vendorSubsListTableView.delegate = self
                self.vendorSubsListTableView.dataSource = self
                self.vendorSubsListTableView.reloadData()
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
        
    }
    
    func freeToPaidFunction(filterName:String) {
        
        self.showHud("Loading...")
        
        let params = [
            "token":token,
            "device_id":"1234",
            "filter_name":filterName
        ]
        
        ServerManager.sharedInstance().chfreeToPaidList(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.freeList = result!
                self.vendorSubsListTableView.delegate = self
                self.vendorSubsListTableView.dataSource = self
                self.vendorSubsListTableView.reloadData()
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }

    
    func setUpVendorList(filterName:String) {
        self.showHud("Loading...")
        let params = [
            "token":token,
            "device_id":"1234",
            "filter_name":filterName
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
            return self.freeList.count
        }else{
            if self.unpaidList.count > 0 {
               return self.unpaidList.count
            }else{
               self.toastViewForTextfield("No Vendors")
               return 0
            }
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
           if self.freeList.count > 0 {
                cell.freevendorList = self.freeList[indexPath.row]
            }else{
                self.toastViewForTextfield("No Vendors")            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("freeVendorsIdentifier") as! VendorsFreeTableViewCell
            if self.unpaidList.count > 0 {
                cell.unpaidVendorList = self.unpaidList[indexPath.row]
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
            setUpVendorList("")
        case 1:
            freeToPaidFunction("")
        default:
            paidUnpaidVendorFunction("")
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
