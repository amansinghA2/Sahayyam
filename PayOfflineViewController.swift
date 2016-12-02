//
//  PayOfflineViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class PayOfflineViewController: UIViewController {

    @IBOutlet weak var storeNameTextfield: UITextField!
    
    @IBOutlet weak var amountTextfield: TextField!
    
    @IBOutlet weak var confirmAmountTextfield: TextField!
    
    @IBOutlet weak var orderidTextfield: UITextField!
    
    @IBOutlet weak var modeOfPaymentButton: UIButton!
    
    @IBOutlet weak var chequeNumberTextfield: UITextField!
    
    @IBOutlet weak var banknameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    
    @IBAction func submitButtonAction(sender: AnyObject) {
    }
    

}
