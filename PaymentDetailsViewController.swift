//
//  PaymentDetailsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var paymentdetailsTableView: UITableView!
    var vendorPayments = [VendorPayment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
slideMenuShow(slideMenuButton, viewcontroller: self)
        
        let nib1 = UINib(nibName: "PaymentDetailsTableViewCell", bundle: nil)
        self.paymentdetailsTableView.registerNib(nib1, forCellReuseIdentifier: "paymentdetailsIdentifier")
    // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let params = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().getTransactionsHistory(params) { (isSuccessful, error, result) in
            if isSuccessful{
              self.vendorPayments = result!
                self.paymentdetailsTableView.delegate = self
                self.paymentdetailsTableView.dataSource = self
                self.paymentdetailsTableView.reloadData()
            }else{
                
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendorPayments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("paymentdetailsIdentifier") as! PaymentDetailsTableViewCell
        
        cell.vendorPayment = vendorPayments[indexPath.row]
        cell.viewInvoiceButtonLabel.addTarget(self, action: #selector(PaymentDetailsViewController.viewInvoice(_:)), forControlEvents: .TouchUpInside)
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    //MARK: - Custom Functions
    
    func viewInvoice(sender:UIButton) {
       
        let cell = sender.superview?.superview as! PaymentDetailsTableViewCell
        let indexPath = paymentdetailsTableView.indexPathForCell(cell)
        
        
        
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
