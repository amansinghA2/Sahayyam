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
        setBackButtonForNavigation()
        mobileNumberTextfield.setTextFieldStyle(TextFieldStyle.MobileNumber)
        birthDatetextfield.setTextFieldStyle(TextFieldStyle.TextFieldDOB)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func senOTPAction(sender: AnyObject){
        self.showHud("Loading...")
        
        if Reachability.isConnectedToNetwork(){
        if  birthDatetextfield.text?.isBlank == false{
        if mobileNumberTextfield.text?.isPhoneNumber  == true && mobileNumberTextfield.text?.isBlank == false {
            let params:[String:AnyObject]? = [
            "dobirth": birthDatetextfield.text!,
            "mobile":mobileNumberTextfield.text!
            ]
            
        ServerManager.sharedInstance().customerOTP(params, completionClosure: { (isSuccessful, error, result) in
            
            if isSuccessful {
                self.hideHud()
                self.optData = result!
                
                if let otpId1 = result!["ID"] {
                  otpId = otpId1 as! String
                  print(otpId)
                }
                self.performSegueWithIdentifier("goToOTPPage", sender: self)
            }else{
                self.hideHud()
                AlertView.alertView("Invalid", message: "Invalid Data", alertTitle: "OK", viewController: self)
            }
        })
        }else{
            self.hideHud()
                AlertView.alertView("Invalid", message: "Invalid Mobile Number or the field is empty", alertTitle: "OK", viewController: self)
           }
        }
        else{
            self.hideHud()
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
