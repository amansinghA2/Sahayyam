//
//  CustomerListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , SWRevealViewControllerDelegate {
    
    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var customerListTableView: UITableView!
    var customerListArray = [CustomerList]()
    var customreList = CustomerList()
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenCheck()
                slideMenuShow(slideMenuButton, viewcontroller: self)
        slideMenuShow(slideMenuButton, viewcontroller: self)
        let nib1 = UINib(nibName: "CustomerListTableViewCell", bundle: nil)
        self.customerListTableView.registerNib(nib1, forCellReuseIdentifier: "customerLIstCell")
        
        let nib2 = UINib(nibName: "CustomerListDetailTableViewCell", bundle: nil)
        self.customerListTableView.registerNib(nib2, forCellReuseIdentifier: "customerListDetailcell")
        
    }

    override func viewWillAppear(animated: Bool) {
        self.showHud("Loading...")
        let params = [
        "token":token ,
        "device_id":"1234"
        ]
       
        print(params)
        
        ServerManager.sharedInstance().getCustomerList(params) { (isSuccessful, error, result) in
            if isSuccessful{
                self.hideHud()
              self.customerListArray = result!
                self.customerListTableView.delegate = self
                self.customerListTableView.dataSource = self
                self.customerListTableView.reloadData()
                print("IsSuccess")
            }else{
                
            }
        }
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
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("customerLIstCell") as! CustomerListTableViewCell
        
        header.customerListButtonlabel.tag = section
        header.customerList = customerListArray[section]
        header.customerListButtonlabel.addTarget(self, action: #selector(MenuViewController.toggleCollapse), forControlEvents: .TouchUpInside)
       // self.customerListTableView.tableHeaderView = header
        return header.contentView
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:CustomerListDetailTableViewCell = tableView.dequeueReusableCellWithIdentifier("customerListDetailcell") as! CustomerListDetailTableViewCell
    
        cell.customerList = customreList
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
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
    
    
    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition) {
        
        if position == FrontViewPosition.Left{
            self.view.userInteractionEnabled = true
        }else{
            self.view.userInteractionEnabled = false
        }
    }
    
    func revealController(revealController: SWRevealViewController!, didMoveToPosition position: FrontViewPosition) {
        if position == FrontViewPosition.Left{
            self.view.userInteractionEnabled = true
        }else{
            self.view.userInteractionEnabled = false
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
