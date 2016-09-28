//
//  ChangePasswordViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 08/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var confirmpasswordTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.setTextFieldStyle(TextFieldStyle.TextFieldPassword)
        confirmpasswordTextField.setTextFieldStyle(TextFieldStyle.TextFieldPassword)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
       self.showHud("Pleast Wait...")
        
        let params:[String:AnyObject] = [
        "id":otpId,
        "password":passwordTextField.text!,
        "confirm":confirmpasswordTextField.text!
        ]
        
        print(params)
        if formValidation() {
        ServerManager.sharedInstance().passwordChange(params) { (isSuccessful, error, result) in
        if isSuccessful {
//            self.hideHud()
//            AlertView.alertView("Alert", message: "Password successfully changed", alertTitle: "OK", viewController: self)
//            let refreshAlert = UIAlertController(title: "Alert", message: "Password successfully changed", preferredStyle: UIAlertControllerStyle.Alert)
//            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
//                
//                }
//                ))
//            
//            self.presentViewController(refreshAlert, animated: true, completion: nil)
            AlertView.alertViewToGoToLogin("Alert", message: "Password Successfully changed", alertTitle: "OK", viewController: self)
            self.hideHud()
        }else{
            self.hideHud()
        }
       }
        }else{
            
        }
    }
    
    func formValidation() -> Bool{
        
        if !(Validations.isValidPassAndConfirmPassword(passwordTextField.text! , confirmPassword: confirmpasswordTextField.text!)) {
            self.hideHud()
            AlertView.alertView("Alert", message: "Password and confirm password do not match", alertTitle: "OK", viewController: self)
            return false
        }
        return true
    }

    

}
