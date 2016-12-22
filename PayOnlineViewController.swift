//
//  PayOnlineViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class PayOnlineViewController: UIViewController {

    @IBOutlet weak var customerNameLabel: UILabel!
    
    @IBOutlet weak var emailIdLabel: UILabel!
    
    @IBOutlet weak var mobileNumber: UILabel!
    
    @IBOutlet weak var orderIdLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    var pendingInvoiceList = PendingInvoiceList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let customerName = pendingInvoiceList.vendor_name as? String{
            customerNameLabel.text = customerName
        }
        
        if let customerName = pendingInvoiceList.email as? String{
            emailIdLabel.text = customerName
        }
        
        if let customerName = pendingInvoiceList.telephone as? String{
            mobileNumber.text = customerName
        }
        
        if let customerName = pendingInvoiceList.order_no as? String{
            orderIdLabel.text = customerName
        }
        
        if let customerName = pendingInvoiceList.invoice_amt as? String{
            amountLabel.text = customerName
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func proceedAction(sender: AnyObject) {
        
     
        
    }
    
    

}
