//
//  VndornewProductAddViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class VndornewProductAddViewController: UIViewController , UITextFieldDelegate , DropperDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    
     let dropper = Dropper(width: 131, height: 200)
    @IBOutlet weak var manufacturerLabel: UITextField!
    
    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var nameDropDown: UIButton!
    @IBOutlet weak var categoryDropDown: UIButton!
    @IBOutlet weak var unitTypeButton: UIButton!
    @IBOutlet weak var substractStockButton: UIButton!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var serviceLabel: UITextField!
    @IBOutlet weak var categoryLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    @IBOutlet weak var referenceCodeLabel: UITextField!
    @IBOutlet weak var offerPriceLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var unitValueLabel: UITextField!
    @IBOutlet weak var unitTypeLabel: UITextField!
    @IBOutlet weak var quantityLabel: UITextField!
    @IBOutlet weak var substractStockLabel: UITextField!
    @IBOutlet weak var statusLabel: UITextField!
    @IBOutlet weak var productImage: UIImageView!
    let imagePicker = UIImagePickerController()
    var str = ""
    var fromDesc = ""
    var getProductDetails:ProductDetails!
    var statusString = String()
    var serviceLists = [VendorService]()
    var stockLabelString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if fromDesc == "fromDescriptionPage"{
             tokenCheck()
            setBackButtonForNavigation()
            bindModelToViews()
            print(self.getProductDetails)
        }else{
             tokenCheck()
            slideMenuShow(slideMenuButton, viewcontroller: self)
        }


        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let params = [
            "token":token,
            "device_id":"1234",
            "service_id":"",
            "filter_name":""
            ]
        
        ServerManager.sharedInstance().autocompleteCategoryList(params) { (isSuccessful, error, result) in
            if isSuccessful {
                    
            }
        }
        
        let params1 = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().getVendorServices(params1) { (isSuccessful, error, result) in
            if isSuccessful {
                self.serviceLists = result!
            }else{
                self.hideHud()
            }
        }
        
    }
    
    func bindModelToViews() {
        
        if let name = getProductDetails.name as? String{
            nameLabel.text = name
        }
        
        if let name = getProductDetails.manufacturer_id as? Int{
            manufacturerLabel.text = String(name)
        }
        
        if let name = getProductDetails.productCategories as? String{
            categoryLabel.text = name
        }
        
        if let name = getProductDetails.productDescription as? String{
            descriptionLabel.text = name
        }
        
        if let name = getProductDetails.price as? String{
            priceLabel.text = name
        }
        
        if let name = getProductDetails.offerPrice as? String{
            offerPriceLabel.text = name
        }
        
        if let name = getProductDetails.unit as? Int{
            unitTypeLabel.text = String(name)
        }
        
        if let name = getProductDetails.service_id as? String{
            serviceLabel.text = name
        }
        
        if let name = getProductDetails.status as? String{
            
            if name == "0" {
             statusLabel.text = "Disabled"
            }else{
             statusLabel.text = "Enabled"
            }
        }
        
        if let name = getProductDetails.quantity as? String{
            quantityLabel.text = name
        }
        
//        if let name = getProductDetails.name as? String{
//            unitTypeLabel.text = name
//        }
        
        if let name = getProductDetails.image as? String{
            if name == "" {
            productImage.image = UIImage(named: "v_no_image")
            }else{
            productImage.image = UIImage(named: "name")
            }
        }
        
        if let name = getProductDetails.subtract as? String{
            substractStockLabel.text = name
        }
        
        if let name = getProductDetails.ref_code as? String{
            referenceCodeLabel.text = name
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
    
    @IBAction func choosImageAction(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .SavedPhotosAlbum
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadImageAction(sender: AnyObject) {
        
        if let image = self.productImage.image {
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
    
    func convertImageToBase64(image: UIImage) -> String {
        let image = productImage.image!.resizeWith(80.0, height: 80.0)
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
        self.productImage.image = image
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    
    func formValidation() -> Bool{
        if (serviceLabel.text?.isBlank == true  || categoryLabel.text?.isBlank == true || nameLabel.text?.isBlank == true || descriptionLabel.text?.isBlank == true || offerPriceLabel.text?.isBlank == true || referenceCodeLabel.text?.isBlank == true || priceLabel.text?.isBlank == true ||  unitTypeLabel.text?.isBlank == true || unitValueLabel.text?.isBlank == true || quantityLabel.text?.isBlank == true ||  substractStockLabel.text?.isBlank == true || statusLabel.text?.isBlank == true){
            AlertView.alertView("Alert", message: "Field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        return true
    }
    
    @IBAction func saveButton(sender: AnyObject){
        
        if self.fromDesc == "fromDescriptionPage" {
            
            if Reachability.isConnectedToNetwork() {
                if formValidation() {
                    let params: [String:AnyObject] = [
                        "token":token,
                        "device_id":"1234",
                        "manufacturer":manufacturerLabel.text!,
                        "manufacturer_id":"0",
                        "product_category[]":categoryLabel.text!,
                        "product_id":getProductDetails!.product_id,
                        "product_description[1][name]":nameLabel.text!,
                        "product_description[1][description]": descriptionLabel.text!,
                        "image":str,
                        "price":priceLabel.text!,
                        "product_special[0][price]":offerPriceLabel.text!,
                        "weight_class_id":getProductDetails!.weight_class_id,
                        "weight":getProductDetails!.weight,
                        "quantity":quantityLabel.text!,
                        "subtract":substractStockLabel.text!,
                        "status":getProductDetails!.status,
                        "name":nameLabel.text!,
                        "product_description[1][tag]":"",
                        "product_description[1][meta_title]":nameLabel.text!,
                        "product_description[1][meta_description]":"",
                        "product_description[1][meta_keyword]":"",
                        "model":nameLabel.text!,
                        "service_id":serviceLabel.text!,
                        "product_special[0][customer_group_id]":"1",
                        "product_special[0][date_start]":"0000-00-00",
                        "product_special[0][date_end]":"0000-00-00",
                        "product_special[0][priority]":"1",
                        "ref_code":referenceCodeLabel.text!
                    ]
                    
                    print(params)
                    
                    ServerManager.sharedInstance().editProduct(params) { (isSuccessful, error, result) in
                        if isSuccessful {
                            print("Success")
                        }
                    }
                }
                else{
                    self.hideHud()
                    AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
                }
            }
 
        }
        else{
            editOrAddDetails()
         }
   }

    @IBAction func serviceAction(sender: AnyObject) {

        var serviceName = [String]()
        
        for serviceList in serviceLists {
            serviceName.append(serviceList.desc)
        }
        
        if dropper.status == .Hidden {
            dropper.tag = 1
            dropper.items = serviceName
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: nameDropDown)
        } else {
            dropper.hideWithAnimation(0.1)
        }

    }
    
    @IBAction func categoryAction(sender: AnyObject) {

        
        if dropper.status == .Hidden {
            dropper.tag = 2
            dropper.items = [""]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.spacing = 0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options:Dropper.Alignment.Center, button:categoryDropDown)
        } else {
            dropper.hideWithAnimation(0.1)
        }

    }
    
    @IBAction func unitTypeAction(sender: AnyObject) {
        
        if dropper.status == .Hidden {
            dropper.tag = 3
            dropper.items = ["Gram", "Milliliter", "Liter", "Kilogram", "Packets", "Pieces" , "Set" , "Quire"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.spacing = 0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: unitTypeButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
        
    }
    
    @IBAction func substractStockAction(sender: AnyObject) {
        
        if dropper.status == .Hidden {
            dropper.tag = 4
            dropper.items = ["Yes" , "No"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.spacing = 0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: substractStockButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
        
    }
    
    @IBAction func statusAction(sender: AnyObject) {
        
        if dropper.status == .Hidden {
            dropper.tag = 5
            dropper.items = ["Enabled" , "Disabled"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.spacing = 0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: statusButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
        
    }

    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {
        switch tag {
        case 1:
            serviceLabel.text = "\(contents)"
        case 2:
            categoryLabel.text = "\(contents)"
        case 3:
            unitTypeLabel.text = "\(contents)"
        case 4:
            substractStockLabel.text = "\(contents)"
            if contents == "Yes"{
                stockLabelString = "1"
            }else{
                stockLabelString = "0"
            }
        case 5:
            statusLabel.text = "\(contents)"
            if contents == "Enabled"{
               statusString = "1"
            }else{
               statusString = "0"
            }
        default:
            nameLabel.text = "\(contents)"
        }
    }
    
    func editOrAddDetails() {
        if Reachability.isConnectedToNetwork() {
            if formValidation() {
                let params:[String:AnyObject] = [
                    "token":token,
                    "device_id":"1234",
                    "manufacturer":manufacturerLabel.text!,
                    "manufacturer_id":"0",
                    "product_category[]":categoryLabel.text!,
                    "product_description[1][name]":nameLabel.text!,
                    "product_description[1][description]":descriptionLabel.text!,
                    "image":str,
                    "price":priceLabel.text!,
                    "product_special[0][price]":offerPriceLabel.text!,
                    "weight_class_id":unitValueLabel.text!,
                    "weight":unitTypeLabel.text!,
                    "quantity":quantityLabel.text!,
                    "subtract":substractStockLabel.text!,
                    "status":statusString,
                    "product_description[1][meta_title]":nameLabel.text!,
                    "model":nameLabel.text!,
                    "service_id":serviceLabel.text!,
                    "ref_code":referenceCodeLabel.text!
                ]
                
                ServerManager.sharedInstance().addProduct(params) { (isSuccessful, error, result) in
                    if isSuccessful {
                        print("Success")
                    }
                }        }
            else{
                self.hideHud()
                AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
            }
        }
    }

//  Link - https://github.com/awseeley/Swift-Pop-Up-View-Tutorial

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        radioButtonController = SSRadioButtonsController(buttons: button1, button2, button3)
//        radioButtonController!.delegate = self
//        radioButtonController!.shouldLetDeSelect = true
//
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    func didSelectButton(aButton: UIButton?) {
//        if aButton == button1 {
//            self.view.backgroundColor = UIColor.orangeColor()
//        }else if aButton == button2{
//            self.view.backgroundColor = UIColor.redColor()
//        }else{
//            self.view.backgroundColor = UIColor.blueColor()
//        }
//    }

}
