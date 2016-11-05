//
//  VendorPromotionsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorPromotionsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var vendorPromotionTableView: UITableView!

    var vendorPromotionsLists = [VendorPromotionList]()
    var vendorPromotionsList:VendorPromotionList!
    var isBoolActivate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenCheck()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(VendorPromotionsViewController.showToastView(_:)), name: "showtoast", object: nil)
        slideMenuShow(slideMenuButton, viewcontroller: self)
        let nibName = UINib(nibName: "VendorPromotionTableViewCell", bundle:nil)
        self.vendorPromotionTableView.registerNib(nibName, forCellReuseIdentifier: "promotioncellIdentifier")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayPromotionList() {
        self.showHud("Loading...")
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().displayPromotionList(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
                self.vendorPromotionsLists = result!
                self.vendorPromotionTableView.delegate = self
                self.vendorPromotionTableView.dataSource = self
                self.vendorPromotionTableView.reloadData()
            }else{
                self.hideHud()
                if error != nil {
                    self.tableViewCustomLabel(error!, tableView:self.vendorPromotionTableView)
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
     displayPromotionList()
    }
    
    
    func showToastView(notification:NSNotification) {
         displayPromotionList()
        if let object1 = notification.object as? String {
            if object1 == "Promotion created successfully" {
               self.toastViewForTextfield(object1)
            }else{
               self.toastViewForTextfield("Product edited successfully")
            }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if vendorPromotionsLists.count == 0 {
            isBoolActivate =  false
            self.tableViewCustomLabel("No Promotions Available", tableView:self.vendorPromotionTableView)
        }else{
            self.tableViewCustomLabel("", tableView:self.vendorPromotionTableView)
        }
        return vendorPromotionsLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("promotioncellIdentifier") as! VendorPromotionTableViewCell
        cell.vendorPromotionList = self.vendorPromotionsLists[indexPath.row]
        
        if self.vendorPromotionsLists[indexPath.row].status == "1" {
            cell.deactivateButton.setTitle("Activated", forState: .Normal)
            isBoolActivate = true
            cell.notifyButton.hidden = false
        }else{
            cell.deactivateButton.setTitle("Deactivated", forState: .Normal)
            isBoolActivate = false
            cell.notifyButton.hidden = true
        }
        
        cell.deactivateButton.addTarget(self, action: #selector(VendorPromotionsViewController.deactivateButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.deleteButton.addTarget(self, action: #selector(VendorPromotionsViewController.deleteButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.notifyButton.addTarget(self, action: #selector(VendorPromotionsViewController.notifyButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        vendorPromotionsList = self.vendorPromotionsLists[indexPath.row]
        
        if isBoolActivate ==  true {
            toastViewForTextfield("Please deactivate active promotion to add new one.")
        }else{
           self.performSegueWithIdentifier("goToEditPromotion", sender: nil)
        }
  
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    @IBAction func createPromotionAction(sender: AnyObject){
        if isBoolActivate ==  true {
           toastViewForTextfield("Please deactivate active promotion to add new one.")
        }else{
        self.performSegueWithIdentifier("goToCreatePromotion", sender: nil)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToEditPromotion" {
            let vc = segue.destinationViewController as? PromotionTypeViewController
            vc!.vendorPromotionList = self.vendorPromotionsList
            vc!.str = "fromEdit"
        }else{
            
        }
    }
    
    // MARK: - Custom Functions
    
    func deactivateButtonClicked(sender:UIButton) {
        
        let cell = sender.superview?.superview as! VendorPromotionTableViewCell
        let indexPath = vendorPromotionTableView.indexPathForCell(cell)

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        print(self.vendorPromotionsLists[(indexPath?.row)!].end_date_added)
        let date = dateFormatter.dateFromString(self.vendorPromotionsLists[(indexPath?.row)!].end_date_added)
        let date1 = NSDate()
        if date?.compare(date1) == .OrderedAscending {
            AlertView.alertView("Alert", message: "Cannot be activated or deactived as the promotion has expired", alertTitle: "OK", viewController: self)
        }else{
             if self.vendorPromotionsLists[(indexPath?.row)!].status == "1" {
               
             let refreshAlert = UIAlertController(title: "Alert", message: "Do you want to deactivate this promotion?", preferredStyle: UIAlertControllerStyle.Alert)
             refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
 
                    let params = [
                        "token":token,
                        "device_id":"1234",
                        "promotion_id":self.vendorPromotionsLists[(indexPath?.row)!].product_id,
                        "status":self.vendorPromotionsLists[(indexPath?.row)!].status
                    ]

                    ServerManager.sharedInstance().vendorDeactivatePromotion(params) { (isSuccessful, error, result) in
                        if isSuccessful {
                            self.hideHud()
                            self.isBoolActivate = false
                           // sender.setTitle("Deactivated", forState: .Normal)
                            self.displayPromotionList()
//                            self.vendorPromotionTableView.delegate = self
//                            self.vendorPromotionTableView.dataSource = self
//                            self.vendorPromotionTableView.reloadData()
                        }else{
                            self.hideHud()
                        }
                    }
                }))
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                presentViewController(refreshAlert, animated: true, completion: nil)
             }
             else{
                let refreshAlert = UIAlertController(title: "Alert", message: "Do you want to activate this promotion?", preferredStyle: UIAlertControllerStyle.Alert)
                refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
                   
                    
                    let params = [
                        "token":token,
                        "device_id":"1234",
                        "promotion_id":self.vendorPromotionsLists[(indexPath?.row)!].product_id,
                        "status":self.vendorPromotionsLists[(indexPath?.row)!].status
                    ]
                    ServerManager.sharedInstance().vendorDeactivatePromotion(params) { (isSuccessful, error, result) in
                        if isSuccessful {
                            self.hideHud()
                            self.isBoolActivate = true
                           // sender.setTitle("Activated", forState: .Normal)
                            self.displayPromotionList()
//                            self.vendorPromotionTableView.delegate = self
//                            self.vendorPromotionTableView.dataSource = self
//                            self.vendorPromotionTableView.reloadData()
                        }else{
                            self.hideHud()
                        }
                    }
                }))
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                presentViewController(refreshAlert, animated: true, completion: nil)
                }
           }
    }
    
    func deleteButtonClicked(sender:UIButton){
        
        self.showHud("Loading...")
        
        let cell = sender.superview?.superview as! VendorPromotionTableViewCell
        let indexPath = vendorPromotionTableView.indexPathForCell(cell)
        
        
        let refreshAlert = UIAlertController(title: "Alert", message: "Are you sure you want to remove this promotion", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            let params = [
                "token":token,
                "device_id":"1234",
                "promotion_id":self.vendorPromotionsLists[(indexPath?.row)!].product_id
            ]
            
            ServerManager.sharedInstance().vendorDeletePromotion(params) { (isSuccessful, error, result) in
                if isSuccessful {
                    self.hideHud()
                    self.vendorPromotionsLists.removeAtIndex((indexPath?.row)!)
                    self.vendorPromotionTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
                    self.vendorPromotionTableView.reloadData()
                }else{
                    self.hideHud()
                }
            }
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            self.hideHud()
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    func notifyButtonClicked(sender:UIButton){
        
        let cell = sender.superview?.superview as! VendorPromotionTableViewCell
        let indexPath = vendorPromotionTableView.indexPathForCell(cell)

        let params = [
        "token":token,
        "device_id":"1234",
        "messageText":self.vendorPromotionsLists[(indexPath?.row)!].promotionDescription + " on Price : INR " + self.vendorPromotionsLists[(indexPath?.row)!].discount
        ]
        
        print(params) 
        
        ServerManager.sharedInstance().vendorNotifcation(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if segue.identifier == "goToEditPromotion" {
//            let vc = segue.destinationViewController as! PromotionTypeViewController
//            vc
//        }
//        
//    }
 

}
