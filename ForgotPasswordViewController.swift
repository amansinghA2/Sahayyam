//
//  ForgotPasswordViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 01/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var mobileNumberTextfield: TextField!
    @IBOutlet weak var birthDatetextfield: TextField!
    var optData = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mobileNumberTextfield.setTextFieldStyle(TextFieldStyle.MobileNumber)
        birthDatetextfield.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        
  
        
//        var vc = PDTSimpleCalendarViewController()
//        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
//        calendar.locale = NSLocale.currentLocale()
//        calendar.timeZone = NSDate.localTimeZone()
//        vc.calendar = calendar

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func senOTPAction(sender: AnyObject){
        
        if Reachability.isConnectedToNetwork(){
        if  birthDatetextfield.text?.isBlank == false{
        if mobileNumberTextfield.text?.isPhoneNumber  == true && mobileNumberTextfield.text?.isBlank == false {
            let params:[String:AnyObject]? = [
            "dobirth": birthDatetextfield.text!,
            "mobile":mobileNumberTextfield.text!
            ]
            
        ServerManager.sharedInstance().customerOTP(params, completionClosure: { (isSuccessful, error, result) in
            
            if isSuccessful {
                self.optData = result!
                self.performSegueWithIdentifier("goToOTPPage", sender: self)
            }else{
                AlertView.alertView("Invalid", message: "Invalid Data", alertTitle: "OK", viewController: self)
            }
            
        })
        }else{
                AlertView.alertView("Invalid", message: "Invalid Mobile Number or the field is empty", alertTitle: "OK", viewController: self)
             }
        }
        else{
                AlertView.alertView("Invalid", message: "Field is blank", alertTitle: "OK", viewController: self)
        }
    }
    else{
    self.hideHud()
    AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
    }
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "goToOTPPage" {
            let vc = segue.destinationViewController as! OTPViewController
            vc.otpData = optData
            print(vc.otpData)
        }
        
    }
 

}
