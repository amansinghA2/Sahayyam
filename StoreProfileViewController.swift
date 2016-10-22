//
//  StoreProfileViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class StoreProfileViewController: UIViewController , SSRadioButtonControllerDelegate , UITextFieldDelegate {
    
    
    var businessViewConstant = CGFloat(43)
    @IBOutlet weak var deliveryChargesView: UIView!
    @IBOutlet weak var freeDeliveryView: UIView!
    @IBOutlet weak var deliveryChargesContraint: NSLayoutConstraint!
    @IBOutlet weak var freeDeliveryContraint: NSLayoutConstraint!
    @IBOutlet weak var deliveryCharges: SSRadioButton!
    @IBOutlet weak var freeDelivery: SSRadioButton!
    @IBOutlet weak var slideMenubButton: UIBarButtonItem!
    @IBOutlet weak var businessTimeingViewContraint: NSLayoutConstraint!
    @IBOutlet weak var deliveryTimingContraint: NSLayoutConstraint!
    @IBOutlet weak var businessTimingView: UIView!
    @IBOutlet weak var deliveryTimingView: UIView!
    @IBOutlet weak var fromLabel1: UITextField!
    @IBOutlet weak var fromLabel2: UITextField!
    @IBOutlet weak var fromLabel3: UITextField!
    @IBOutlet weak var toLabel1: UITextField!
    @IBOutlet weak var toLabel2: UITextField!
    @IBOutlet weak var toLabel3: UITextField!
    @IBOutlet weak var expressDeliveryButton: UITextField!
    @IBOutlet weak var businessHolidayField: UITextField!
    @IBOutlet weak var deliveryTimeTextField0: UITextField!
    @IBOutlet weak var deliveryTimeTextField1: UITextField!
    @IBOutlet weak var deliveryTimeTextField2: UITextField!
    @IBOutlet weak var deliveryTimeTextField3: UITextField!
    @IBOutlet weak var deliveryTimeTextField4: UITextField!
    @IBOutlet weak var deliveryTimeTextField5: UITextField!
    @IBOutlet weak var deliveryTimeTextField6: UITextField!
    @IBOutlet weak var deliveryTimeTextField7: UITextField!
    @IBOutlet weak var deliveryTimeTextField8: UITextField!
    @IBOutlet weak var deliveryTimeTextField9: UITextField!

    // NS Dates
    
    var date1 = NSDate()
    var date2 = NSDate()
    var date3 = NSDate()
    var date4 = NSDate()
    var date5 = NSDate()
    var date6 = NSDate()
    var date7 = NSDate()
    var date8 = NSDate()
    var date9 = NSDate()
    var date10 = NSDate()
    var date11 = NSDate()
    var date12 = NSDate()
    var date13 = NSDate()
    var date14 = NSDate()
    var date15 = NSDate()
    var date16 = NSDate()
    // Labels
    
    @IBOutlet weak var from1: UILabel!
    @IBOutlet weak var from2: UILabel!
    @IBOutlet weak var from3: UILabel!
    @IBOutlet weak var to1: UILabel!
    @IBOutlet weak var to2: UILabel!
    @IBOutlet weak var to3: UILabel!

    @IBOutlet weak var deliveryTime0: UILabel!
    @IBOutlet weak var deliveryTime1: UILabel!
    @IBOutlet weak var deliveryTime2: UILabel!
    @IBOutlet weak var deliveryTime3: UILabel!
    @IBOutlet weak var deliveryTime4: UILabel!
    @IBOutlet weak var deliveryTime5: UILabel!
    @IBOutlet weak var deliveryTime6: UILabel!
    @IBOutlet weak var deliveryTime7: UILabel!
    @IBOutlet weak var deliveryTime8: UILabel!
    @IBOutlet weak var deliveryTime9: UILabel!
    
    @IBOutlet weak var deliveryChargesTextField: TextField!
 
    @IBOutlet weak var minOrderTExtfField: TextField!
    @IBOutlet weak var lessThanMinOrderTextField: TextField!
    let radioButtonController = SSRadioButtonsController()
    
    var storeProfileData = StoreProfileData()
    var startTextFieldArray = [UITextField]()
    var endTextFieldArray = [UITextField]()
    var textfieldArray = [UITextField]()
    var startLabelArray = [UILabel]()
    var endLabelArray = [UILabel]()
    var labelArray = [UILabel]()
    
