//
//  CustomerUpdateProfileViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 02/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import M13Checkbox
import TTTAttributedLabel

class CustomerUpdateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , TTTAttributedLabelDelegate{

    @IBOutlet weak var updateButtonOutlet: Button!
    @IBOutlet weak var acceptCheckbox: M13Checkbox!
    
    @IBOutlet weak var acceptLabel: TTTAttributedLabel!
    @IBOutlet weak var customerImage: UIImageView!
    @IBOutlet weak var firstNameLabel: TextField!
    @IBOutlet weak var lastNameLabel: TextField!
    @IBOutlet weak var mobileNumberLabel: TextField!
    @IBOutlet weak var dateOfBirthTextField: TextField!
    @IBOutlet weak var addressTextField: TextField!
    @IBOutlet weak var emailIdTextField: TextField!
    @IBOutlet weak var cityTextField: TextField!
    @IBOutlet weak var countryTextField: TextField!
    @IBOutlet weak var stateTextField: TextField!
    @IBOutlet weak var pincodeTextfield: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var confirmPassword: TextField!
    var str = ""
    var isAccept = false
    
    var isLogin = ""
    let imagePicker = UIImagePickerController()
    
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
         ServerManager.sharedInstance().customerUpdateProfilePopulateData(nil, completionClosure: {(isSuccessful, error, result) in
                if isSuccessful{
                    self.populateDataList  = result!
                    self.dataInTextField()
                    self.acceptLabel.hidden = true
                    self.acceptCheckbox.hidden = true
                    self.hideHud()
                }
            })
        }else {
            profile = false
//            customerType = 0
//            profileType = 1
//
//            NSUserDefaults.standardUserDefaults().setInteger(customerType, forKey: "customerType")
//            NSUserDefaults.standardUserDefaults().setInteger(profileType, forKey: "profileType")
            NSUserDefaults.standardUserDefaults().setBool(profile, forKey: "profile")
            
            self.acceptLabel.hidden = false
            acceptCheckbox.hidden = false
            
        }
        
        setBackButtonForNavigation()
        //changeNavigationBarColor()
        
        imagePicker.delegate = self
        dateOfBirthTextField.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        passwordTextField.setTextFieldStyle(TextFieldStyle.TextFieldPassword)
        confirmPassword.setTextFieldStyle(TextFieldStyle.TextFieldPassword)
        firstNameLabel.setTextFieldStyle(TextFieldStyle.TextfieldNames)
        lastNameLabel.setTextFieldStyle(TextFieldStyle.TextfieldNames)
        mobileNumberLabel.setTextFieldStyle(TextFieldStyle.MobileNumber)
        pincodeTextfield.setTextFieldStyle(TextFieldStyle.Pincode)
        
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
    
    @IBAction func choosImageAction(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .SavedPhotosAlbum
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func removeButtonAction(sender: AnyObject) {

        self.customerImage.image = nil
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
                "address[0][address_1]":addressTextField.text!,
                "address[0][zone_id]":stateTextField.text!,
                "address[0][city]":cityTextField.text!,
                "address[0][postcode]":pincodeTextfield.text!,
                "image":self.str
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
                "address[0][address_1]":addressTextField.text!,
                "address[0][zone_id]":stateTextField.text!,
                "address[0][city]":cityTextField.text!,
                "address[0][postcode]":pincodeTextfield.text!,
                "image":self.str,
                "tos":"on"
            ]

        }

        print(params)
        
        self.view.endEditing(true)
        if Reachability.isConnectedToNetwork() {
        if formValidation() {
            ServerManager.sharedInstance().customerUpdateProfile(params) { (isSuccessful, error, result) in
                self.hideHud()
                
                let alertController = UIAlertController(title: "Alert", message: "Profile Updated", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                     if self.isLogin == "customerDropDown" {
                    self.navigationController?.popViewControllerAnimated(true)
                     }else{
                       self.viewControllerPassing("Customer")
                     }
                }))
                self.presentViewController(alertController, animated: true, completion: nil)
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
        //       vc1.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        // vc1.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.presentViewController(vc1, animated: false, completion:
            nil)
    }
    
    func convertImageToBase64(image: UIImage) -> String {
        let image = customerImage.image!.resizeWith(80.0, height: 80.0)
        let imageData = UIImageJPEGRepresentation(image!, 1.0)
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        return base64String
    }
    
    func convertBase64ToImage(base64String: String) -> UIImage {
        
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))
        let decodedimage = UIImage(data: decodedData!)
        return decodedimage!
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.customerImage.image = image
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            if let image = self.customerImage.image {
                self.showHud("Loading...")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    let params:[String:AnyObject] = [
                        "file":self.convertImageToBase64(image),
                        "flag":1,
                        "token":token,
                        "device_id":"1234"
                    ]

                    dispatch_async(dispatch_get_main_queue(), {
                        ServerManager.sharedInstance().customerUploadImage(params) { (isSuccessful, error, result) in
                            if isSuccessful{
                                self.hideHud()
                                if let imgStr = result!["img_dir"]{
                                    self.str = (imgStr as! String)
                                }
                            }
                        }

                    })
                }
            }else{
                AlertView.alertView("Alert", message: "First choose the image", alertTitle: "OK", viewController: self)
            }

        })
    }
    
    //  MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    //    In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //    }
    
    func formValidation() -> Bool{
        if (firstNameLabel.text?.isBlank == true  || lastNameLabel.text?.isBlank == true || dateOfBirthTextField.text?.isBlank == true || mobileNumberLabel.text?.isBlank == true || passwordTextField.text?.isBlank == true || confirmPassword.text?.isBlank == true || addressTextField.text?.isBlank == true ||  cityTextField.text?.isBlank == true || pincodeTextfield.text?.isBlank == true){
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
        stateTextField.text = populateDataList.stateName
        pincodeTextfield.text = populateDataList.pincode
        countryTextField.text = populateDataList.country
        cityTextField.text = populateDataList.cityName
        addressTextField.text = populateDataList.address
        dateOfBirthTextField.text = populateDataList.dateOfBirth
        
        if populateDataList.image1 != "" {
          let image = populateDataList.image1.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
              customerImage.imageFromUrl(image_base_url + image)
        }
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

