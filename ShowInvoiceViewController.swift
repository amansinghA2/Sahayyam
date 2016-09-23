//
//  ShowInvoiceViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ShowInvoiceViewController: UIViewController {

    @IBOutlet weak var invoiceView: UIWebView!
    
    var vendorPayment:VendorPayment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonForNavigation()
        tokenCheck()
        
        let vendorInvoice = BASE_URL + "index.php?route=api/invoice/vendorInvoice&id=" + vendorPayment.orderID + "&device=mobile"
        let subscriptionInvoice = BASE_URL + "index.php?route=api/invoice&id=" + vendorPayment.orderID + "&device=mobile"
        
        print(vendorInvoice)
        print(subscriptionInvoice)
        
        if vendorPayment.invoiceType == "vendor" {
          invoiceView.loadRequest(NSURLRequest(URL: NSURL(string: vendorInvoice)!))
        }else{
          invoiceView.loadRequest(NSURLRequest(URL: NSURL(string: subscriptionInvoice)!))
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

}
