//
//  SubsPaymentViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SubsPaymentViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var subsTableView: UITableView!
    
    @IBOutlet weak var subsSegmentControl: UISegmentedControl!
    var subsDetails = [CHVendorSubsList]()
    var customerId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SubsPaymentTableViewCell", bundle: nil)
        self.subsTableView.registerNib(nib, forCellReuseIdentifier: "subPaymentIdentifier")
        
        let nib1 = UINib(nibName: "PendingInvoiceTableViewCell", bundle: nil)
        self.subsTableView.registerNib(nib1, forCellReuseIdentifier: "pendingInvoiceIdentifier")
        
        setUpSubsInfo()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
      
    }
    
    func setUpSubsInfo() {
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().chVendorListForSbbscription(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.subsDetails = result!
                self.subsTableView.delegate = self
                self.subsTableView.dataSource = self
                self.subsTableView.reloadData()
            }
        }
    }
    
    func setUpVendorInvoice() {
        
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subsSegmentControl.selectedSegmentIndex == 0 {
         return self.subsDetails.count
        }else{
          return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if subsSegmentControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("subPaymentIdentifier") as! SubsPaymentTableViewCell
            
            cell.subsLabel.text = self.subsDetails[indexPath.row].firstname + " " + self.subsDetails[indexPath.row].lastname
            
            cell.subsPaymentButton.addTarget(self, action: #selector(SubsPaymentViewController.subsButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("pendingInvoiceIdentifier") as! PendingInvoiceTableViewCell
            
//            cell.subsLabel.text = self.subsDetails[indexPath.row].firstname + " " + self.subsDetails[indexPath.row].lastname
            
            cell.payOnlineButton.addTarget(self, action: #selector(SubsPaymentViewController.onlineButtontapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.payOfflineButton.addTarget(self, action: #selector(SubsPaymentViewController.offlineButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
        }
       
    }
    
    func onlineButtontapped(sender:Button) {
        let cell = sender.superview?.superview as! PendingInvoiceTableViewCell
        let indexPath = self.subsTableView.indexPathForCell(cell)
        
    }
    
    func offlineButtonTapped(sender:Button) {
        let cell = sender.superview?.superview as! PendingInvoiceTableViewCell
        let indexPath = self.subsTableView.indexPathForCell(cell)
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func subsButtonTapped(sender:UIButton){
        let cell = sender.superview?.superview as! SubsPaymentTableViewCell
        let indexPath = self.subsTableView.indexPathForCell(cell)
        customerId = self.subsDetails[(indexPath?.row)!].customer_id
        self.performSegueWithIdentifier("showPaymentInfoSegue", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPaymentInfoSegue" {
            let vc = segue.destinationViewController as! AddSubscriptionViewController
            vc.customerId = self.customerId
            print(self.customerId)
        }
    }
    
    
    @IBAction func subsPaymentSegmentAction(sender: AnyObject) {
        
        if subsSegmentControl.selectedSegmentIndex == 0 {
            setUpSubsInfo()
        }else{
            setUpVendorInvoice()
        }
        
    }

}
