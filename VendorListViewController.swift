//
//  VendorListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , SWRevealViewControllerDelegate{

    @IBOutlet weak var vendorLIstTableView: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var vendorOrderLists = [CustomerOrders]()
    var vendorOrderData = CustomerOrders()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenCheck()
        self.showHud("Loading...")
        revealTouch(self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VendorListViewController.toastViewShowing(_:)), name: "toastViewShow", object: nil)
        slideMenuShow(menuButton, viewcontroller: self)
        let nib = UINib(nibName: "TrackOrderTableViewCell", bundle: nil)
        vendorLIstTableView.registerNib(nib, forCellReuseIdentifier: "trackOrderCell")
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        slideMenuShow(menuButton, viewcontroller: self)
        self.revealViewController().delegate = self
        self.showHud("Loading...")
        let params = [
        "token":token ,
        "device_id":"1234",
        "iDisplayLength":"25",
        "page":"1"
        ]
        
        ServerManager.sharedInstance().viewVendorOrders(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
                self.vendorOrderLists = result!
                self.vendorLIstTableView.delegate = self
                self.vendorLIstTableView.dataSource = self
                self.vendorLIstTableView.reloadData()
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
        
        if vendorOrderLists.count == 0 {
            self.tableViewCustomLabel("No Orders", tableView: vendorLIstTableView)
        }
        
        return vendorOrderLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TrackOrderTableViewCell = tableView.dequeueReusableCellWithIdentifier("trackOrderCell") as! TrackOrderTableViewCell
        
         cell.vendorLoadData = vendorOrderLists[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        self.vendorOrderData = self.vendorOrderLists[indexPath.row]
        self.performSegueWithIdentifier("gotoTrackDetails", sender: nil)
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    // MARK:-  RevealView Controller Delegate
    
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

    func toastViewShowing(notification:NSNotification) {
        if let obj = notification.object as? String {
            self.toastViewForTextfield(" Order Successfully \(obj)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoTrackDetails" {
           let vc = segue.destinationViewController as! VendorOrderDetailsViewController
           vc.vendorListData = self.vendorOrderData
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
