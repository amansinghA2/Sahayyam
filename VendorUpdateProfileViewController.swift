//  CustomerUpdateProfileViewController.swift
//  Sahayyam
//  Created by Sanjeev Jikamade on 02/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.

import UIKit
import M13Checkbox
import TTTAttributedLabel

class VendorUpdateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , TTTAttributedLabelDelegate{

    @IBOutlet weak var slidemenuButton: UIBarButtonItem!
    @IBOutlet weak var updateButtonOutlet: Button!
    @IBOutlet weak var acceptCheckbox: M13Checkbox!
    @IBOutlet weak var acceptLabel: TTTAttributedLabel!
    @IBOutlet weak var firstNameLabel: TextField!
    @IBOutlet weak var lastNameLabel: TextField!
    @IBOutlet weak var mobileNumberLabel: TextField!
    @IBOutlet weak var dateOfBirthTextField: TextField!
    @IBOutlet weak var emailIdTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var confirmPassword: TextField!
    var isAccept = false
    
    var isLogin = ""
    var mTos = ""
    
    var populateDataList = PopulateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str : NSString = "Accept the terms and conditions"
        acceptLabel.delegate = self
        acceptLabel.text = str as String
        let range : NSRange = str.rangeOfString("Accept the terms and conditions")
        acceptLabel.addLinkToURL(NSURL(string: BASE_URL + "/tos/terms.html")!, withRange: range)
        acceptLabel.textColor = UIColor.blueColor()
        if isLogin == "customerDropDown" {
            tokenCheck()
            self.acceptLabel.hidden = true
            self.acceptCheckbox.hidden = true
            mobileNumberLabel.userInteractionEnabled = false
            slideMenuShow(slidemenuButton, viewcontroller: self)
            ServerManager.sharedInstance().customerUpdateProfilePopulateData(nil, completionClosure: {(isSuccessful, error, result , result1) in
                if isSuccessful{
                    
                    if let tos = result1!["TOS"] as? String{
                       self.mTos = tos
                    }
                    
                    self.hideHud()
                    self.populateDataList  = result!
                    customerFullName = self.populateDataList.firstname + " " + self.populateDataList.lastName
                    NSUserDefaults.standardUserDefaults().setObject(customerFullName, forKey: "customerFullName")
                    self.dataInTextField()
                    self.hideHud()
                }else{
                    self.hideHud()
                }
            })
        }else {
            profile = false
            NSUserDefaults.standardUserDefaults().setBool(profile, forKey: "profile")
            setBackButtonForNavigation()
            ServerManager.sharedInstance().customerUpdateProfilePopulateData(nil, completionClosure: {(isSuccessful, error, result , result1) in
                if isSuccessful{
                    self.hideHud()
                    
                    if let tos = result1!["TOS"] as? String{
                        self.mTos = tos
                    }
                    
                    self.populateDataList  = result!
                    customerFullName = self.populateDataList.firstname + " " + self.populateDataList.lastName
                    NSUserDefaults.standardUserDefaults().setObject(customerFullName, forKey: "customerFullName")
                    self.dataInTextField()
                    self.hideHud()
                }else{
                    self.hideHud()
                }
            })
            self.acceptLabel.hidden = false
            acceptCheckbox.hidden = false
        }

        dateOfBirthTextField.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        passwordTextField.setTextFieldStyle(TextFieldStyle.TextFieldPassword)
        confirmPassword.setTextFieldStyle(TextFieldStyle.TextFieldPassword)
        firstNameLabel.setTextFieldStyle(TextFieldStyle.TextfieldNames)
        lastNameLabel.setTextFieldStyle(TextFieldStyle.TextfieldNames)
        mobileNumberLabel.setTextFieldStyle(TextFieldStyle.MobileNumber)
        