//    var fromHourArray = [String]()
//    var toHourArray = [String]()
//    var fromMinArray = [UILabel]()
//    var toMinArray = [UILabel]()
      var deliveryTimeLabelArray = [UILabel]()
//    var deliveryTimeLabelArray = [UILabel]()
//    var deliveryTimeLabelArray = [UILabel]()
//    var deliveryTimeLabelArray = [UILabel]()
//    var deliveryTimeLabelArray = [UILabel]()
//    var deliveryTimeLabelArray = [UILabel]()
    
    var someGlobalNSInteger = Int()
    var i = Int()
    var getAM = String()
    var fromHour1 = "00"
    var fromMin1 = "00"
    var fromAmPm1 = "00"
    var fromHour2 = "00"
    var fromMin2 = "00"
    var fromAmPm2 = "00"
    var fromHour3 = "00"
    var fromMin3 = "00"
    var fromAmPm3 = "00"
    
    var toHour1 = "00"
    var toMin1 = "00"
    var toAmPm1 = "00"
    var toHour2 = "00"
    var toMin2 = "00"
    var toAmPm2 = "00"
    var toHour3 = "00"
    var toMin3 = "00"
    var toAmPm3 = "00"
    
    var delHour1 = "00"
    var delHour2 = "00"
    var delHour3 = "00"
    var delHour4 = "00"
    var delHour5 = "00"
    var delHour6 = "00"
    var delHour7 = "00"
    var delHour8 = "00"
    var delHour9 = "00"
    var delHour10 = "00"
    
    var deltoMin1 = "00"
    var deltoMin2 = "00"
    var deltoMin3 = "00"
    var deltoMin4 = "00"
    var deltoMin5 = "00"
    var deltoMin6 = "00"
    var deltoMin7 = "00"
    var deltoMin8 = "00"
    var deltoMin9 = "00"
    var deltoMin10 = "00"
    
    var delAmPm1 = "00"
    var delAmPm2 = "00"
    var delAmPm3 = "00"
    var delAmPm4 = "00"
    var delAmPm5 = "00"
    var delAmPm6 = "00"
    var delAmPm7 = "00"
    var delAmPm8 = "00"
    var delAmPm9 = "00"
    var delAmPm10 = "00"
 
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldArray = [deliveryTimeTextField0 , deliveryTimeTextField1 , deliveryTimeTextField2 , deliveryTimeTextField3 , deliveryTimeTextField4 , deliveryTimeTextField5, deliveryTimeTextField6 , deliveryTimeTextField7, deliveryTimeTextField8 , deliveryTimeTextField9 ]
        
        startTextFieldArray = [fromLabel1 , fromLabel2 , fromLabel3]
        endTextFieldArray = [toLabel1 , toLabel2 , toLabel3]
        
        deliveryTimeLabelArray = [deliveryTime0 , deliveryTime1 , deliveryTime2 , deliveryTime3 , deliveryTime4 , deliveryTime5 , deliveryTime6 , deliveryTime7 , deliveryTime8 , deliveryTime9]
        startLabelArray = [from1 , from2 , from3]
        endLabelArray = [to1 , to2 , to3]
        
       // businessTimingView.removeFromSuperview()
        radioButtonController.setButtonsArray([deliveryCharges , freeDelivery])
        radioButtonController.delegate = self
        radioButtonController.shouldLetDeSelect = true
        deliveryChargesContraint.constant = 0
        freeDeliveryContraint.constant = 0
        
        freeDeliveryView.hidden = true
        deliveryChargesView.hidden = true
        
        from1.hidden = false
        to1 .hidden = false
        fromLabel1.hidden = false
        toLabel1.hidden = false
        
        slideMenuShow(slideMenubButton, viewcontroller: self)
        
