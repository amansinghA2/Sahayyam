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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuShow(slideMenuButton, viewcontroller: self)
        tokenCheck()
        imagePicker.delegate = self
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
                    "product_special[0][price]":offerPriceLabel,
                    "weight_class_id":unitValueLabel,
                    "weight":unitTypeLabel,
                    "quantity":quantityLabel,
                    "subtract":substractStockLabel,
                    "status":statusLabel,
                    "product_description[1][meta_title]":token,
                    "model":nameLabel.text!,
                    "service_id":serviceLabel,
                    "ref_code":referenceCodeLabel
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

    @IBAction func categoryAction(sender: AnyObject) {

        if dropper.status == .Hidden {
            dropper.tag = 1
            dropper.items = ["Larger, Longer, Item 1", "Item 2", "Item 3", "Item 4"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: categoryDropDown)
        } else {
            dropper.hideWithAnimation(0.1)
        }

    }
    
    @IBAction func nameButton(sender: AnyObject) {

        if dropper.status == .Hidden {
            dropper.tag = 2
            dropper.items = ["Larger, Longer, Item 1", "Item 2", "Item 3", "Item 4"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.spacing = 0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: nameDropDown)
        } else {
            dropper.hideWithAnimation(0.1)
        }

    }

    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {
        switch tag {
        case 1:
            categoryLabel.text = "\(contents)"
        case 2:
            nameLabel.text = "\(contents)"
        default:
            nameLabel.text = "\(contents)"
        }
    }






//LInk - https://github.com/awseeley/Swift-Pop-Up-View-Tutorial




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
