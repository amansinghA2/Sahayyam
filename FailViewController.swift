//
//  FailViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/12/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class FailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FailViewController.ResponseNew(_:)), name: "JSON_NEW", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("JSON_DICT", object: nil, userInfo: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    func ResponseNew(message: NSNotification) {
        if (message.name == "JSON_NEW") {
//            NSLog("Response = %@", message.object)
//            jsondict = message.object
        }}
    
    @IBAction func tryAgainAction(sender: AnyObject) {
        let paymentView: PaymentModeViewController = PaymentModeViewController()
        
        paymentView.paymentAmtString = NSUserDefaults.standardUserDefaults().objectForKey("paymentAmtString") as? String
        paymentView.descriptionString = NSUserDefaults.standardUserDefaults().objectForKey("descriptionString") as? String
        paymentView.strSaleAmount = NSUserDefaults.standardUserDefaults().objectForKey("strSaleAmount") as? String
        paymentView.strCurrency = NSUserDefaults.standardUserDefaults().objectForKey("strCurrency") as? String
        paymentView.strDisplayCurrency = NSUserDefaults.standardUserDefaults().objectForKey("strDisplayCurrency") as? String
        paymentView.strDescription = NSUserDefaults.standardUserDefaults().objectForKey("strDescription") as? String
        paymentView.strBillingName = NSUserDefaults.standardUserDefaults().objectForKey("strBillingName") as? String
        paymentView.strBillingAddress = NSUserDefaults.standardUserDefaults().objectForKey("strBillingAddress") as? String
        paymentView.strBillingCity = NSUserDefaults.standardUserDefaults().objectForKey("strBillingCity") as? String
        paymentView.strBillingState = NSUserDefaults.standardUserDefaults().objectForKey("strBillingState") as? String
        paymentView.strBillingPostal = NSUserDefaults.standardUserDefaults().objectForKey("strBillingPostal") as? String
        paymentView.strBillingCountry = NSUserDefaults.standardUserDefaults().objectForKey("strBillingCountry") as? String
        paymentView.strBillingEmail = NSUserDefaults.standardUserDefaults().objectForKey("strBillingEmail") as? String
        paymentView.strBillingTelephone = NSUserDefaults.standardUserDefaults().objectForKey("strBillingTelephone") as? String
        paymentView.strDeliveryName = NSUserDefaults.standardUserDefaults().objectForKey("strDeliveryName") as? String
        paymentView.strDeliveryAddress = NSUserDefaults.standardUserDefaults().objectForKey("strDeliveryAddress") as? String
        paymentView.strDeliveryCity = NSUserDefaults.standardUserDefaults().objectForKey("strDeliveryCity") as? String
        paymentView.strDeliveryState = NSUserDefaults.standardUserDefaults().objectForKey("strDeliveryState") as? String
        paymentView.strDeliveryPostal = NSUserDefaults.standardUserDefaults().objectForKey("strDeliveryPostal") as? String
        paymentView.strDeliveryCountry = NSUserDefaults.standardUserDefaults().objectForKey("strDeliveryCountry") as? String
        paymentView.strDeliveryTelephone = NSUserDefaults.standardUserDefaults().objectForKey("strDeliveryTelephone") as? String
        paymentView.reference_no = NSUserDefaults.standardUserDefaults().objectForKey("reference_no") as? String
        for (var i = 0; i < self.navigationController?.viewControllers.count; i++)
        {
            if(self.navigationController?.viewControllers[i].isKindOfClass(PaymentModeViewController) == true)
            {
                self.navigationController?.popToViewController(self.navigationController!.viewControllers[i] as! PaymentModeViewController, animated: true)
                break;
            }
        }
    }
    
    @IBAction func cancelClk(sender: AnyObject)
    {
        var index: Int = 0
        var status: Bool = false
        for (var i = 0; i < self.navigationController?.viewControllers.count; i++)
        {//Below ViewController is the view controller is to navigate on Cancel Button pressed.
            if(self.navigationController?.viewControllers[i].isKindOfClass(CancelViewController) == true)
            {
                index = i;
                status = true;
            }
        }
        if status
        {
            self.navigationController?.popToViewController(self.navigationController!.viewControllers[index] as! CancelViewController, animated: true)
        }
        else
        {
            self.navigationController!.pushViewController(self.navigationController!.viewControllers[index] as! CancelViewController, animated: false)
        }  }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
