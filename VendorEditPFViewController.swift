//
//  VendorEditPFViewController.swift
//  Sahayyam
//
//  Created by Aman on 9/7/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorEditPFViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var slidemenuButton: UIBarButtonItem!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var descriptionTextview: UITextView!
    
    @IBOutlet weak var companyTextfield: TextField!
    
    @IBOutlet weak var taxNameAndNoView: UITextView!
    
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var address2: UITextView!
    
    @IBOutlet weak var pinccodeTextfield: TextField!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bannerImage: UIImageView!
    
    var imageSelected = 0
    var sellerData = SellerData()
    var isLogin = ""
    var str = ""
    var str1 = ""
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuShow(slidemenuButton, viewcontroller: self)
        // Do any additional setup after loading the view.
        
        tokenCheck()
        imagePicker.delegate = self
        self.showHud("Loading...")
        let params = [
            "token":token ,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().sellerPopulateData(params, completionClosure: {(isSuccessful, error, result) in
            if isSuccessful{
                self.hideHud()
                self.sellerData  = result!
                self.dataInTextField()
                self.hideHud()
            }
        })
        
        if isLogin == "customerDropDown" {
        }else {
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choosImageAction(sender: AnyObject) {
        
        if sender.tag == 0 {
           imageSelected = 1
        }else{
           imageSelected = 2
        }
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .SavedPhotosAlbum
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadImageAction(sender: AnyObject) {
        
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
        
        if imageSelected == 1 {
            self.profileImage.image = image
        }else{
           self.bannerImage.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
            if self.imageSelected == 1 {
            if let image = self.profileImage.image {
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
            }else{
              
                
                if let image = self.bannerImage.image {
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
                                }
                            }
                            
                        })
                    }
                }else{
                    AlertView.alertView("Alert", message: "First choose the image", alertTitle: "OK", viewController: self)
                }
            }
        })
    }
    
    
    func formValidation() -> Bool{
//        if (displayName.text?.isBlank == true  || descriptionTextview.text?.isBlank == true || companyTextfield.text?.isBlank == true || taxNameAndNoView.text?.isBlank == true || address.text?.isBlank == true || address2.text?.isBlank == true || cityLabel.text?.isBlank == true ||  regionLabel.text?.isBlank == true || countryLabel.text?.isBlank == true || pinccodeTextfield.text?.isBlank == true) {
//            AlertView.alertView("Alert", message: "Field cannot be left blank", alertTitle: "OK", viewController: self)
//            return false
//        }
        return true        
    }
    
    
    func dataInTextField(){
    
        displayName.text = sellerData.name
        descriptionTextview.text = sellerData.descriptionDetails
        companyTextfield.text = sellerData.companyName
        taxNameAndNoView.text = sellerData.taxnote + sellerData.taxnote_show
        address.text = sellerData.address_1
        address2.text = sellerData.address_2
        cityLabel.text = sellerData.city
        regionLabel.text = sellerData.stateName
        countryLabel.text = sellerData.country
        pinccodeTextfield.text = sellerData.postcode
        if sellerData.bannerImageString != "" {
            let image = sellerData.bannerImageString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            bannerImage.imageFromUrl(image_base_url + image)
        }
        if sellerData.avatar != "" {
            let image = sellerData.avatar.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            profileImage.imageFromUrl(image_base_url + image)
        }
    }
    
    
    @IBAction func saveProfileAction(sender: AnyObject) {
        self.view.endEditing(true)
        //self.showHud("Loading...")
        
        if Reachability.isConnectedToNetwork() {
            if formValidation() {
                
                let params:[String:AnyObject]? = [
                    "token":token,
                    "device_id":"1234",
                    "action":"",
                    "seller[address_1]":address.text!,
                    "seller[address_2]":address2.text!,
                    "seller[avatar_name]":str,
                    "seller[banner_name]":str1,
                    "seller[city_id]":cityLabel.text!,
                    "seller[company]":companyTextfield.text!,
                    "seller[country]":countryLabel.text!,
                    "seller[paypal]":"",
                    "seller[postcode]":pinccodeTextfield.text!,
                    "seller[taxnote]":"sdf",
                    "seller[taxnote_show]":"sdf",
                    "seller[zone]":regionLabel.text!,
                    "seller[description]":""
                ]
                
                ServerManager.sharedInstance().sellerInfoSave(params) { (isSuccessful, error, result) in
                    if isSuccessful{
                        self.hideHud()
                        let alertController = UIAlertController(title: "Alert", message: "Profile Saved", preferredStyle: .Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                            
                        }))
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                    else{
                        
                    }
                }
            }else{
                self.hideHud()
                AlertView.alertView("Alert", message: "Invalid Form", alertTitle: "OK" , viewController: self)
            }
        }
        else{
            self.hideHud()
            AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
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
