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
     var vendorPayment = VendorPayment()
    var vendor_type = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuShow(slideMenuButton, viewcontroller: self)
        tokenCheck()
         revealTouch(self)
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
        
        ServerManager.sharedInstance().getTransactionsHistory(params) { (isSuccessful, error, result , result1) in
            if isSuccessful{
                self.vendorPayments = result!
                
                if let vendorType = result1!["vendor_type"] as? String {
                   self.vendor_type = vendorType
                }
                
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
        
        if vendor_type == "2" && vendorPayments[indexPath.row].payStatus == "1" {
            cell.viewInvoiceButtonLabel.setTitle("Make Payment", forState: .Normal)
            cell.viewInvoiceButtonLabel.hidden = true
        }else{
            cell.viewInvoiceButtonLabel.setTitle("View Invoice", forState: .Normal)
            cell.viewInvoiceButtonLabel.hidden = false
        }
        
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
        
        if vendor_type == "2" && vendorPayments[indexPath!.row].payStatus == "1" {
            let paymentView = PaymentModeViewController(nibName: "PaymentModeViewController", bundle: nil)
            paymentView.paymentAmtString = "";
            paymentView.strSaleAmount = "";
            paymentView.strCurrency = "INR";
            paymentView.strDisplayCurrency = "INR";
            // Reference no has to be configured
            paymentView.reference_no = self.vendorPayments[(indexPath?.row)!].orderID;
            paymentView.strDescription = "Test Description";
            paymentView.strBillingName = "Test";
            paymentView.strBillingAddress = "Bill address";
            paymentView.strBillingCity = "Bill City";
            paymentView.strBillingState = "TN";
            paymentView.strBillingPostal = "410210";
            paymentView.strBillingCountry = "IND";
            paymentView.strBillingEmail = "test@testmail.com";
            paymentView.strBillingTelephone = "9363469999";
            // Non mandatory parameters
            paymentView.strDeliveryName = "Aman";
            paymentView.strDeliveryAddress = "Kharghar";
            paymentView.strDeliveryCity = "Mumbai";
            paymentView.strDeliveryState = "Maharashtra";
            paymentView.strDeliveryPostal = "410210";
            paymentView.strDeliveryCountry = "India";
            paymentView.strDeliveryTelephone = "9869796388";
            
            // Dynamic Values configuration
            // var dynamicKeyValueDictionary: NSMutableDictionary = NSMutableDictionary()
            // dynamicKeyValueDictionary.setValue("savings", forKey: "account_detail")
            // dynamicKeyValueDictionary.setValue("gold", forKey: "merchant_type")
            // paymentView.dynamicKeyValueDictionary = dynamicKeyValueDictionary
            self.navigationController!.pushViewController(paymentView, animated: true)
        }else{
            self.vendorPayment = self.vendorPayments[(indexPath?.row)!]
            self.performSegueWithIdentifier("showInvoiceSegue", sender: nil)
        }
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showInvoiceSegue" {
            let vc = segue.destinationViewController as! ShowInvoiceViewController
            vc.vendorPayment = self.vendorPayment
        }
    }


}
