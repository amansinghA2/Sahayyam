//
//  PayOfflineViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class PayOfflineViewController: UIViewController , DropperDelegate{

    @IBOutlet weak var storeNameTextfield: UITextField!
    
    @IBOutlet weak var amountTextfield: TextField!
    
    @IBOutlet weak var confirmAmountTextfield: TextField!
    
    @IBOutlet weak var orderidTextfield: UITextField!
    
    @IBOutlet weak var modeOfPaymentButton: UIButton!
    
    @IBOutlet weak var chequeNumberTextfield: UITextField!
    
    @IBOutlet weak var banknameTextfield: UITextField!
    
    var pendingInvoiceList = PendingInvoiceList()
    var dropper = Dropper(width: 131, height: 150)
    var mode = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        self.storeNameTextfield.userInteractionEnabled = false
        self.orderidTextfield.userInteractionEnabled = false
        
        if let name = self.pendingInvoiceList.vendor_name as? String {
            self.storeNameTextfield.text = name
        }
        
        if let name = self.pendingInvoiceList.order_no as? String {
            self.orderidTextfield.text = name
        }
        
        if let name = self.pendingInvoiceList.invoice_amt as? String {
            self.amountTextfield.text = name
        }
        
        if let name = self.pendingInvoiceList.order_no as? String {
            self.orderidTextfield.text = name
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
    
    
    @IBAction func modePaymentAction(sender: AnyObject) {
        
        if dropper.status == .Hidden {
            dropper = Dropper(x: modeOfPaymentButton.frame.origin.x, y: modeOfPaymentButton.frame.origin.y + modeOfPaymentButton.frame.size.height, width: modeOfPaymentButton.frame.size.width, height: 150)
            dropper.tag = 1
            dropper.items = ["Cheque" , "D.D"]
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Bottom, button: modeOfPaymentButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
        
    }
    
    func DropperSelectedRow(path: NSIndexPath, contents: String) {
        
        modeOfPaymentButton.setTitle(contents, forState: .Normal)
        
        if contents == "Cheque" {
            mode = 3
        }else{
            mode = 4
        }
    }
    
    func formValidation() -> Bool {
        return true
        
    }
    
    @IBAction func submitButtonAction(sender: AnyObject) {
        
        self.showHud("Loading...")
        
        let params:[String:AnyObject] = [
        "token":token,
        "device_id":"1234",
        "seller_id":self.pendingInvoiceList.seller_id,
        "invoice_id":self.pendingInvoiceList.invoice_no,
        "amount":confirmAmountTextfield.text!,
        "mode":mode,
        "number":chequeNumberTextfield.text!,
        "bank":self.banknameTextfield.text!,
        "order_id":self.pendingInvoiceList.order_no
        ]
        
        ServerManager.sharedInstance().chVendorOfflineInvoice(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
        
    }
    

}
