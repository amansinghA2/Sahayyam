//
//  PromotionTypeViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import M13Checkbox
import Dropper

class PromotionTypeViewController: UIViewController , SSRadioButtonControllerDelegate , UITextFieldDelegate , DropperDelegate , UIGestureRecognizerDelegate{
    
    
    var vendorPromotionList:VendorPromotionList!
    
    @IBOutlet weak var createPromotionButtonOutlet: Button!
    @IBOutlet weak var productnameQuantityConstraint: NSLayoutConstraint!
    @IBOutlet weak var discounttypeConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameAndQuantityView: UIView!
    @IBOutlet weak var typeandValueView: UIView!
    
    @IBOutlet weak var amountpromotionOutlet: M13Checkbox!
    @IBOutlet weak var productPromotionOutlet: M13Checkbox!
    
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var desciptionLabel: TextField!
    @IBOutlet weak var amountLabel: TextField!
    
    @IBOutlet weak var fromLabel: UITextField!
    @IBOutlet weak var toLabel: UITextField!
    
    @IBOutlet weak var discountValue: TextField!
    
    @IBOutlet weak var percentageRadioButton: SSRadioButton!
    @IBOutlet weak var amountRadioButton: SSRadioButton!
    
    @IBOutlet weak var productName: TextField!
    @IBOutlet weak var quantityLabel: TextField!
    @IBOutlet weak var unitDropDownButton: UIButton!
    
    var toastString = String()
    var someGlobalNSInteger = Int()
    var dropper = Dropper(width: 131, height: 100)
    var date = NSDate()
    var date1 = NSDate()
    var unitGrams = [UnitGram]()
    var isAmountCheck = false
    var isPromotionCheck = false
    var str = ""
    var radioButtonController = SSRadioButtonsController()
    var discountType = String()
    var amountType = String()
    var unitTypeString = String()
    var productNameString = String()
    var weightClassID = String()
    var isEditPage = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenCheck()
        //      fromLabel.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        //      toLabel.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PromotionTypeViewController.dismissKeyboard))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        
        discountValue.keyboardType = .DecimalPad
        amountLabel.keyboardType = .DecimalPad
        quantityLabel.keyboardType = .NumberPad
        
        amountLabel.setTextFieldStyle(TextFieldStyle.TextfiledAmount)
        discountValue.setTextFieldStyle(TextFieldStyle.TextfiledAmount)
        quantityLabel.setTextFieldStyle(TextFieldStyle.TextFieldUnit)
        
        fromLabel.delegate = self
        toLabel.delegate = self
        productNameString = ""
        radioButtonController.setButtonsArray([amountRadioButton!,percentageRadioButton!])
        radioButtonController.delegate = self
        amountRadioButton.selected = true
        
//      radioButtonController.shouldLetDeSelect = true
        
        if str == "fromEdit"{
            isEditPage = true
            isAmountCheck = true
            discountType = "A"
            unitGramAction("") 
            createPromotionButtonOutlet.setTitle("Edit promotion", forState: .Normal)
            self.amountpromotionOutlet.checkState = .Checked
            productnameQuantityConstraint.constant  = 0
            nameAndQuantityView.hidden = true
            bindModelToViews()
        }else{
            isEditPage = false
            unitGramAction("")
            discountType = "A"
            createPromotionButtonOutlet.setTitle("Create Promotion", forState: .Normal)
            productnameQuantityConstraint.constant  = 0
            nameAndQuantityView.hidden = true
            discounttypeConstraint.constant = 0
            typeandValueView.hidden = true
        }
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
    
    @IBAction func createPromotion(sender: AnyObject) {
        
        // let dateFormatter = NSDateFormatter()
        
        if str == "fromEdit"{
            self.promotionAddService(vendorPromotionList.product_id)
//            toastString = "Promotion edited successfully"
//            NSNotificationCenter.defaultCenter().postNotificationName("showtoast", object: toastString)
        }else{
            promotionAddService("")
//            toastString = "Promotion created successfully"
//            NSNotificationCenter.defaultCenter().postNotificationName("showtoast", object: toastString)
            
        }
        
    }
    
