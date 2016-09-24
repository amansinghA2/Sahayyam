//
//  OTPViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 08/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var otpTextField: TextField!
    
    var otpData:[String:AnyObject]!
    var otp = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       otpTextField.setTextFieldStyle(TextFieldStyle.Pincode)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func otpValidation() {

        if otpTextField.text?.isBlank == false {
            if let otp = otpData["otp"]{
                self.otp = otp as! Int
            }
            if otpTextField.text == String(self.otp) {
              performSegueWithIdentifier("goToChangePasword", sender: nil)
            }else{
                AlertView.alertView("Incorrect OTP", message: "Wrong OTP entered", alertTitle: "OK", viewController: self)
            }
        }else{
            AlertView.alertView("Invalid", message: "Field is empty", alertTitle: "OK", viewController: self)
        }
    }
    
    @IBAction func optValidateButton(sender: AnyObject) {
        
         otpValidation()
        
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
