//
//  NewVendorDetailsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 16/12/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class NewVendorDetailsViewController: UIViewController  , DropperDelegate{

    @IBOutlet weak var firstNameLabel: UITextField!
    
    @IBOutlet weak var lastNameLabel: UITextField!
    
    @IBOutlet weak var dateOfBirthField: TextField!

    @IBOutlet weak var displayNameLabel: UITextField!
    
    @IBOutlet weak var mobileNoLabel: TextField!
    
    @IBOutlet weak var emailField: TextField!
    
    @IBOutlet weak var address1Field: UITextField!
    
    @IBOutlet weak var address2Field: UITextField!
    
    @IBOutlet weak var vendorTypeField: UITextField!
    
    @IBOutlet weak var vendorTypeButton: UIButton!
    
    var vendorType = String()
    var postalcodeString = String()
    var isB2c = String()
    var chVendorGetData = [CHVendorGetData]()
    var postCodeStr = String()
    
    var dropper = Dropper(width: 164, height: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateOfBirthField.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        emailField.setTextFieldStyle(TextFieldStyle.EmailID)
        mobileNoLabel.setTextFieldStyle(TextFieldStyle.MobileNumber)
        vendorType = "Free"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func vendorTypeAction(sender: AnyObject) {
        
        
        
        if dropper.status == .Hidden {
            dropper = Dropper(x: vendorTypeButton.frame.origin.x, y: vendorTypeButton.frame.origin.y + vendorTypeButton.frame.size.height, width: vendorTypeButton.frame.size.width, height: 150)
            dropper.tag = 3
            dropper.items = ["Free" , "Paid"]
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: vendorTypeButton)
        } else {
            dropper.hideWithAnimation(0.1)
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
    
    func formValidation() -> Bool{
        
        if (firstNameLabel.text?.isBlank == true  || address1Field.text?.isBlank == true || address2Field.text?.isBlank == true || lastNameLabel.text?.isBlank == true || mobileNoLabel.text?.isBlank == true || dateOfBirthField.text?.isBlank == true || displayNameLabel.text?.isBlank == true){
            self.hideHud()
            AlertView.alertView("Alert", message: "Field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if !(emailField.isValidEmail(emailField.text!)) && emailField.text != "" {
            self.hideHud()
            AlertView.alertView("Alert", message: "Invalid Mail Id", alertTitle: "OK", viewController: self)
            return false
        }
        
        return true
    }
    
    func DropperSelectedRow(path: NSIndexPath, contents: String) {
        if contents == "Free" {
            vendorType = "Free"
        }else{
            vendorType = "Paid"
        }
    }
    
    @IBAction func generateOTP(sender: AnyObject) {
        
        if formValidation(){
        
        let params:[String:AnyObject] = [
            "token":token,
            "device_id":"1234",
            "seller[address_1]":self.address1Field.text!,
            "seller[address_2]":self.address2Field.text!,
            "seller[dob]":self.dateOfBirthField.text!,
            "seller[email]":self.emailField.text!,
            "seller[firstname]":self.firstNameLabel.text!,
            "seller[lastname]":self.lastNameLabel.text!,
            "seller[nickname]":self.displayNameLabel.text!,
            "seller[telephone]":self.mobileNoLabel.text!,
            "seller[postcode]":postCodeStr,
            "seller[postcode_id]":postalcodeString,
            "seller[rest]":vendorType,
            "seller[zone_id]":self.chVendorGetData[0].zone_id,
            "seller[bus_type]":isB2c,
            "seller[city]":self.chVendorGetData[0].city_name,
            "seller[city_id]":self.chVendorGetData[0].city_id,
            "seller[city_name]":self.chVendorGetData[0].city_name,
            "seller[country_id]":self.chVendorGetData[0].country_id
        ]
        
        print(params)
        
        ServerManager.sharedInstance().addNewVendor(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.toastViewWithNavigation("Vendor Successfully added", identifierString: "CHMainMenu")
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    else{
            self.hideHud()
      }
    }
    
}
