//
//  VndornewProductAddViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class VndornewProductAddViewController: UIViewController , UITextFieldDelegate , DropperDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIGestureRecognizerDelegate{

    
     var dropper = Dropper(width: 131, height: 150)
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
    @IBOutlet weak var offerPriceLabel: TextField!
    @IBOutlet weak var priceLabel: TextField!
    @IBOutlet weak var unitValueLabel: TextField!
    @IBOutlet weak var unitTypeLabel: UITextField!
    @IBOutlet weak var quantityLabel: TextField!
    @IBOutlet weak var substractStockLabel: UITextField!
    @IBOutlet weak var statusLabel: UITextField!
    @IBOutlet weak var productImage: UIImageView!
    
    var unitGrams = [UnitGram]()
    var clickedField = false
    let imagePicker = UIImagePickerController()
    
    var categoryLists = [ProductCategoryList]()
    var str = ""
    var fromDesc = ""
    var getProductDetails:ProductDetails!
    var statusString = String()
    var serviceLists = [VendorService]()
    var stockLabelString = String()

    var servicelabelString = String()
    var categorylabelString = String()
    var service_id = String()
    var serviceList = ServiceList()
    var categoryListIds = String()
    var weightClassID = String()
    var vendorProductDetails = VendorProductInDetails()
    var isServicealreadySelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        statusString = "1"
        stockLabelString = "0"
        statusLabel.text = "Enabled"
        substractStockLabel.text = "No"
        
        priceLabel.delegate = self
        offerPriceLabel.delegate = self
        unitValueLabel.delegate = self
        
        priceLabel.keyboardType = UIKeyboardType.DecimalPad
        offerPriceLabel.keyboardType = UIKeyboardType.DecimalPad
        unitValueLabel.keyboardType = UIKeyboardType.NumberPad
        quantityLabel.keyboardType = UIKeyboardType.NumberPad

        priceLabel.setTextFieldStyle(TextFieldStyle.TextfiledAmount)
        offerPriceLabel.setTextFieldStyle(TextFieldStyle.TextfiledAmount)
        unitValueLabel.setTextFieldStyle(TextFieldStyle.TextFieldUnit)
        quantityLabel.setTextFieldStyle(TextFieldStyle.TextFieldUnit)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VndornewProductAddViewController.dismissKeyboard))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        if fromDesc == "fromDescriptionPage"{
            tokenCheck()
            weightClassID = getProductDetails.weight_class_id
           // bindModelToViews()
            setBackButtonForNavigation()
            unitGramAction(getProductDetails.weight_class_id)
            serviceListAction(getProductDetails.service_id)
            autoCompleteCategoryAction(getProductDetails.service_id)
            self.showHud("Loading...") 
            let params:[String:AnyObject] = [
                "token":token,
                "device_id":"1234",
                "product_id":getProductDetails.product_id,
                "width":"515",
                "height":"500"
            ]
            
            ServerManager.sharedInstance().vendorProductDetailDetails(params) { (isSuccessful, error, result) in
                if isSuccessful {
                    print(result)
                    self.vendorProductDetails = result!
                    self.bindModelToViews()
                    self.hideHud()
                }else{
                    self.hideHud()
                }
            }
        }else{
            revealTouch(self)
            tokenCheck()
            serviceListAction("")
           // autoCompleteCategoryAction("")
            unitGramAction("")
            slideMenuShow(slideMenuButton, viewcontroller: self)
        }

            imagePicker.delegate = self
            // Do any additional setup after loading the view.
    }

    override func dismissKeyboard() {
        self.view.endEditing(true)
        dropper.hideWithAnimation(0.1)
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if CGRectContainsPoint(self.dropper.bounds, touch.locationInView(dropper)){
            return false
        }else{
            return true
        }
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    func bindModelToViews() {
        
        for categoryList in categoryLists {
            if getProductDetails.productCategories == categoryList.category_id {
                categoryListIds = categoryList.category_id
            }
        }
        
        if let name = getProductDetails.name as? String{
            nameLabel.text = name
        }
        
        if let name = getProductDetails.manufacturer_id as? Int{
            manufacturerLabel.text = String(name)
        }
        
        if let name = vendorProductDetails.mCatName as? String{
            categoryLabel.text = name
        }
        
        if let name = getProductDetails.productDescription as? String{
            descriptionLabel.text = name
        }
        
        if let name = getProductDetails.price as? String{
            priceLabel.text = CustomClass.roundOfDecimal(name)
        }
        
        if let name = getProductDetails.offerPrice as? String{
            offerPriceLabel.text = CustomClass.roundOfDecimal(name)
        }
        
        if let name = getProductDetails.weight as? String{
            if name.containsString("0.00000000"){
            }else{
                unitTypeLabel.text = name
            }
        }
        
//        if let name = getProductDetails.service_id as? String{
//            service_id = name
//            for serviceList in serviceLists {
//                if name == serviceList.id {
//                    serviceLabel.text = serviceList.desc
//                }
//            }
//            
//            //            if contents == serviceList.desc {
//            //                service_id = serviceList.id
//            //            }
//            //
//            //            service_id = name
//            //            serviceLabel.text = name
//        }
        
        if let name = getProductDetails.service_id as? String{
            service_id = name
            for serviceList in serviceLists {
                if name == serviceList.id {
                    serviceLabel.text = serviceList.desc
                }
            }
            
//            if contents == serviceList.desc {
//                service_id = serviceList.id
//            }
//            
//            service_id = name
//            serviceLabel.text = name
        }
        
//        if let name = getProductDetails.status as? String{
//            statusString = name
//            if name == "0" {
//             statusLabel.text = "Disabled"
//            }else{
//             statusLabel.text = "Enabled"
//            }
//        }
        
        if let name = getProductDetails.quantity as? String{
            quantityLabel.text = name
        }
        
//        if let name = getProductDetails.name as? String{
//            unitTypeLabel.text = name
//        }
        
       
        if let name = vendorProductDetails.mImgDir as? String{
            if name == "" {
            productImage.image = UIImage(named: "v_no_image")
            }else{
                productImage.imageFromUrl(name)
            }
        }
        
        if let name = vendorProductDetails.mImgDirs as? String{
            if name == "" {
                productImage.image = UIImage(named: "v_no_image")
            }else{
                str = name
            }
        }
        
        if let name = getProductDetails.subtract as? String{
            
            if name == "0" {
                stockLabelString = name
               substractStockLabel.text = "NO"
            }else{
               stockLabelString = name
               substractStockLabel.text = "YES"
            }
        }
        
        if let name = getProductDetails.ref_code as? String{
            referenceCodeLabel.text = name
        }
        
    }
   
    
//    func textField(textField: UITextField,shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool
//    {
//        
//        if textField == unitValueLabel {
//            let newCharacters = NSCharacterSet(charactersInString: string)
//            let boolIsNumber = NSCharacterSet.decimalDigitCharacterSet().isSupersetOfSet(newCharacters)
//            if boolIsNumber == true {
//                return true
//            }else{
//                return false
//            }
//        }else{
//        let newCharacters = NSCharacterSet(charactersInString: string)
//        let boolIsNumber = NSCharacterSet.decimalDigitCharacterSet().isSupersetOfSet(newCharacters)
//        if boolIsNumber == true {
//            return true
//        } else {
//            if string == "." {
//                let countdots = textField.text!.componentsSeparatedByString(".").count - 1
//                if countdots == 0 {
//                    return true
//                } else {
//                    if countdots > 0 && string == "." {
//                        return false
//                    } else {
//                        return true
//                    }
//                }
//            } else {
//                return false
//            }
//        }
//        }
//    }
    
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

        if nameLabel.text?.characters.count <= 3 || nameLabel.text?.characters.count >= 255 {
            AlertView.alertView("Alert", message: "Name title should be minimum of 4 characters", alertTitle: "OK", viewController: self)
            return false
        }
        
//        let possibleNumber = priceLabel.text ?? ""
//        if let convertedNumber = Int(possibleNumber) {
//
//
//            print("'\(possibleNumber)' is an Int")
//        }
//        else {
//            print("'\(possibleNumber)' is not an Int")
//        }
//        
//        let possibleNumber = offerPriceLabel.text ?? ""
//        if let convertedNumber = Int(possibleNumber) {
//            print("'\(possibleNumber)' is an Int")
//            totalTime = convertedNumber
//        }
//        else {
//            print("'\(possibleNumber)' is not an Int")
//        }
//        
//        let possibleNumber = unitTypeLabel.text ?? ""
//        if let convertedNumber = Int(possibleNumber) {
//            print("'\(possibleNumber)' is an Int")
//            totalTime = convertedNumber
//        }
//        else {
//            print("'\(possibleNumber)' is not an Int")
//        }
        
        
//        if categoryLists.contains(nameLabel.text!){
//            AlertView.alertView("Alert", message: "Product name already exist. You must enter a valid product name!", alertTitle: "OK", viewController: self)
//            return false
//        }
        
//        for category in categoryLists {
//            if category.name.containsString(nameLabel.text!) {
//                AlertView.alertView("Alert", message: "Product name already exist. You must enter a valid product name!", alertTitle: "OK", viewController: self)
//                return false
//            }
//        }
        
        let a:Int? = Int(priceLabel.text!)
        let b:Int? = Int(offerPriceLabel.text!)
        
        if a < b {
            AlertView.alertView("Alert", message: "Offer Price should be less than the product price", alertTitle: "OK", viewController: self)
            return false
        }
        
        if unitValueLabel.text?.characters.count == 0  {
            AlertView.alertView("Alert", message: "Unit Value cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if unitTypeLabel.text?.characters.count == 0 {
            AlertView.alertView("Alert", message: "Unit Type cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if nameLabel.text?.characters.count == 0 {
            AlertView.alertView("Alert", message: "Name field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if (priceLabel.text?.characters.count == 0){
            AlertView.alertView("Alert", message: "Price must be entered", alertTitle: "OK", viewController: self)
            return false
        }

        return true
    }
    
    @IBAction func saveButton(sender: AnyObject){
        self.view.endEditing(true)
        if self.fromDesc == "fromDescriptionPage" {
            if Reachability.isConnectedToNetwork() {
                if formValidation() {
                    self.showHud("Loading...")
                    
                    let newString = nameLabel.text!.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: "la t, \n \" ':"))
                    
                    let params: [String:AnyObject] = [
                        "token":token,
                        "device_id":"1234",
                        "manufacturer":manufacturerLabel.text!,
                        "manufacturer_id":"0",
                        "product_category[]":categoryListIds,
                        "product_id":getProductDetails!.product_id,
                        "product_description[1][name]":nameLabel.text!,
                        "product_description[1][description]": descriptionLabel.text!,
                        "image":str,
                        "price":priceLabel.text!,
                        "product_special[0][price]":offerPriceLabel.text!,
                        "weight_class_id":weightClassID,
                        "weight":unitTypeLabel.text!,
                        "quantity":quantityLabel.text!,
                        "subtract":stockLabelString,
                        "status":statusString,
                        "name":newString,
                        "product_description[1][tag]":"",
                        "product_description[1][meta_title]":nameLabel.text!,
                        "product_description[1][meta_description]":"",
                        "product_description[1][meta_keyword]":"",
                        "model":nameLabel.text!,
                        "service_id":service_id,
                        "product_special[0][customer_group_id]":"1",
                        "product_special[0][date_start]":"0000-00-00",
                        "product_special[0][date_end]":"0000-00-00",
                        "product_special[0][priority]":"1",
                        "ref_code":referenceCodeLabel.text!
                    ]
                    
                    print(params)
                    
                    ServerManager.sharedInstance().editProduct(params) { (isSuccessful, error, result , result1) in
                        if isSuccessful {
                            self.hideHud()
                            if let error = result1!["error"] as? [String:AnyObject]{
                                if let errorName = error["error_name"] as? [String:AnyObject]{
                                    if let nameError = errorName["1"] {
                                        AlertView.alertView("Alert", message:nameError as! String, alertTitle: "OK", viewController: self)
                                    }
                                }
                            }else{
                                let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MyProductsViewID") as! MyProductsViewController
                                self.navigationController!.pushViewController(secondViewController, animated: true)
                                NSNotificationCenter.defaultCenter().postNotificationName("showtoast", object: self.service_id)
                               
                            }
                        }else{
                           self.hideHud()
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
            self.hideHud()
            editOrAddDetails()
        }
   }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        self.dropper.hideWithAnimation(0.1)
    }
    
    @IBAction func serviceAction(sender: AnyObject) {
        
        var serviceName = [String]()
        for serviceList in serviceLists {
            serviceName.append(serviceList.desc)
        }
        if dropper.status == .Hidden {
                    dropper = Dropper(x: categoryLabel.frame.origin.x, y: categoryLabel.frame.origin.y + categoryLabel.frame.size.height, width: categoryLabel.frame.size.width, height: 150)
            dropper.tag = 1
            dropper.items = serviceName
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
           // dropper.cellColor = UIColor.lightGrayColor()
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: nameDropDown)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    @IBAction func categoryAction(sender: AnyObject) {
        self.view.endEditing(true)
        var categoryListArray = [String]()
        
        for categoryLIst in categoryLists {
            categoryListArray.append(categoryLIst.name)
        }

        if dropper.status == .Hidden {
                    dropper = Dropper(x: categoryLabel.frame.origin.x, y: categoryLabel.frame.origin.y + categoryLabel.frame.size.height, width: categoryLabel.frame.size.width, height: 150)
            dropper.tag = 2
            dropper.items = categoryListArray
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options:Dropper.Alignment.Center, button:categoryDropDown)
//            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: categoryDropDown)
        } else {
            dropper.hideWithAnimation(0.1)
        }

    }
    
    @IBAction func unitTypeAction(sender: AnyObject) {
        self.view.endEditing(true)
        var unitGramArray = [String]()
        
        for unitGram in unitGrams {
            unitGramArray.append(unitGram.title)
        }
        
        if dropper.status == .Hidden {
              dropper = Dropper(x: categoryLabel.frame.origin.x, y: categoryLabel.frame.origin.y + categoryLabel.frame.size.height, width: categoryLabel.frame.size.width, height: 150)
            dropper.tag = 3
            dropper.items = unitGramArray
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
//            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: unitTypeButton)
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: unitTypeButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    @IBAction func substractStockAction(sender: AnyObject) {
        self.view.endEditing(true)
        

    
        if dropper.status == .Hidden {
                    dropper = Dropper(x: statusLabel.frame.origin.x, y: statusLabel.frame.origin.y + statusLabel.frame.size.height, width: statusLabel.frame.size.width, height: 150)
            dropper.tag = 4
            dropper.items = ["Yes" , "No"]
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
//            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: substractStockButton)
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: substractStockButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    @IBAction func statusAction(sender: AnyObject) {
        self.view.endEditing(true)

        if dropper.status == .Hidden {
                    dropper = Dropper(x: statusLabel.frame.origin.x, y: statusLabel.frame.origin.y + statusLabel.frame.size.height, width: statusLabel.frame.size.width, height: 150)
            dropper.tag = 5
            dropper.items = ["Enabled" , "Disabled"]
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cornerRadius = 3
            dropper.cellTextSize = 13.0
             dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: statusButton)
//            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: statusButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }

    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {
        switch tag {
        case 1:
            serviceLabel.text = "\(contents)"
            clickedField = true
            for serviceList in serviceLists {
                if contents == serviceList.desc {
                    service_id = serviceList.id
                }
            }
            //serviceListAction(service_id)
            autoCompleteCategoryAction(service_id)
        case 2:
            categoryLabel.text = "\(contents)"
            for categoryList in categoryLists {
                if contents == categoryList.name {
                    categoryListIds = categoryList.category_id
                }
            }
        case 3:
            unitTypeLabel.text = "\(contents)"
            for unitGram in unitGrams {
                if contents == unitGram.title {
                    weightClassID = unitGram.weight_class_id
                }
            }
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
            self.showHud("Loading...")
            if formValidation() {
                
                let newString = nameLabel.text!.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: "la t, \n \" ':"))
                let params:[String:AnyObject] = [
                    "token":token,
                    "device_id":"1234",
                    "manufacturer":manufacturerLabel.text!,
                    "manufacturer_id":"0",
                    "product_category[]":categoryListIds,
                    "product_description[1][name]":nameLabel.text!,
                    "product_description[1][description]":descriptionLabel.text!,
                    "image":str,
                    "price":priceLabel.text!,
                    "product_special[0][price]":offerPriceLabel.text!,
                    "weight_class_id":weightClassID,
                    "weight":unitTypeLabel.text!,
                    "quantity":quantityLabel.text!,
                    "subtract":stockLabelString,
                    "status":statusString,
                    "product_description[1][meta_title]":nameLabel.text!,
                    "model":newString,
                    "service_id":service_id,
                    "ref_code":referenceCodeLabel.text!
                ]

                print(params)
                
                ServerManager.sharedInstance().addProduct(params) { (isSuccessful, error, result , result1) in
                    if isSuccessful {
                        if let error = result1!["error"] as? [String:AnyObject]{
                            if let errorName = error["error_name"] as? [String:AnyObject]{
                                if let nameError = errorName["1"] {
                                  AlertView.alertView("Alert", message:nameError as! String, alertTitle: "OK", viewController: self)
                                }
                            }
                        }else{
                          self.toastViewForTextfield("New product successfully created")
                            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("MyProductsViewID") as! MyProductsViewController
                            self.navigationController!.pushViewController(secondViewController, animated: true)
                        }
                        self.hideHud()
                    }else{
                        self.hideHud()
                    }
                }
            }
            else{
                self.hideHud()
                AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
            }
        }
    }
    
    func autoCompleteCategoryAction(service_id:String) {
        self.showHud("Loading...")
        let params = [
            "token":token,
            "device_id":"1234",
            "service_id":service_id,
            "filter_name":""
        ]

        print(params)
        
        ServerManager.sharedInstance().autocompleteCategoryList(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
                self.categoryLists = result!
                if self.fromDesc == "fromDescriptionPage"{
                    if self.clickedField == false {
                        self.hideHud()
                        self.bindModelToViews()
                    }
                }else{
                  self.hideHud()
                }
                
                if service_id != "" {
                    self.hideHud()
                    self.categoryLabel.text = self.categoryLists[0].name
                    self.categoryListIds = self.categoryLists[0].category_id
                }else{
                if self.fromDesc == "fromDescriptionPage"{
                   self.hideHud()
                }else{
                    self.categoryLabel.text = self.categoryLists[0].name
                    self.categoryListIds = self.categoryLists[0].category_id
                    self.hideHud()
                }
                }
            }else{
                self.hideHud()
            }
        }
        
    }
    
    
    func serviceListAction(getProductDetailsServiceId:String) {
        self.showHud("Loading...")
        let params1 = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().getVendorServices(params1) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
                self.serviceLists = result!
                
                if self.fromDesc == "fromDescriptionPage"{
                    if self.clickedField == false {
                    self.bindModelToViews()
                    }
                }else{
                 self.hideHud()
                }
                
                if getProductDetailsServiceId != "" {
                    self.hideHud()
                }else{
                if self.fromDesc == "fromDescriptionPage"{
                    self.hideHud()
                    for serviceList in self.serviceLists {
                        self.hideHud()
                        if getProductDetailsServiceId == serviceList.id {
                            self.hideHud()
                            self.serviceLabel.text = serviceList.desc
                            self.service_id = getProductDetailsServiceId
                        }
                    }
                }else{
                    self.hideHud()
                    self.serviceLabel.text = self.serviceLists[0].desc
                    self.service_id = self.serviceLists[0].id
                    self.autoCompleteCategoryAction(self.service_id)
                }
                }
            }else{
                self.hideHud()
            }
        }
  
    }
    
    func unitGramAction(unitTypeString:String) {
        self.showHud("Loading...")
        let params = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().vendorUnitGram(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
                self.unitGrams = result!
                for unitGram in self.unitGrams {
                    self.hideHud()
                    if unitTypeString == unitGram.weight_class_id {
                        self.hideHud()
                        self.unitTypeLabel.text = unitGram.title
                    }
                }
            }else{
                self.hideHud()
            }
        }
    }
    
}
