//
//  ServiceListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 17/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ServiceListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var serviceListTableView: UITableView!
    var serviceList = VendorServiceList()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "ServiceListTableViewCell", bundle:nil)
        self.serviceListTableView.registerNib(nibName, forCellReuseIdentifier: "servicesCell1")
        slideMenuShow(slideMenuButton, viewcontroller: self)
        revealTouch(self)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ServiceListViewController.showUpdatedData), name: "showUPdatedData", object: nil)
        serviceListFunction()
        
        // Do any additional setup after loading the view.
    }

    func showUpdatedData() {
        self.toastViewForTextfield("Service added successfully")
        serviceListFunction()
    }
    
    func serviceListFunction() {
        self.showHud("Loading...")
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().vendorProductGetService(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.serviceList = result!
                self.serviceListTableView.delegate = self
                self.serviceListTableView.dataSource = self
                self.serviceListTableView.reloadData()
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

//    MARK: - Table view delegates
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serviceList.serviceDesc.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("servicesCell1") as! ServiceListTableViewCell
        
        if self.serviceList.serviceDesc.count > 0 {
            cell.serviceList = self.serviceList.serviceDesc[indexPath.row]
        }else{
            tableViewCustomLabel("No Services", tableView: serviceListTableView)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    @IBAction func serviceListFunction(sender: AnyObject) {
        
        if serviceList.getLeftService.count > 0 {
        
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("SubServicesID") as! ServiceListSubViewController
        //popOverVC.categoryList = self.parentArray[section]
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        }else{
            toastViewForTextfield("No more services to add")
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
