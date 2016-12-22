
//  CustomerListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorRegFeesViewController: UIViewController , UITableViewDataSource , UITableViewDelegate  {
    
    @IBOutlet weak var customerListTableView: UITableView!
    var vendRegDetails = [VendorRegDetails]()
    var vendRegDetail = VendorRegDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(chB2BViewController.showToastForRegister(_:)), name: "vendorRegisterStatus", object: nil)
        tokenCheck()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(chB2BViewController.navigationDisableAction1(_:)), name: "disableCategoryNavigation2", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(chB2BViewController.refreshList(_:)), name: "refresh2", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(chB2BViewController.navigationDisableAction(_:)), name: "disableNavigation", object: nil)
        
        let nib1 = UINib(nibName: "VendorRegTableViewCell", bundle: nil)
        self.customerListTableView.registerNib(nib1, forCellReuseIdentifier: "vendorRegIdentifier")
        let nib2 = UINib(nibName: "b2bcHeaderTableViewCell", bundle: nil)
        self.customerListTableView.registerNib(nib2, forCellReuseIdentifier: "b2bcheaderIdentifier")
 
        let view = FromToDateView.instanceFromNib()
        self.view.addSubview(view)
        vendorRegFeesFunction()
        
    }
    
    func vendorRegFeesFunction() {
        
        self.showHud("Loading...")
        
        let params = [
            "token":token,
            "device_id":"1234",
            ]
        
        ServerManager.sharedInstance().chvendorregFeesList(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.vendRegDetails = result!
                self.customerListTableView.delegate = self
                self.customerListTableView.dataSource = self
                self.customerListTableView.reloadData()
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    
    
    func navigationDisableAction1(notification:NSNotification) {
        self.navigationController?.navigationBar.userInteractionEnabled = false
    }
    
    func navigationDisableAction(notification:NSNotification) {
        self.navigationItem.leftBarButtonItem!.enabled = false
        self.navigationItem.rightBarButtonItem!.enabled = false
    }
    
    func showToastForRegister(notification:NSNotification) {
        if let object = notification.object as? String {
            if object == "cancel" {
                self.navigationItem.leftBarButtonItem!.enabled = true
                self.navigationItem.rightBarButtonItem!.enabled = true
            }else{
                self.navigationItem.leftBarButtonItem!.enabled = true
                self.navigationItem.rightBarButtonItem!.enabled = true
                //b2bListFunction()
                self.toastViewForTextfield(object)
            }
        }
    }
    
    
    func refreshList(notification: NSNotification) {
        if let myString = notification.object as? String {
            if myString == "enabledUserInteraction" {
                self.navigationController?.navigationBar.userInteractionEnabled = true
            }else{
                
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        //getCustomerListFunction()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return vendRegDetails.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vendRegDetails.count !=  0 {
            return (vendRegDetails[section].collapsed) ? 0 : 1
        }else{
            tableViewCustomLabel("No Details", tableView: customerListTableView)
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("b2bcheaderIdentifier") as! b2bcHeaderTableViewCell
        header.customerListButtonlabel.tag = section
        // header.customerList = customerListArray[section]
        header.b2bTypeLabel.text = vendRegDetails[section].vendor_shop_name
        header.b2bNameLabel.text = vendRegDetails[section].vendor_name
        
        header.customerListButtonlabel.addTarget(self, action: #selector(MenuViewController.toggleCollapse), forControlEvents: .TouchUpInside)
        //self.customerListTableView.tableHeaderView = header
        return header.contentView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vendorRegIdentifier") as! VendorRegTableViewCell
        
        cell.mobileNoLabel.text = vendRegDetails[indexPath.row].telephone
        cell.emailLabel.text = vendRegDetails[indexPath.row].email_id
        cell.regnDateLabel.text = vendRegDetails[indexPath.row].registration_date
        cell.amountLabel.text = vendRegDetails[indexPath.row].amount
        
        return cell
    }
    
    func toggleCollapse(sender: UIButton) {
        let section = sender.tag
        let collapsed = vendRegDetails[section].collapsed
        
        // Toggle collapse
        vendRegDetails[section].collapsed = !collapsed
        
        //customreList = vendRegDetails[section]
        
        self.customerListTableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 63
    }
    
    @IBAction func addContacts(sender: AnyObject) {
        
        //        let cell = sender.superview?.superview as! VendorCategorySubListTableViewCell
        
        //
        //        subChildArray = childArray.filter({
        //            if (parentArray[indexPath!.section].category_id == $0.parent_id) {
        //                return true
        //            }
        //            return false
        //        })
        
        //            if self.balanceCredit == 0 {
        //                toastViewForTextfield("You do not have any running subscription")
        //            }else{
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("customerRegistrationID") as! CustomerRegistrationViewController
        //popOverVC.serviceLists = self.serviceLists
        //popOverVC.categoryList = self.subChildArray[(indexPath?.row)!]
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        //            }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier == "goToCustomerImage" {
    //            let vc = segue.destinationViewController as! CustomerImageShowSubViewController
    //            vc.customerList1 = self.customerList1
    //        }
    //    }
    
    
}




