//
//  CustomerUpdateProfileViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 02/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerUpdateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
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
    
    var isLogin = ""
    let imagePicker = UIImagePickerController()
    
    var populateDataList = PopulateData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tokenCheck()
        
        if isLogin == "customerDropDown" {
            ServerManager.sharedInstance().customerUpdateProfilePopulateData(nil, completionClosure: {(isSuccessful, error, result) in
                if isSuccessful{
                    self.populateDataList  = result!
                    self.dataInTextField()
                    self.hideHud()
                }
            })
        }else {
            
        }
        
        self.showHud("Loading...")
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
    
    @IBAction func uploadImageAction(sender: AnyObject) {
        
        //      print(convertImageToBase64(customerImage.image!))
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
    }
    
    @IBAction func uploadCustomerProfileAction(sender: AnyObject) {
        self.view.endEditing(true)
    
        self.showHud("Loading...")
        
        if formValidation() {
            let params:[String:AnyObject]? = [
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
            
            print(params)
            
            ServerManager.sharedInstance().customerUpdateProfile(params) { (isSuccessful, error, result) in
                self.hideHud()
                
                let alertController = UIAlertController(title: "Alert", message: "Profile Updated", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                    self.navigationController?.popViewControllerAnimated(true)
                }))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        else{
            self.hideHud()
            AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
        }
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
            AlertView.alertView("Alert", message: "Field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if !(emailIdTextField.isValidEmail(emailIdTextField.text!)) && emailIdTextField.text != "" {
            AlertView.alertView("Alert", message: "Invalid Mail Id", alertTitle: "OK", viewController: self)
            return false
        }
        
        if !(Validations.isValidPassAndConfirmPassword(passwordTextField.text! , confirmPassword: confirmPassword.text!)) {
            AlertView.alertView("Alert", message: "Password and confirm password do not match", alertTitle: "OK", viewController: self)
            return false
        }
        return true
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
}