        // dataInTextField()
        
    }
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!) {
        UIApplication.sharedApplication().openURL(url)
    }
    
    func bindModelToViews() {
        
        //      dataInTextField()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func uploadCustomerProfileAction(sender: AnyObject) {
        
        checkBoxState()
        
        let params:[String:AnyObject]?
        if isLogin == "customerDropDown" {
            params = [
                "token":token,
                "device_id":"1234",
                "action":"info",
                "firstname":firstNameLabel.text!,
                "lastname":lastNameLabel.text!,
                "dob":dateOfBirthTextField.text!,
                "email":emailIdTextField.text!,
                "telephone":mobileNumberLabel.text!,
                "password":passwordTextField.text!,
                "confirm":confirmPassword.text!,
            ]
        }else{
            params = [
                "token":token,
                "device_id":"1234",
                "action":"info",
                "firstname":firstNameLabel.text!,
                "lastname":lastNameLabel.text!,
                "dob":dateOfBirthTextField.text!,
                "email":emailIdTextField.text!,
                "telephone":mobileNumberLabel.text!,
                "password":passwordTextField.text!,
                "confirm":confirmPassword.text!,
                "tos":"on"
            ]
        }
        
        print(params)
        
        self.view.endEditing(true)
        if Reachability.isConnectedToNetwork() {
            if formValidation() {
                ServerManager.sharedInstance().customerUpdateProfile(params) { (isSuccessful, error, result) in
                    if isSuccessful {
//                        ServerManager.sharedInstance().customerUpdateProfilePopulateData(nil, completionClosure: {(isSuccessful, error, result) in
//                            if isSuccessful{
//                                self.hideHud()
//                                self.populateDataList  = result!
//                                customerFullName = self.populateDataList.firstname + " " + self.populateDataList.lastName
//                                NSUserDefaults.standardUserDefaults().setObject(customerFullName, forKey: "customerFullName")
//                                self.hideHud()
//                            }else{
//                                self.hideHud()
//                            }
//                        })
                    let alertController = UIAlertController(title: "Alert", message: "Profile Updated", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                       self.viewControllerPassing("Vendor")
                    }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                    }
                }
            }else{
                
            }
        }
        else{
            self.hideHud()
            AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
        }
        
    }
    
    func viewControllerPassing(storyBoard:String) {
        let sb = UIStoryboard(name: storyBoard, bundle: nil)
        let vc1 = sb.instantiateInitialViewController()! as UIViewController
        self.presentViewController(vc1, animated: false, completion:
            nil)
    }
    
    //  MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    //    In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //    }
    
    func formValidation() -> Bool{
        if (firstNameLabel.text?.isBlank == true  || lastNameLabel.text?.isBlank == true || dateOfBirthTextField.text?.isBlank == true || mobileNumberLabel.text?.isBlank == true || passwordTextField.text?.isBlank == true || confirmPassword.text?.isBlank == true ){
            self.hideHud()
            AlertView.alertView("Alert", message: "Field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if !(emailIdTextField.isValidEmail(emailIdTextField.text!)) && emailIdTextField.text != "" {
            self.hideHud()
            AlertView.alertView("Alert", message: "Invalid Mail Id", alertTitle: "OK", viewController: self)
            return false
        }
        
        if !(Validations.isValidPassAndConfirmPassword(passwordTextField.text! , confirmPassword: confirmPassword.text!)) {
            self.hideHud()
            AlertView.alertView("Alert", message: "Password and confirm password do not match", alertTitle: "OK", viewController: self)
            return false
        }
        
        if isLogin == "customerDropDown" {
            return true
        }else{
            if isAccept == false {
                AlertView.alertView("Alert", message: "Didn't accept the aggrement", alertTitle: "OK", viewController: self)
                return false
            }else{
                return true
            }
        }
    }
    
    func dataInTextField(){
        firstNameLabel.text = populateDataList.firstname
        lastNameLabel.text = populateDataList.lastName
        mobileNumberLabel.text = populateDataList.mobileNumber
        dateOfBirthTextField.text = populateDataList.dateOfBirth
        emailIdTextField.text = populateDataList.emailId
        dateOfBirthTextField.text = populateDataList.dateOfBirth
        
    }
    
    func checkBoxState(){
        if let state = self.acceptCheckbox?.checkState {
            switch state {
            case .Unchecked:
                isChecked = false
                isAccept = false
            case .Checked:
                isChecked = true
                updateButtonOutlet.hidden = false
                isAccept = true
            case .Mixed:
                print("")
            }
        }
    }
    
}

