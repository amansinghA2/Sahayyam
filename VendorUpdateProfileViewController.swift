//
//  VendorUpdateProfileViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 02/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorUpdateProfileViewController: UIViewController {

    @IBOutlet weak var slidemenuButton: UIBarButtonItem!
    @IBOutlet weak var firstName: TextField!
    @IBOutlet weak var lastName: TextField!
    @IBOutlet weak var dobTextField: TextField!
    @IBOutlet weak var emailID: TextField!
    @IBOutlet weak var mobileNumber: TextField!
    @IBOutlet weak var passwordtextfield: TextField!
    @IBOutlet weak var confirmPasswordtextField: TextField!
    var populateDataList = PopulateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuShow(slidemenuButton, viewcontroller: self)
        dobTextField.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        passwordtextfield.setTextFieldStyle(TextFieldStyle.TextFieldPassword)
        confirmPasswordtextField.setTextFieldStyle(TextFieldStyle.TextFieldPassword)
        firstName.setTextFieldStyle(TextFieldStyle.TextfieldNames)
        lastName.setTextFieldStyle(TextFieldStyle.TextfieldNames)
        mobileNumber.setTextFieldStyle(TextFieldStyle.MobileNumber)
        
        ServerManager.sharedInstance().customerUpdateProfilePopulateData(nil, completionClosure: {(isSuccessful, error, result) in
            if isSuccessful{
                self.populateDataList  = result!
                self.dataInTextField()
                self.hideHud()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateProfileAction(sender: AnyObject) {
        
        
        
    }
    
    func formValidation() -> Bool{
        if (firstName.text?.isBlank == true  || lastName.text?.isBlank == true || dobTextField.text?.isBlank == true || mobileNumber.text?.isBlank == true || passwordtextfield.text?.isBlank == true || confirmPasswordtextField.text?.isBlank == true){
            AlertView.alertView("Alert", message: "Field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if !(emailID.isValidEmail(emailID.text!)) && emailID.text != "" {
            AlertView.alertView("Alert", message: "Invalid Mail Id", alertTitle: "OK", viewController: self)
            return false
        }
        
        if !(Validations.isValidPassAndConfirmPassword(passwordtextfield.text! , confirmPassword: confirmPasswordtextField.text!)) {
            AlertView.alertView("Alert", message: "Password and confirm password do not match", alertTitle: "OK", viewController: self)
            return false
        }
        return true
    }
    
    func dataInTextField(){
        
        firstName.text = populateDataList.firstname
        
        lastName.text = populateDataList.lastName
        
        dobTextField.text = populateDataList.dateOfBirth
        
        emailID.text = populateDataList.emailId
        
        mobileNumber.text = populateDataList.mobileNumber
        
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