    func bindModelToViews() {
        
        if let name = vendorPromotionList.name as? String{
            nameTextField.text = name
        }
        
        if let name = vendorPromotionList.price as? String{
            let price = CustomClass.roundOfDecimal(name)
            amountLabel.text = price
        }
        
        if vendorPromotionList.discount != "" {
            if let name = vendorPromotionList.discount as? String{
                discountValue.text = name
            }
        }
        
        if let name = vendorPromotionList.start_date_added as? String{
            fromLabel.text =  name
        }
        
        if let name = vendorPromotionList.end_date_added as? String{
            toLabel.text =  name
        }
        
        if let name = vendorPromotionList.promotionDescription as? String{
            desciptionLabel.text =  name
        }
        
        if let name = vendorPromotionList.quantity as? String{
            quantityLabel.text = name
        }
        
        if let name = vendorPromotionList.promo_name as? String{
            productName.text =  name
        }
    }
    
    @IBAction func amountPromotionAction(sender: AnyObject) {
        if self.amountpromotionOutlet.checkState == .Unchecked{
            productNameString = ""
            discounttypeConstraint.constant  = 0
            typeandValueView.hidden = true
            isAmountCheck = false
        }else{
            productNameString = ""
            isAmountCheck = true
            discounttypeConstraint.constant  = 67
            typeandValueView.hidden = false
        }
    }
    
    @IBAction func productDescriptionAction(sender: AnyObject) {
        if self.productPromotionOutlet.checkState == .Unchecked{
            if isEditPage == true {
              productNameString = vendorPromotionList.promo_name
            }else{
                productNameString = ""
            }
            productnameQuantityConstraint.constant  = 0
            nameAndQuantityView.hidden = true
            isPromotionCheck = false
        }else{
            productNameString = ""
            isPromotionCheck = true
            productnameQuantityConstraint.constant  = 106
            nameAndQuantityView.hidden = false
        }
    }
    
