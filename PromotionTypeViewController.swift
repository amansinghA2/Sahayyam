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

class PromotionTypeViewController: UIViewController , SSRadioButtonControllerDelegate , UITextFieldDelegate , DropperDelegate{


    var vendorPromotionList:VendorPromotionList!

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
    var someGlobalNSInteger = Int()
    
    let dropper = Dropper(width: 131, height: 200)
    var date = NSDate()
    var date1 = NSDate()
    
    var isCheck = false
    var str = ""
    var radioButtonController = SSRadioButtonsController()
    var discountType = String()
    var amountType = String()
    var unitTypeString = String()
    var productNameString = String()
    
    override func viewDidLoad() {
       super.viewDidLoad()
        tokenCheck()
        
//      fromLabel.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
//      toLabel.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        fromLabel.delegate = self
        toLabel.delegate = self
        productNameString = ""
        radioButtonController.setButtonsArray([amountRadioButton!,percentageRadioButton!])
        radioButtonController.delegate = self
        amountRadioButton.selected = true
        
//      radioButtonController.shouldLetDeSelect = true

        if str == "fromEdit"{
            discountType = "A"
            self.amountpromotionOutlet.checkState = .Checked
            productnameQuantityConstraint.constant  = 0
            nameAndQuantityView.hidden = true
            bindModelToViews()
        }else{
            productnameQuantityConstraint.constant  = 0
            nameAndQuantityView.hidden = true
            discounttypeConstraint.constant = 0
            typeandValueView.hidden = true
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createPromotion(sender: AnyObject) {

       // let dateFormatter = NSDateFormatter()
        
//        let date = dateFormatter.dateFromString(fromLabel.text!)
//        let date1 = dateFormatter.dateFromString(toLabel.text!)
        
     

         if str == "fromEdit"{
//            let params:[String:AnyObject] = [
//                "product[name]":nameTextField.text!,
//                "product[productQuantity]":quantityLabel.text!,
//                "product[image]":"",
//                "product[amount]":amountLabel.text!,
//                "product[productUnitId]":"Gram",
//                "product[fromDate]":fromLabel.text!,
//                "product[endDate]":toLabel.text!,
//                "product[productDiscountType]":discountType,
//                "product[amtDiscountType]":discountValue.text!,
//                "product[productId]":productNameString,
//                "product[description]":desciptionLabel.text!,
//                "product[promotion_id]":vendorPromotionList.product_id,
//                "token":token,
//                "device_id":"1234"
//            ]
//            
//            print(params)
//            
//            ServerManager.sharedInstance().editPromotion(params) { (isSuccessful, error, result) in
//                if isSuccessful{
//                   
//                }
//            }
            
            self.promotionAddService(vendorPromotionList.product_id)
         }else{
            promotionAddService("")
        }

    }

    func bindModelToViews() {

        if let name = vendorPromotionList.name as? String{
            nameTextField.text = name
        }

        if let name = vendorPromotionList.price as? String{
            amountLabel.text = name
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
            isCheck = true
        }else{
            productNameString = ""
            isCheck = false
             discounttypeConstraint.constant  = 67
            typeandValueView.hidden = false
        }
    }

    @IBAction func productDescriptionAction(sender: AnyObject) {
        
        if self.productPromotionOutlet.checkState == .Unchecked{
            productNameString = vendorPromotionList.promo_name
            productnameQuantityConstraint.constant  = 0
            nameAndQuantityView.hidden = true
            isCheck = true
        }else{
            productNameString = ""
            isCheck = false
            productnameQuantityConstraint.constant  = 106
            nameAndQuantityView.hidden = false
        }

    }

    @IBAction func unitTypeAction(sender: AnyObject) {
        
        if dropper.status == .Hidden {
            dropper.tag = 3
            dropper.items = ["Gram", "Milliliter", "Liter", "Kilogram", "Packets", "Pieces" , "Set" , "Quire" , "Numbers"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.spacing = 0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: unitDropDownButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
        
    }
    
    func DropperSelectedRow(path: NSIndexPath, contents: String) {
        unitDropDownButton.setTitle("\(contents)", forState: .Normal)
        unitTypeString = "\(contents)"
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
//        
//    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    private func addDatePickerToTextField(textfield:UITextField){
        
        let datePickerView  : UIDatePicker = UIDatePicker()
//        datePickerView.datePickerMode = UIDatePickerMode.Date
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

      //textfield.text = dateFormatter.stringFromDate(sender.date)
    }

    func promotionAddService(promotionID:String) {
        
        self.showHud("Loading...")
        
        let params:[String:AnyObject] = [
            "product[name]":nameTextField.text!,
            "product[productQuantity]":quantityLabel.text!,
            "product[image]":"",
            "product[amount]":amountLabel.text!,
            "product[productUnitId]":unitTypeString,
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
