//
//  StoreProfileViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class StoreProfileViewController: UIViewController {

    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deliveryTimeButton(sender: AnyObject) {
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
