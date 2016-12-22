//
//  CustomerListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate  {
    
    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var customerListTableView: UITableView!
    var customerListArray = [CustomerList]()
    var customreList = CustomerList()
    var customerList1 = CustomerList()
    var isActive = false
    var balanceCredit = 5
    override func viewDidLoad() {
        super.viewDidLoad()
         revealTouch(self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CustomerListViewController.showToastForRegister(_:)), name: "vendorRegisterStatus", object: nil)
         tokenCheck()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CustomerListViewController.navigationDisableAction1(_:)), name: "disableCategoryNavigation2", object: nil)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CustomerListViewController.refreshList(_:)), name: "refresh2", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CustomerListViewController.navigationDisableAction(_:)), name: "disableNavigation", object: nil)
                slideMenuShow(slideMenuButton, viewcontroller: self)
        slideMenuShow(slideMenuButton, viewcontroller: self)
        let nib1 = UINib(nibName: "CustomerListTableViewCell", bundle: nil)
        self.customerListTableView.registerNib(nib1, forCellReuseIdentifier: "customerLIstCell")
        let nib2 = UINib(nibName: "CustomerListDetailTableViewCell", bundle: nil)
        self.customerListTableView.registerNib(nib2, forCellReuseIdentifier: "customerListDetailcell")
        
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
            getCustomerListFunction()
            self.toastViewForTextfield(object)
        }
      }
    }
    
    func getCustomerListFunction() {
        self.showHud("Loading...")
        let params = [
            "token":token ,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().getCustomerList(params) { (isSuccessful, error, result , dict) in
            if isSuccessful{
                self.hideHud()
                self.customerListArray = result!
                if let address_1 = dict!["balance_credit"] as? Int {
                    self.balanceCredit = Int(address_1)
                }
                self.customerListTableView.delegate = self
                self.customerListTableView.dataSource = self
                self.customerListTableView.reloadData()
//                self.balanceCreditLabel.text = "SUBSCRIPTION : FEES PER SALES" // + String(self.balanceCredit)
            }else{
                self.hideHud()
                AlertView.alertViewToGoToLogin("OK", message: "Server Error", alertTitle: "OK", viewController: self)
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
        getCustomerListFunction()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return customerListArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if customerListArray.count !=  0 {
            return (customerListArray[section].collapsed) ? 0 : 1
        }else{
            tableViewCustomLabel("No Customers", tableView: customerListTableView)
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("customerLIstCell") as! CustomerListTableViewCell
        header.customerListButtonlabel.tag = section
        header.customerList = customerListArray[section]
        
        header.blockUnblockButton.tag = section
        if customerListArray[section].grant == "0" {
            header.blockUnblockButton.setBackgroundImage(UIImage(named: "v_ic_blocked_user"), forState: .Normal)
        }else{
             header.blockUnblockButton.setBackgroundImage(UIImage(named: "v_ic_active_user"), forState: .Normal)
        }
        
        header.blockUnblockButton.addTarget(self, action: #selector(CustomerListViewController.blockUnblockButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        header.customerListButtonlabel.addTarget(self, action: #selector(MenuViewController.toggleCollapse), forControlEvents: .TouchUpInside)
        //self.customerListTableView.tableHeaderView = header
        return header.contentView
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomerListDetailTableViewCell = tableView.dequeueReusableCellWithIdentifier("customerListDetailcell") as! CustomerListDetailTableViewCell
        
        cell.customerList = customreList
        cell.popUpImage.tag = indexPath.row
        cell.popUpImage.addTarget(self, action: #selector(CustomerListViewController.PopUpButtonClicked(_:)), forControlEvents: .TouchUpInside)
        return cell
    }
    
    func PopUpButtonClicked(sender:UIButton) {
        let cell = sender.superview?.superview as! CustomerListDetailTableViewCell
        let indexpath = customerListTableView.indexPathForCell(cell)
        
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("CustomerShowImageID") as! CustomerImageShowSubViewController
        popOverVC.customerList1 = customerListArray[(indexpath?.section)!]
     // customerList1 = customerListArray[(indexpath?.row)!]
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        
    }
    
    func toggleCollapse(sender: UIButton) {
        let section = sender.tag
        let collapsed = customerListArray[section].collapsed
        
        // Toggle collapse
        customerListArray[section].collapsed = !collapsed
        
        customreList = customerListArray[section]
        
        self.customerListTableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 44
    }
    
    func blockUnblockButton(sender:UIButton){
        let section = sender.tag
        
        customreList = customerListArray[section]
        
//        if self.balanceCredit == 0 {
//            if customreList.grant == "0" {
//                toastViewForTextfield("You do not have any running subscription")
//            }else{
//                let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to block this customer", preferredStyle: .Alert)
//                
//                alertController.addAction(UIAlertAction(title: "YES", style: .Default, handler: { (action) in
//                    let params = [
//                        "token":token,
//                        "device_id":"1234",
//                        "cId":self.customreList.customerId,
//                        "status":"1"
//                    ]
//                    
//                    
//                    print(params)
//                    
//                    ServerManager.sharedInstance().blockunblockCustomers(params) { (isSuccessful, error, result) in
//                        if isSuccessful{
//                           sender.setBackgroundImage(UIImage(named: "v_ic_blocked_user"), forState: .Normal)
//                        }else{
//                           AlertView.alertView("Alert", message: "Server Error", alertTitle: "OK", viewController: self)
//                        }
//                    }
//                }))
//                
//                alertController.addAction(UIAlertAction(title: "NO", style: .Default, handler: nil))
//                
//                self.presentViewController(alertController, animated: true, completion: nil)
//            }
//
//        }else{
            if customreList.grant == "0" {
                let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to unblock this customer", preferredStyle: .Alert)
                
                alertController.addAction(UIAlertAction(title: "YES", style: .Default, handler: { (action) in
                    
                    self.showHud("Loading...")
                    let params = [
                        "token":token,
                        "device_id":"1234",
                        "cId":self.customreList.customerId,
                        "status":"0"
                    ]
                    
                    print(params)
                    
                    ServerManager.sharedInstance().blockunblockCustomers(params) { (isSuccessful, error, result) in
                        if isSuccessful{
                            self.hideHud()
                            self.getCustomerListFunction()
                            sender.setBackgroundImage(UIImage(named: "v_ic_active_user"), forState: .Normal)
                        }else{
                            self.hideHud()
                        AlertView.alertView("Alert", message: "Server Error", alertTitle: "OK", viewController: self)
                        }
                    }
                }))
                
                alertController.addAction(UIAlertAction(title: "NO", style: .Default, handler: { (action) in
                    self.hideHud()
                }))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Alert", message: "Are you sure you want to block this customer", preferredStyle: .Alert)
                self.showHud("Loading...")
                alertController.addAction(UIAlertAction(title: "YES", style: .Default, handler: { (action) in
                    let params = [
                        "token":token,
                        "device_id":"1234",
                        "cId":self.customreList.customerId,
                        "status":"1"
                    ]
                    
                    ServerManager.sharedInstance().blockunblockCustomers(params) { (isSuccessful, error, result) in
                        if isSuccessful{
                            self.hideHud()
                            self.getCustomerListFunction()
                            sender.setBackgroundImage(UIImage(named: "v_ic_blocked_user"), forState: .Normal)
                        }else{
                            self.hideHud()
                           AlertView.alertView("Alert", message: "Server Error ", alertTitle: "OK", viewController: self)
                        }
                     }
                }))
                
                alertController.addAction(UIAlertAction(title: "NO", style: .Default, handler: { (action) in
                    self.hideHud()
                }))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            }
//        }
    }

    @IBAction func addContacts(sender: AnyObject) {
        
//        let cell = sender.superview?.superview as! VendorCategorySubListTableViewCell
//        let indexPath = vendorCategoryTableview.indexPathForCell(cell)
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
