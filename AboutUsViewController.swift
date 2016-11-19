//
//  AboutUsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 05/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var slidemenuButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addresstextField: TextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var messageTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideMenuShow(slidemenuButton, viewcontroller: self)
        revealTouch(self)
        addresstextField.setTextFieldStyle(TextFieldStyle.EmailID)
        
       // setBackButtonForNavigation()
        tokenCheck()
        
        // changeNavigationBarColor()
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
    @IBAction func sendEmailAction(sender: AnyObject) {
        
        self.showHud("Loading...")
        if formValidation() {
        let params = [
            "token":token,
            "device_id":"1234",
            "name":nameTextField.text,
            "email":addresstextField.text,
            "email_subject":emailTextField.text,
            "message":messageTextField.text
        ]
        
        print(params)
        
        ServerManager.sharedInstance().vendorAboutUs(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.toastViewWithNavigation("Email sent successfully", identifierString: "VendorListID")
                self.hideHud()
            }else{
              self.hideHud()  
            }
        }
        } else {
          self.hideHud()
        }
        
    }
    
    func formValidation() -> Bool {
        if nameTextField.text?.characters.count == 0 {
            AlertView.alertView("Alert", message: "Name field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if addresstextField.text?.characters.count == 0 {
            AlertView.alertView("Alert", message: "Email Id field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
//        if emailTextField.text?.characters.count == 0 {
//            AlertView.alertView("Alert", message: "email Field cannot be left blank", alertTitle: "OK", viewController: self)
//            return false
//        }
        
        if messageTextField.text?.characters.count == 0 {
            AlertView.alertView("Alert", message: "Message field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if !(addresstextField.isValidEmail(addresstextField.text!)) {
            self.hideHud()
            AlertView.alertView("Alert", message: "Invalid Mail Id", alertTitle: "OK", viewController: self)
            return false
        }
        
        
       return true
    }
    

}
