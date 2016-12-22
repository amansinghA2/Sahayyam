//
//  CityHeadCPViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CityHeadCPViewController: UIViewController {
    @IBOutlet weak var changePassword: TextField!

    @IBOutlet weak var confirmPassword: TextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func formValidation() -> Bool{
        
        if (changePassword.text?.isBlank == true  || confirmPassword.text?.isBlank == true){
            self.hideHud()
            AlertView.alertView("Alert", message: "Field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if (changePassword.text?.characters.count < 4 || confirmPassword.text?.characters.count < 4) {
            self.hideHud()
            AlertView.alertView("Alert", message: "Password should be more than 4 characters", alertTitle: "OK", viewController: self)
        }
        
        if !(Validations.isValidPassAndConfirmPassword(changePassword.text! , confirmPassword: confirmPassword.text!)) {
            self.hideHud()
            AlertView.alertView("Alert", message: "Password and confirm password do not match", alertTitle: "OK", viewController: self)
            return false
        }
        return true
    }
    
    @IBAction func submitAction(sender: AnyObject) {
        
        self.showHud("Loading...")
        
        if formValidation() {
        let params = [
            "token":token,
            "device_id":"1234",
            "password":String(changePassword.text!),
            "confirm":String(confirmPassword.text!)
        ]
        
        print(params)
        
        ServerManager.sharedInstance().chPasswordChange(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.hideHud()
                self.toastViewWithNavigation("Password successfully changed", identifierString: "CHMainMenu")
            }else{
                self.hideHud()
            }
          }
        }else{
            self.hideHud()
        }
        
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
