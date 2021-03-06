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
import Dropper

class CustomerUpdateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , TTTAttributedLabelDelegate , DropperDelegate , UIGestureRecognizerDelegate{

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
    var str1 = ""
    var isAccept = false
    var mTos = ""
    var isLogin = ""
    var isImageCount = 0
    let imagePicker = UIImagePickerController()
    var proofIdCode = ""
    
    @IBOutlet weak var idProfileImage: UIImageView!
    
    
    @IBOutlet weak var selectIdButton: UIButton!
    
    var populateDataList = PopulateData()
    var dropper = Dropper(width: 150, height: 150)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mobileNumberLabel.userInteractionEnabled = false
        let str : NSString = "Accept the terms and conditions"
        acceptLabel.delegate = self
        acceptLabel.text = str as String
        let range : NSRange = str.rangeOfString("Accept the terms and conditions")
        acceptLabel.addLinkToURL(NSURL(string: BASE_URL + "/tos/terms.html")!, withRange: range)
        acceptLabel.textColor = UIColor.blueColor()
        self.showHud("Loading...")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CustomerUpdateProfileViewController.dismissKeyboard))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        if isLogin == "customerDropDown" {
            tokenCheck()
         ServerManager.sharedInstance().customerUpdateProfilePopulateData(nil, completionClosure: {(isSuccessful, error, result , result1) in
                if isSuccessful{
                    self.hideHud()
                    self.populateDataList  = result!
                    
                    if let tos = result1!["TOS"] as? String{
                        self.mTos = tos
                    }
                    
                    customerFullName = self.populateDataList.firstname + " " + self.populateDataList.lastName
                    NSUserDefaults.standardUserDefaults().setObject(customerFullName, forKey: "customerFullName")
                    
                    self.dataInTextField()
                    self.acceptLabel.hidden = true
                    self.acceptCheckbox.hidden = true
                    self.hideHud()
                }else{
                    self.hideHud()
            }
            })
        }else {
            self.hideHud()
            
            ServerManager.sharedInstance().customerUpdateProfilePopulateData(nil, completionClosure: {(isSuccessful, error, result , result1) in
                if isSuccessful{
                    self.hideHud()
                    self.populateDataList  = result!
                    self.mobileNumberLabel.text = self.populateDataList.mobileNumber
                    self.hideHud()
                }else{
                    self.hideHud()
                }
            })
            
//            customerType = 0
//            profileType = 1
//
//            NSUserDefaults.standardUserDefaults().setInteger(customerType, forKey: "customerType")
//            NSUserDefaults.standardUserDefaults().setInteger(profileType, forKey: "profileType")
 

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
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if CGRectContainsPoint(self.dropper.bounds, touch.locationInView(dropper)){
            return false
        }else{
            return true
        }
    }
    
    override func dismissKeyboard() {
        self.view.endEditing(true)
        dropper.hideWithAnimation(0.1)
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
        
        if sender.tag == 1{
            isImageCount = 1
        }else if sender.tag == 2{
            isImageCount = 2
        }
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .SavedPhotosAlbum
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func removeButtonAction(sender: AnyObject) {
        if sender.tag == 3 {
            str = ""
           self.customerImage.image = UIImage(named: "v_no_image")
        }else if sender.tag == 4{
            str1 = ""
           self.idProfileImage.image = UIImage(named: "v_no_image")
            selectIdButton.setTitle("--Select Type--", forState: .Normal)
            proofIdCode = ""
        }
    }
    
    @IBAction func uploadCustomerProfileAction(sender: AnyObject) {

        checkBoxState()
        self.showHud("Loading...")
        let params:[String:AnyObject]?
        if self.mTos == "0"{
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
                "image_path":str1,
                "selected_id_proof":proofIdCode,
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
                            "image_path":str1,
                            "selected_id_proof":proofIdCode,
                            "tos":"on"
                        ]
            profile = false
            NSUserDefaults.standardUserDefaults().setBool(profile, forKey: "profile")
        }
        
        print(params)
        
//        let params:[String:AnyObject]?
//        if isLogin == "customerDropDown" {
//            params = [
//                "token":token,
//                "device_id":"1234",
//                "action":"info",
//                "firstname":firstNameLabel.text!,
//                "lastname":lastNameLabel.text!,
//                "dob":dateOfBirthTextField.text!,
//                "email":emailIdTextField.text!,
//                "telephone":mobileNumberLabel.text!,
//                "password":passwordTextField.text!,
//                "confirm":confirmPassword.text!,
//                "address[0][address_1]":addressTextField.text!,
//                "address[0][zone_id]":stateTextField.text!,
//                "address[0][city]":cityTextField.text!,
//                "address[0][postcode]":pincodeTextfield.text!,
//                "image":self.str
//            ]
//        }else{
//           params = [
//                "token":token,
//                "device_id":"1234",
//                "action":"info",
//                "firstname":firstNameLabel.text!,
//                "lastname":lastNameLabel.text!,
//                "dob":dateOfBirthTextField.text!,
//                "email":emailIdTextField.text!,
//                "telephone":mobileNumberLabel.text!,
//                "password":passwordTextField.text!,
//                "confirm":confirmPassword.text!,
//                "address[0][address_1]":addressTextField.text!,
//                "address[0][zone_id]":stateTextField.text!,
//                "address[0][city]":cityTextField.text!,
//                "address[0][postcode]":pincodeTextfield.text!,
//                "image":self.str,
//                "tos":"on"
//            ]
//
//        }

        print(params)
        
        self.view.endEditing(true)
        if Reachability.isConnectedToNetwork() {
        if formValidation() {
            ServerManager.sharedInstance().customerUpdateProfile(params) { (isSuccessful, error, result) in
                
                if isSuccessful {
                self.hideHud()
                let alertController = UIAlertController(title: "Alert", message: "Profile Updated", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                     if self.isLogin == "customerDropDown" {
                        ServerManager.sharedInstance().customerUpdateProfilePopulateData(nil, completionClosure: {(isSuccessful, error, result , result1) in
                            if isSuccessful{
                                self.hideHud()
                                self.populateDataList  = result!
                                customerFullName = self.populateDataList.firstname + " " + self.populateDataList.lastName
                                NSUserDefaults.standardUserDefaults().setObject(customerFullName, forKey: "customerFullName")
                            }
                        })

                        self.navigationController?.popViewControllerAnimated(true)
                     }else{
                       self.hideHud()
                       self.viewControllerPassing("Customer")
                     }
                }))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
                else{
                    AlertView.alertViewWithPopup("Alert", message: error!, alertTitle: "OK", viewController: self)
                        self.hideHud()
                }
            }
        }else{
            self.hideHud()
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
    
    func convertImageToBase64(image: UIImage) -> String {
        let image = image.resizeWith(80.0, height: 80.0)
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
        
        if isImageCount == 1 {
            self.customerImage.image = image
        }else{
            self.idProfileImage.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
            if self.isImageCount == 1 {
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
                                }else{
                                    self.hideHud()
                                }
                            }
                            
                        })
                    }
                }else{
                    self.hideHud()
                    AlertView.alertView("Alert", message: "First choose the image", alertTitle: "OK", viewController: self)
                }
            }else{
                if let image = self.idProfileImage.image {
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
                                        self.str1 = (imgStr as! String)
                                    }
                                }else{
                                    self.hideHud()
                                }
                            }
                            
                        })
                    }
                }else{
                    self.hideHud()
                    AlertView.alertView("Alert", message: "First choose the image", alertTitle: "OK", viewController: self)
                }
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
        
