//
//  LoginViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import M13Checkbox
import SendOTPFramework

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var usernameTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var loginButton: Button!
    @IBOutlet weak var checkBoxView: M13Checkbox!
    var customerLoginData:CustomerLoginData!

   // MARK: - View Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

        
    }

    override func viewWillAppear(animated: Bool) {
     self.navigationController?.navigationBarHidden = true
    }

    override func viewDidDisappear(animated: Bool) {
       self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: Actions

    @IBAction func loginbutton(sender: AnyObject) {
        self.showHud("Loading...")

       if (usernameTextField.text?.isPhoneNumber  == true && usernameTextField.text?.isBlank == false) && (passwordTextField.text?.isBlank == false){
        
            if Reachability.checkInternetConnectivity() {
            ServerManager.sharedInstance().requestUserLoginWithCredential(usernameTextField.text, passWord: passwordTextField.text, completionClosure: { (isSuccessful, error, result) in
                if (isSuccessful) {
                    self.customerLoginData = result!
                    token = self.customerLoginData.cookie
                    NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
                    print(token)
                    customerType =  self.customerLoginData.cust_type
                    NSUserDefaults.standardUserDefaults().setInteger(customerType, forKey: "customerType")
                    profileType =  self.customerLoginData.profileType
                    NSUserDefaults.standardUserDefaults().setInteger(profileType, forKey: "profileType")
                    profile = self.customerLoginData.profile.boolValue
                    NSUserDefaults.standardUserDefaults().setBool(profile, forKey: "profile")
                    
                    self.checkBoxState()
                    self.hideHud()
                    switch profile{
                    case true:
                        switch customerType{
                        case 1:   
                            self.viewControllerPassing("Customer")
                        case 2:
                            self.viewControllerPassing("Customer")
                        default:
                            print("")
                        }
                    case false:
                        switch customerType{
                            case 0:
                                switch profileType{
                                case 1:
                                    self.performSegueWithIdentifier("gotoSwitchUser", sender: nil)
                                case 2:                                 self.performSegueWithIdentifier("gotoSwitchUser", sender: nil)
                                case 3:
                                    self.performSegueWithIdentifier("gotoSwitchUser", sender: nil)
                                default:
                                print("")
                        }
                            case 1:
                                self.self.viewControllerPassing("Customer")
                            case 2:
                                self.viewControllerPassing("Vendor")
                            case 3:
                                self.viewControllerPassing("CityHead")
                            default:
                            print("")
                        }
                    }
                }else{
                    self.hideHud()
                    self.checkBoxState()
                    AlertView.alertView("Alert", message: "Incorrect Username or password ", alertTitle: "OK" , viewController: self)
                    
            }
            })
                
            }else{
                    self.hideHud()
                    self.checkBoxState()
                    AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
            }
        }
            else{
            self.hideHud()
            AlertView.alertView("Alert", message: "Invalid username or password", alertTitle: "OK" , viewController: self)
            }

    }
    
    @IBAction func forgotPasswordAction(sender: AnyObject) {
        performSegueWithIdentifier("goToForgotPassword", sender: nil)
    }

    //  MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if segue.identifier == "gotoSwitchUser"{
        let vc = segue.destinationViewController as? SwitchUserViewController
        vc!.customerLoginData = self.customerLoginData
       }
    }

    // MARK: - Custom Functions

    func viewControllerPassing(storyBoard:String) {
        let sb = UIStoryboard(name: storyBoard, bundle: nil)
        let vc1 = sb.instantiateInitialViewController()! as UIViewController
        self.navigationController?.pushViewController(vc1, animated: true)
    }

    func setUpView() {
          hideBackBarButton()

//      self.usernameTextField.text = "9372736393"
//      self.passwordTextField.text = "edit"

        usernameTextField.setTextFieldStyle(TextFieldStyle.TextFieldUserName)
        passwordTextField.setTextFieldStyle(TextFieldStyle.TextFieldPassword)

        usernameTextField.text =  NSUserDefaults.standardUserDefaults().objectForKey("username") as? String
        passwordTextField.text =  NSUserDefaults.standardUserDefaults().objectForKey("password") as? String

        if (usernameTextField.text?.isBlank == false && passwordTextField.text?.isBlank == false ) {
            checkBoxView.checkState = .Checked
        }
        

        
    }

    func checkBoxState(){
        if let state = self.checkBoxView?.checkState {
            switch state {
            case .Unchecked:
                isChecked = false
                NSUserDefaults.standardUserDefaults().removeObjectForKey("username")
                NSUserDefaults.standardUserDefaults().removeObjectForKey("password")
                NSUserDefaults.standardUserDefaults().setBool(isChecked  , forKey: "isChecked")
            case .Checked:
                isChecked = true
                NSUserDefaults.standardUserDefaults().setObject(self.usernameTextField.text, forKey: "username")
                NSUserDefaults.standardUserDefaults().setObject(self.passwordTextField.text, forKey: "password")
                NSUserDefaults.standardUserDefaults().setBool(isChecked  , forKey: "isChecked")
            case .Mixed:
               print("")
            }
        }
    }
    
    // MARK: - Navigation
    
    
    

}