//        businessTimeingViewContraint.constant = 43
        
//        deliveryTimeTextField1.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        deliveryTimeTextField2.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        deliveryTimeTextField3.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        deliveryTimeTextField4.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        deliveryTimeTextField5.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        deliveryTimeTextField6.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        deliveryTimeTextField7.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        deliveryTimeTextField8.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        deliveryTimeTextField9.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        deliveryTimeTextField10.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        
//        fromLabel1.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        fromLabel2.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        fromLabel3.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        toLabel1.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        toLabel2.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//        toLabel3.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        
        
        deliveryTimeTextField0.delegate = self
        deliveryTimeTextField1.delegate = self
        deliveryTimeTextField2.delegate = self
        deliveryTimeTextField3.delegate = self
        deliveryTimeTextField4.delegate = self
        deliveryTimeTextField5.delegate = self
        deliveryTimeTextField6.delegate = self
        deliveryTimeTextField7.delegate = self
        deliveryTimeTextField8.delegate = self
        deliveryTimeTextField9.delegate = self

        fromLabel1.delegate = self
        fromLabel2.delegate = self
        fromLabel3.delegate = self
        toLabel1.delegate = self
        toLabel2.delegate = self
        toLabel3.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        
        self.showHud("Loading...")
        
        let params = [
            "token":token,
            "device_id":"1234",
        ]
        
        ServerManager.sharedInstance().vendorStoreProfile(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.storeProfileData = result!
               if !(self.storeProfileData.startingTime == "0"){
                    self.storeProfileGetdata()
                }
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deliveryTimeButton(sender: AnyObject) {
        
    }

    @IBAction func businessTimeButton(sender: AnyObject) {
        
        businessTimeingViewContraint.constant += businessViewConstant
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func formValidation() -> Bool {
        
        return true
    }
    
    func didSelectButton(aButton: UIButton?) {
        if aButton == deliveryCharges {
            deliveryChargesContraint.constant = 36
            freeDeliveryContraint.constant = 0
            freeDeliveryView.hidden = true
            deliveryChargesView.hidden = false
        }else{
            freeDeliveryContraint.constant = 112
            deliveryChargesContraint.constant = 0
            freeDeliveryView.hidden = false
            deliveryChargesView.hidden = true
        }
    }
    
    @IBAction func submitButtonClicked(sender: AnyObject) {
        
        self.showHud("Loading...")
        
        let params:[String:AnyObject] = [
        "token":token,
        "device_id":"1234",
        "store[0][from_hour]":fromHour1,
        "store[0][from_minute]":fromMin2,
        "store[0][from]":fromAmPm2,
        "store[0][end_hour]":toHour1,
        "store[0][end_minute]":toMin1,
        "store[0][to]":toAmPm1,
        "store[1][from_hour]":fromHour2,
        "store[1][from_minute]":fromMin2,
        "store[1][from]":fromAmPm2,
        "store[1][end_hour]":toHour2,
        "store[1][end_minute]":toMin2,
        "store[1][to]":toAmPm2,
        "store[2][from_hour]":fromHour3,
        "store[2][from_minute]":fromMin3,
        "store[2][from]":fromAmPm3,
        "store[2][end_hour]":toHour3,
        "store[2][end_minute]":toMin3,
        "store[2][to]":toAmPm3,
        "store[0][del_hour]":delHour1,
        "store[0][del_min]":deltoMin1,
        "store[0][del]":delAmPm1,
        "store[1][del_hour]":delHour2,
        "store[1][del_min]":deltoMin2,
        "store[1][del]":delAmPm2,
        "store[2][del_hour]":delHour3,
        "store[2][del_min]":deltoMin3,
        "store[2][del]":delAmPm3,
        "store[3][del_hour]":delHour4,
        "store[3][del_min]":deltoMin4,
        "store[3][del]":delAmPm4,
        "store[4][del_hour]":delHour5,
        "store[4][del_min]":deltoMin5,
        "store[4][del]":delAmPm5,
        "store[5][del_hour]":delHour6,
        "store[5][del_min]":deltoMin6,
        "store[5][del]":delAmPm6,
        "store[6][del_hour]":delHour7,
        "store[6][del_min]":deltoMin7,
        "store[6][del]":delAmPm7,
        "store[7][del_hour]":delHour8,
        "store[7][del_min]":deltoMin8,
        "store[7][del]":delAmPm8,
        "store[8][del_hour]":delHour9,
        "store[8][del_min]":deltoMin9,
        "store[8][del]":delAmPm9,
        "store[9][del_hour]":delHour10,
        "store[9][del_min]":deltoMin10,
        "store[9][del]":delAmPm10,
        "store[delchargesD]":"",
        "store[delchargesF]":"",
        "store[minimumOrders]":minOrderTExtfField.text!,
        "store[BusinessHolidays]":businessHolidayField.text!,
        "store[urgentDelivery]":expressDeliveryButton.text!
        ]

        print(params)
        
        ServerManager.sharedInstance().vendorStoreProfile(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    
    func pickUpDate(textField : UITextField){
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        datePickerView.backgroundColor = UIColor.whiteColor()
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(StoreProfileViewController.handleDatePicker1(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        someGlobalNSInteger = textField.tag
        pickUpDate(textField)
    }
    
    func handleDatePicker1(sender: UIDatePicker) {
     getHour = getHourFromDatePicker(sender)
     getMinute = getMinFromDatePicker(sender)
        
     let dateFormatter = NSDateFormatter()
     dateFormatter.dateFormat = "HH:mm"
    
        switch someGlobalNSInteger {
        case 0:
           fromHour1 = getHourFromDatePicker(sender)
           fromMin1 = getMinFromDatePicker(sender)
           date1 = sender.date
           if date1.compare(sender.date) == .OrderedDescending {
            
           }
           (fromHour1 , fromAmPm1) = conversionAmPm(fromHour1 , fromMin: fromMin1)
           print("\(fromHour1) + \(fromMin1) + \(fromAmPm1)")
           fromLabel1.text =  fromHour1 + " : " + fromMin1 + " " + fromAmPm1
        case 1:
            date2 = sender.date
            if fromLabel1.text == nil {
                AlertView.alertView("Alert", message: "First Enter the From Field", alertTitle: "OK", viewController: self)
                toLabel1.text = ""
            }
            if date1.compare(sender.date) == .OrderedDescending {
              AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                toLabel1.text = ""
            }else if date1.compare(sender.date) == .OrderedSame{
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                toLabel1.text = ""
            }else{
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            (toHour1 , toAmPm1) = conversionAmPm(toHour1 , fromMin: toMin1)
            print("\(toHour1) + \(toMin1) + \(toAmPm1)")
            toLabel1.text = toHour1 + " : " + toMin1 + " " + toAmPm1
            }
        case 2:
            fromHour2 = getHourFromDatePicker(sender)
            fromMin2 = getMinFromDatePicker(sender)
            
            date2 = sender.date
            if date2.compare(sender.date) == .OrderedDescending {
               
            }
            
            (fromHour2 , fromAmPm2) = conversionAmPm(fromHour2 , fromMin: fromMin2)
            print("\(fromHour3) + \(fromMin3) + \(fromAmPm3)")
            fromLabel2.text = fromHour2 + " : " + fromMin2 + " " + fromAmPm2
        case 3:
            date3 = sender.date
            
            if fromLabel2.text == nil {
                AlertView.alertView("Alert", message: "First Enter the From Field", alertTitle: "OK", viewController: self)
                toLabel2.text = ""
            }
            
            if date2.compare(sender.date) == .OrderedDescending {
               AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                toLabel2.text = ""
            }else if date1.compare(sender.date) == .OrderedSame{
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                toLabel2.text = ""
            }else{
            toHour2 = getHourFromDatePicker(sender)
            toMin2 = getMinFromDatePicker(sender)
            (toHour2 , toAmPm2) = conversionAmPm(toHour2 , fromMin: toMin2)
            toLabel2.text = toHour2 + " : " + toMin2 + " " + toAmPm2
            }
        case 4:
            fromHour3 = getHourFromDatePicker(sender)
            fromMin3 = getMinFromDatePicker(sender)
            date4 = sender.date
            if date3.compare(sender.date) == .OrderedDescending {
               
            }
            (fromHour3 , fromAmPm3) = conversionAmPm(fromHour3 , fromMin: fromMin3)
            fromLabel3.text = fromHour3 + " : " + fromMin3 + " " + fromAmPm3
        case 5:
            date5 = sender.date
            
            if fromLabel3.text == nil {
                AlertView.alertView("Alert", message: "First Enter the From Field", alertTitle: "OK", viewController: self)
                toLabel3.text = ""
            }

            if date4.compare(sender.date) == .OrderedDescending {
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                toLabel3.text = ""
            }else if date1.compare(sender.date) == .OrderedSame{
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                toLabel3.text = ""
            }else{
                toHour3 = getHourFromDatePicker(sender)
                toMin3 = getMinFromDatePicker(sender)
                (toHour3 , toAmPm3) = conversionAmPm(toHour3 , fromMin: toMin3)
                toLabel3.text = toHour3 + " : " + toMin3 + " " + toAmPm3
            }
        case 6:
            
            date6 = sender.date
            
            if sender.date.isBetweeen(date: date1, andDate: date2) || sender.date.isBetweeen(date: date3, andDate: date4) || sender.date.isBetweeen(date: date5, andDate: date6){
                delHour1 = getHourFromDatePicker(sender)
                deltoMin1 = getMinFromDatePicker(sender)
                (delHour1 , delAmPm1) = conversionAmPm(delHour1 , fromMin: deltoMin1)
                deliveryTimeTextField0.text = delHour1 + " : " + deltoMin1 + " " + delAmPm1
            }
            else{
               AlertView.alertView("Alert", message: "not between the provided dates", alertTitle: "OK", viewController: self)
            }

        case 7:
            date7 = sender.date
//            if date6.compare(sender.date) == .OrderedDescending {
//                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
//                deliveryTimeTextField1.text = ""
//            }else if date1.compare(sender.date) == .OrderedSame{
//                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
//                deliveryTimeTextField1.text = ""
//            }else{
                delHour2 = getHourFromDatePicker(sender)
                deltoMin2 = getMinFromDatePicker(sender)
            (delHour2 , delAmPm2) = conversionAmPm(delHour2 , fromMin: deltoMin2)
            deliveryTimeTextField1.text = delHour2 + " : " + deltoMin2 + " " + delAmPm2
//            }
        case 8:
            date8 = sender.date
//            if date7.compare(sender.date) == .OrderedDescending {
//                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
//                deliveryTimeTextField2.text = ""
//            }else if date1.compare(sender.date) == .OrderedSame{
//                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
//                deliveryTimeTextField2.text = ""
//            }else{
            delHour3 = getHourFromDatePicker(sender)
            deltoMin3 = getMinFromDatePicker(sender)
            (delHour3 , delAmPm3) = conversionAmPm(delHour3 , fromMin: deltoMin3)
            deliveryTimeTextField2.text = delHour3 + " : " + deltoMin3 + " " + delAmPm3
//            }
        case 9:
            date9 = sender.date
            if date8.compare(sender.date) == .OrderedDescending {
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField3.text = ""
            }else if date1.compare(sender.date) == .OrderedSame{
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField3.text = ""
            }else{
                delHour4 = getHourFromDatePicker(sender)
                deltoMin4 = getMinFromDatePicker(sender)
            (delHour4 , delAmPm4) = conversionAmPm(delHour4 , fromMin: deltoMin4)
            deliveryTimeTextField3.text = delHour4 + " : " + deltoMin4 + " " + delAmPm4
            }
        case 10:
            date10 = sender.date
            if date9.compare(sender.date) == .OrderedDescending {
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField4.text = ""
            }else if date1.compare(sender.date) == .OrderedSame{
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField4.text = ""
            }else{
            delHour5 = getHourFromDatePicker(sender)
            deltoMin5 = getMinFromDatePicker(sender)
            (delHour5 , delAmPm5) = conversionAmPm(delHour5 , fromMin: deltoMin5)
            deliveryTimeTextField4.text = delHour5 + " : " + deltoMin5 + " " + delAmPm5
            }
        case 11:
            date11 = sender.date
            if date10.compare(sender.date) == .OrderedDescending {
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField5.text = ""
            }else if date1.compare(sender.date) == .OrderedSame{
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField5.text = ""
            }else{
                delHour6 = getHourFromDatePicker(sender)
                deltoMin6 = getMinFromDatePicker(sender)
            (delHour6 , delAmPm6) = conversionAmPm(delHour6 , fromMin: deltoMin6)
            deliveryTimeTextField5.text = delHour6 + " : " + deltoMin6 + " " + delAmPm6
            }
        case 12:
            date12 = sender.date
            if date11.compare(sender.date) == .OrderedDescending {
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField6.text = ""
            }else if date1.compare(sender.date) == .OrderedSame{
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField6.text = ""
            }else{
                delHour7 = getHourFromDatePicker(sender)
                deltoMin7 = getMinFromDatePicker(sender)
            (delHour7 , delAmPm7) = conversionAmPm(delHour7 , fromMin: deltoMin7)
            deliveryTimeTextField6.text = delHour7 + " : " + deltoMin7 + " " + delAmPm7
            }
        case 13:
            date13 = sender.date
            if date12.compare(sender.date) == .OrderedDescending {
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField7.text = ""
            }else if date1.compare(sender.date) == .OrderedSame{
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField7.text = ""
            }else{
                delHour8 = getHourFromDatePicker(sender)
                deltoMin8 = getMinFromDatePicker(sender)
            (delHour8 , delAmPm8) = conversionAmPm(delHour8 , fromMin: deltoMin8)
            deliveryTimeTextField7.text = delHour8 + " : " + deltoMin8 + " " + delAmPm8
            }
        case 14:
            date14 = sender.date
            if date13.compare(sender.date) == .OrderedDescending {
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField8.text = ""
            }else if date1.compare(sender.date) == .OrderedSame{
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField8.text = ""
            }else{
            
                delHour9 = getHourFromDatePicker(sender)
                deltoMin9 = getMinFromDatePicker(sender)
            (delHour9 , delAmPm9) = conversionAmPm(delHour9 , fromMin: deltoMin9)
            deliveryTimeTextField8.text = delHour9 + " : " + deltoMin9 + " " + delAmPm9
            }
        case 15:
            date15 = sender.date
            if date14.compare(sender.date) == .OrderedDescending {
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField9.text = ""
            }else if date1.compare(sender.date) == .OrderedSame{
                AlertView.alertView("Alert", message: "From is earlier than To", alertTitle: "OK", viewController: self)
                deliveryTimeTextField9.text = ""
            }else{
                delHour10 = getHourFromDatePicker(sender)
                deltoMin10 = getMinFromDatePicker(sender)
            (delHour10 , delAmPm10) = conversionAmPm(delHour10 , fromMin: deltoMin10)
            deliveryTimeTextField9.text = delHour10 + " : " + deltoMin10 + " " + delAmPm10
            }
        default:
            ""
        }
    }
    
    func conversionAmPm(fromHour:String, fromMin:String) -> (String , String) {
            let a:Int? = Int(fromHour)
            var amOrPm = ""
            var fromHour1 = Int()
            var fromHour2 = String()
        
//        var fromMin1 = String()
        
//        if fromHour == "" && fromMin == "" {
//            fromHour1 == 00
//            //fromMin1 = "00"
//        }
    
            if a > 12 {
                fromHour1 = a! - 12
                amOrPm = "PM"
            }else if a == 12 {
                fromHour1 = 12
                amOrPm = "PM"
            }else if a == 0 {
                fromHour1 = 12
                amOrPm = "AM"
            }else{
                fromHour1 = a!
                amOrPm = "AM"
            }
            
            fromHour2 = String(fromHour1)
            
            return (fromHour2,amOrPm)
            
        }
    
    func getHourFromDatePicker(datePicker:UIDatePicker) -> String
    {
        let date = datePicker.date
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date)
        
        return "\(components.hour)"
    }
    
    func getMinFromDatePicker(datePicker:UIDatePicker) -> String
    {
        let date = datePicker.date
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date)
        
        return "\(components.minute)"
    }
    
    func storeProfileGetdata() {
        
        if let businesHoliday = self.storeProfileData.businessHoliday as? String {
            businessHolidayField.text = businesHoliday
        }
        
        if let businesHoliday = self.storeProfileData.expressDelivery as? String {
            expressDeliveryButton.text = businesHoliday
        }
        
        if let businesHoliday = self.storeProfileData.deliveryCharges as? String {
            deliveryChargesTextField.text = businesHoliday
        }
        
        if let businesHoliday = self.storeProfileData.minimum_order as? String {
            minOrderTExtfField.text = businesHoliday
        }
        
        for i in 0..<self.storeProfileData.startTime.count {
            if !(self.storeProfileData.startTime[i].from_hour == "00" && self.storeProfileData.startTime[i].from_minute == "00") {
            self.startTextFieldArray[i].text = self.storeProfileData.startTime[i].from_hour + " : " + self.storeProfileData.startTime[i].from_minute + " " + self.storeProfileData.startTime[i].from
//                businessTimeingViewContraint.constant = businessViewConstant * CGFloat(i)
            }else{
//                self.startTextFieldArray[i].removeFromSuperview()
//                self.startLabelArray[i].removeFromSuperview()
//                businessTimeingViewContraint.constant = businessViewConstant
            }
        }
        
        for i in 0..<self.storeProfileData.endTime.count {
            if !(self.storeProfileData.endTime[i].end_hour == "00" && self.storeProfileData.endTime[i].end_minute == "00"){
            self.endTextFieldArray[i].text = self.storeProfileData.endTime[i].end_hour + " : " + self.storeProfileData.endTime[i].end_minute + " " + self.storeProfileData.endTime[i].to
//                businessTimeingViewContraint.constant = businessViewConstant * CGFloat(i)
            }else{
//                self.endTextFieldArray[i].removeFromSuperview()
//                self.endLabelArray[i].removeFromSuperview()
//                businessTimeingViewContraint.constant = businessViewConstant
            }
        }
        
        for i in 0..<self.storeProfileData.deliveryTime.count {
            if !(self.storeProfileData.deliveryTime[i].del_hour == "00" && self.storeProfileData.deliveryTime[i].del_min == "00"){
            self.textfieldArray[i].text = self.storeProfileData.deliveryTime[i].del_hour + " : " + self.storeProfileData.deliveryTime[i].del_min + " " + self.storeProfileData.deliveryTime[i].del
//                businessTimeingViewContraint.constant = businessViewConstant * CGFloat(i)
            }else{
//                self.textfieldArray[i].removeFromSuperview()
//                self.deliveryTimeLabelArray[i].removeFromSuperview()
//                businessTimeingViewContraint.constant = businessViewConstant
            }
        }
        
    }
    
    
    
    
    
    
    
}