    @IBAction func unitTypeAction(sender: AnyObject) {
        
        var unitGramArray = [String]()
        for unitGram in unitGrams {
            unitGramArray.append(unitGram.title)
        }
        
        print(unitGramArray)
        
        if dropper.status == .Hidden {
            dropper = Dropper(x: unitDropDownButton.frame.origin.x, y: unitDropDownButton.frame.origin.y + unitDropDownButton.frame.size.height, width: unitDropDownButton.frame.size.width, height: 150)
            dropper.tag = 3
            dropper.items = unitGramArray
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cornerRadius = 3
            dropper.cellTextSize = 13.0
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: unitDropDownButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
        
        
    }
    
    func DropperSelectedRow(path: NSIndexPath, contents: String) {
        
        unitDropDownButton.setTitle("\(contents)", forState: .Normal)
        unitTypeString = "\(contents)"
        for unitGram in unitGrams {
            if contents == unitGram.title {
                weightClassID = unitGram.weight_class_id
            }
        }
    }
    
    func didSelectButton(aButton: UIButton?) {
        if aButton == percentageRadioButton {
            discountType = "P"
        }else{
            discountType = "A"
        }
    }
    
    
    // Mark :- Date Picker
    
    func textFieldDidBeginEditing(textField: UITextField) {
        someGlobalNSInteger = textField.tag
        addDatePickerToTextField(textField)
    }
    
    //    func textFieldDidEndEditing(textField: UITextField) {
    //        self.view.endEditing(true)
    //        if fromLabel.text!.isEmpty{
    //            let date = NSDate()
    //            let dateFormatter = NSDateFormatter()
    //            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    //            fromLabel.text = dateFormatter.stringFromDate(date)
    //        }
    //
    //        if isCheck == true {
    //            fromLabel.text = ""
    //        }
    //
    //        if toLabel.text!.isEmpty{
    //            let date = NSDate()
    //            let dateFormatter = NSDateFormatter()
    //            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    //            toLabel.text = dateFormatter.stringFromDate(date)
    //        }
    //        if isCheck == true {
    //            toLabel.text = ""
    //        }
    //    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    func formValidation() -> Bool{
        
        if isAmountCheck == false && isPromotionCheck == false {
            AlertView.alertView("Alert", message: "Please Select Promotion Type", alertTitle: "OK", viewController: self)
            return false
        }
        
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
        
        if nameTextField.text?.characters.count == 0  {
            AlertView.alertView("Alert", message: "Name Field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        
        if amountLabel.text?.characters.count == 0  {
            AlertView.alertView("Alert", message: "Amount cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        let a:Int? = Int(discountValue.text!)
        
        if discountType == "P" {
            if a > 100 {
                AlertView.alertView("Alert", message: "Discount value cannot be more than 100", alertTitle: "OK", viewController: self)
                return false
            }else if a <= 0 {
                AlertView.alertView("Alert", message: "Invalid discount value", alertTitle: "OK", viewController: self)
                return false
            }
        }else {
            if a <= 0  {
                AlertView.alertView("Alert", message: "Invalid amount value", alertTitle: "OK", viewController: self)
                return false
            }
        }
        
        let b:Double? = Double(amountLabel.text!)
        
        if b <= 0  {
            AlertView.alertView("Alert", message: "Invalid amount entered", alertTitle: "OK", viewController: self)
            return false
        }
        
        if fromLabel.text?.characters.count == 0 {
            AlertView.alertView("Alert", message: "From field cannot be left blank", alertTitle: "OK", viewController: self)
            return false
        }
        
        if (toLabel.text?.characters.count == 0){
            AlertView.alertView("Alert", message: "To Field must be entered", alertTitle: "OK", viewController: self)
            return false
        }
        
        return true
    }
    
    
    
    private func addDatePickerToTextField(textfield:UITextField){
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.minimumDate = NSDate()
        datePickerView.backgroundColor = UIColor.whiteColor()
        textfield.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(CheckoutViewController.handleDatePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        //            let dateFormatter = NSDateFormatter()
        //            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        //            let currentDate = textfield.text
        //            let date = dateFormatter.dateFromString(currentDate!)
        //            datePickerView.setDate(date!, animated: false)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        //      var strDate = dateFormatter.stringFromDate(datePicker.date)
        //      dateLabel.text = strDate
        //
        //      let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        switch someGlobalNSInteger {
        case 1:
            date = sender.date
            fromLabel.text = dateFormatter.stringFromDate(sender.date)
        case 2:
            date1 = sender.date
            if date.compare(sender.date) == .OrderedDescending {
                AlertView.alertView("Alert", message: "From is earlier than to", alertTitle: "OK", viewController: self)
                toLabel.text = ""
            }
            toLabel.text = dateFormatter.stringFromDate(sender.date)
        default:
            ""
        }
        
        //      textfield.text = dateFormatter.stringFromDate(sender.date)
        
    }
    
    func promotionAddService(promotionID:String) {
        
        self.showHud("Loading...")
        if formValidation() {
            let params:[String:AnyObject] = [
                "product[name]":nameTextField.text!,
                "product[productQuantity]":quantityLabel.text!,
                "product[image]":"",
                "product[amount]":amountLabel.text!,
                "product[productUnitId]":weightClassID,
                "product[fromDate]":fromLabel.text!,
                "product[endDate]":toLabel.text!,
                "product[productDiscountType]":discountType,
                "product[amtDiscountType]":discountValue.text!,
                "product[productId]":productNameString,
                "product[description]":desciptionLabel.text!,
                "product[promotion_id]":promotionID,
                "token":token,
                "device_id":"1234"
            ]
            
            print(params)
            
            ServerManager.sharedInstance().addPromotion(params) { (isSuccessful, error, result) in
                if isSuccessful{
                    if self.str == "fromEdit"{
                        self.navigationController?.popToRootViewControllerAnimated(true)
                        self.toastString = "Promotion edited successfully"
                        NSNotificationCenter.defaultCenter().postNotificationName("showtoast", object: self.toastString)
                        self.hideHud()
                    }else{
                        self.navigationController?.popToRootViewControllerAnimated(true)
                        self.toastString = "Promotion created successfully"
                        NSNotificationCenter.defaultCenter().postNotificationName("showtoast", object: self.toastString)
                        self.hideHud()                        
                    }
                    
                }else{
                    if let error1 = error{
                        self.hideHud()
                        AlertView.alertView("Alert", message: error1, alertTitle: "OK", viewController: self)
                        self.navigationController?.popToRootViewControllerAnimated(true)
                        
                    }
                }
            }
        }else{
            self.hideHud()
        }
        
    }
    
    func unitGramAction(unitTypeString:String) {
        
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().vendorUnitGram(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.unitGrams = result!
                for unitGram in self.unitGrams {
                    if unitTypeString == unitGram.weight_class_id {
                        self.unitDropDownButton.setTitle(unitGram.title, forState: .Normal)
                    }
                }
                self.hideHud()
            }else{
                self.hideHud()
            }
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
