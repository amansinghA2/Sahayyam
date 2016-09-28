//
//  StoreProfileViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class StoreProfileViewController: UIViewController {

    @IBOutlet weak var slideMenubButton: UIBarButtonItem!
    
    @IBOutlet weak var businessTimeingViewContraint: NSLayoutConstraint!
    @IBOutlet weak var deliveryTimingContraint: NSLayoutConstraint!
    
    @IBOutlet weak var businessTimingView: UIView!
    @IBOutlet weak var deliveryTimingView: UIView!
    
    @IBOutlet weak var fromLabel1: TextField!
    @IBOutlet weak var fromLabel2: TextField!
    @IBOutlet weak var fromLabel3: TextField!
    @IBOutlet weak var toLabel1: TextField!
    @IBOutlet weak var toLabel2: TextField!
    @IBOutlet weak var toLabel3: TextField!
    
    @IBOutlet weak var expressDeliveryButton: TextField!
    
    @IBOutlet weak var businessHolidayField: TextField!
    
    @IBOutlet weak var deliveryTimeTextField1: TextField!
    @IBOutlet weak var deliveryTimeTextField2: TextField!
    @IBOutlet weak var deliveryTimeTextField3: TextField!
    @IBOutlet weak var deliveryTimeTextField4: TextField!
    @IBOutlet weak var deliveryTimeTextField5: TextField!
    @IBOutlet weak var deliveryTimeTextField6: TextField!
    @IBOutlet weak var deliveryTimeTextField7: TextField!
    @IBOutlet weak var deliveryTimeTextField8: TextField!
    @IBOutlet weak var deliveryTimeTextField9: TextField!
    @IBOutlet weak var deliveryTimeTextField10: TextField!
    
    
    @IBOutlet weak var deliveryChargesTextField: TextField!
 
    @IBOutlet weak var minOrderTExtfField: TextField!
    @IBOutlet weak var lessThanMinOrderTextField: TextField!
    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideMenuShow(slideMenubButton, viewcontroller: self)
        
        deliveryTimeTextField1.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        deliveryTimeTextField2.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        deliveryTimeTextField3.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        deliveryTimeTextField4.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        deliveryTimeTextField5.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        deliveryTimeTextField6.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        deliveryTimeTextField7.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        deliveryTimeTextField8.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        deliveryTimeTextField9.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        deliveryTimeTextField10.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        
        fromLabel1.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        fromLabel2.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        fromLabel3.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        toLabel1.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        toLabel2.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        toLabel3.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deliveryTimeButton(sender: AnyObject) {
        i = i+1
        
        
        
    }

    @IBAction func businessTimeButton(sender: AnyObject) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func submitButtonClicked(sender: AnyObject) {
        
        
        
    }
    
}