//        if !(firstNameLabel.text?.characters.count > 1 && firstNameLabel.text?.characters.count < 32) {
//            self.hideHud()
//            AlertView.alertView("Alert", message: "Invalid First Name", alertTitle: "OK", viewController: self)
//            return false
//        }
//        
//        if !(lastNameLabel.text?.characters.count > 1 && lastNameLabel.text?.characters.count < 32) {
//            self.hideHud()
//            AlertView.alertView("Alert", message: "Invalid Last Name", alertTitle: "OK", viewController: self)
//            return false
//        }
        
        if !(Validations.isValidPassAndConfirmPassword(passwordTextField.text! , confirmPassword: confirmPassword.text!)) {
            self.hideHud()
            AlertView.alertView("Alert", message: "Password and confirm password do not match", alertTitle: "OK", viewController: self)
            return false
        }
        
        if proofIdCode == "" && str1 != "" {
            AlertView.alertView("Alert", message: "Please select the id proof type", alertTitle: "OK", viewController: self)
            return false
        }
        
        if proofIdCode != "" && str1 == "" {
            AlertView.alertView("Alert", message: "Please upload the Image", alertTitle: "OK", viewController: self)
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

        
        for id in populateDataList.id_proof {
            if populateDataList.id_card_type == id.code {
               proofIdCode = id.code.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
               selectIdButton.setTitle("\(id.id_proof_type)", forState: .Normal)
            }
        }
        

        if populateDataList.image1 != "" {
          self.str = populateDataList.image1
          let image = populateDataList.image1.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
              customerImage.imageFromUrl(image_base_url + image)
        }
        
        if populateDataList.id_card != "" {
            self.str1 = populateDataList.id_card
            let image = populateDataList.id_card
            print(image_base_url + image)
            idProfileImage.imageFromUrl(image_base_url + image)
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
    
    
    @IBAction func selectIdButtonAction(sender: AnyObject) {
        
        var subsPakageArray = [String]()

//        for subPackage in self.subInfo.period {
//            subsPakageArray.append(subPackage.name)
//        }
        

        for id in populateDataList.id_proof {
           subsPakageArray.append(id.id_proof_type)
        }
        
        if dropper.status == .Hidden {
            dropper = Dropper(x: selectIdButton.frame.origin.x, y: selectIdButton.frame.origin.y + selectIdButton.frame.size.height, width: selectIdButton.frame.size.width, height: 150)
            dropper.tag = 2
            dropper.items = ["--Select Type--"] + subsPakageArray
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: selectIdButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    
    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {
        if tag == 1 {
            selectIdButton.setTitle("\(contents)", forState: .Normal)
        }else{
             selectIdButton.setTitle("\(contents)", forState: .Normal)
            if contents == "--Select Type--" {
                proofIdCode = ""
            }else{
            for proof in populateDataList.id_proof {
                if contents == proof.id_proof_type {
                   proofIdCode = proof.code
                }
            }
            }
           
        }
    }

}

