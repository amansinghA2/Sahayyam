//
//  StoreProfileViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class StoreProfileViewController: UIViewController , SSRadioButtonControllerDelegate , UITextFieldDelegate{
    
    
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
    var deliveryTimeLabelArray = [UILabel]()
    var someGlobalNSInteger = Int()
    var i = Int()
    var getAM = String()
    var fromHour1 = ""
    var fromMin1 = ""
    var fromAmPm1 = ""
    var fromHour2 = ""
    var fromMin2 = ""
    var fromAmPm2 = ""
    var fromHour3 = ""
    var fromMin3 = ""
    var fromAmPm3 = ""
    
    var toHour1 = ""
    var toMin1 = ""
    var toAmPm1 = ""
    var toHour2 = ""
    var toMin2 = ""
    var toAmPm2 = ""
    var toHour3 = ""
    var toMin3 = ""
    var toAmPm3 = ""
    
    var delHour1 = ""
    var delHour2 = ""
    var delHour3 = ""
    var delHour4 = ""
    var delHour5 = ""
    var delHour6 = ""
    var delHour7 = ""
    var delHour8 = ""
    var delHour9 = ""
    var delHour10 = ""
    
    var deltoMin1 = ""
    var deltoMin2 = ""
    var deltoMin3 = ""
    var deltoMin4 = ""
    var deltoMin5 = ""
    var deltoMin6 = ""
    var deltoMin7 = ""
    var deltoMin8 = ""
    var deltoMin9 = ""
    var deltoMin10 = ""
    
    var delAmPm1 = ""
    var delAmPm2 = ""
    var delAmPm3 = ""
    var delAmPm4 = ""
    var delAmPm5 = ""
    var delAmPm6 = ""
    var delAmPm7 = ""
    var delAmPm8 = ""
    var delAmPm9 = ""
    var delAmPm10 = ""
 
    override func viewDidLoad() {
        super.viewDidLoad()
        textfieldArray = [deliveryTimeTextField0 , deliveryTimeTextField1 , deliveryTimeTextField2 , deliveryTimeTextField3 , deliveryTimeTextField4 , deliveryTimeTextField5, deliveryTimeTextField6 , deliveryTimeTextField7, deliveryTimeTextField8 , deliveryTimeTextField9 ]
        
        startTextFieldArray = [fromLabel1 , fromLabel2 , fromLabel3]
        endTextFieldArray = [toLabel1 , toLabel2 , toLabel3]
        
        deliveryTimeLabelArray = [deliveryTime0 , deliveryTime1 , deliveryTime2 , deliveryTime3 , deliveryTime4 , deliveryTime5 , deliveryTime6 , deliveryTime7 , deliveryTime8 , deliveryTime9]
        startLabelArray = [from1 , from2 , from3]
        endLabelArray = [to1 , to2 , to3]
        labelArray = []
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
        
        //businessTimeingViewContraint.constant = 43
        
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
        
//      fromLabel1.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//      fromLabel2.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//      fromLabel3.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//      toLabel1.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//      toLabel2.setTextFieldStyle(TextFieldStyle.TextFieldTime)
//      toLabel3.setTextFieldStyle(TextFieldStyle.TextFieldTime)
        
        
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
                print(self.storeProfileData)
                self.storeProfileGetdata()
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
        
        let params = [
        "token":token,
        "device_id":"1234",
        "store[0][from_hour]":"",
        "store[0][from_minute]":"",
        "store[0][from]":"",
        "store[0][end_hour]":"",
        "store[0][end_minute]":"",
        "store[0][to]":"",
        "store[1][from_hour]":"",
        "store[1][from_minute]":"",
        "store[1][from]":"",
        "store[1][end_hour]":"",
        "store[1][end_minute]":"",
        "store[1][to]":"",
        "store[2][from_hour]":"",
        "store[2][from_minute]":"",
        "store[2][from]":"",
        "store[2][end_hour]":"",
        "store[2][end_minute]":"",
        "store[2][to]":"",
        "store[0][del_hour]":"",
        "store[0][del_min]":"",
        "store[0][del]":"",
        "store[1][del_hour]":"",
        "store[1][del_min]":"",
        "store[1][del]":"",
        "store[2][del_hour]":"",
        "store[2][del_min]":"",
        "store[2][del]":"",
        "store[3][del_hour]":"",
        "store[3][del_min]":"",
        "store[3][del]":"",
        "store[4][del_hour]":"",
        "store[4][del_min]":"",
        "store[4][del]":"",
        "store[5][del_hour]":"",
        "store[5][del_min]":"",
        "store[5][del]":"",
        "store[6][del_hour]":"",
        "store[6][del_min]":"",
        "store[6][del]":"",
        "store[7][del_hour]":"",
        "store[7][del_min]":"",
        "store[7][del]":"",
        "store[8][del_hour]":"",
        "store[8][del_min]":"",
        "store[8][del]":"",
        "store[9][del_hour]":"",
        "store[9][del_min]":"",
        "store[9][del]":"",
        "store[10][del_hour]":"",
        "store[10][del_min]":"",
        "store[10][del]":"",
        ]
        
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
//    let locale = NSLocale(localeIdentifier: "NL")
//    sender.locale = locale
        
   // dateFormatter.timeStyle = .ShortStyle
    
        switch someGlobalNSInteger {
        case 0:
           fromHour1 = getHourFromDatePicker(sender)
           fromMin1 = getMinFromDatePicker(sender)
           (fromHour1 , fromAmPm1) = conversionAmPm(fromHour1 , fromMin: fromMin1)
           print("\(fromHour1) + \(fromMin1) + \(fromAmPm1)")
           fromLabel1.text =  fromHour1 + " : " + fromMin1 + " " + fromAmPm1   //dateFormatter.stringFromDate(sender.date)
        case 1:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            (toHour1 , toAmPm1) = conversionAmPm(toHour1 , fromMin: toMin1)
            print("\(toHour1) + \(toMin1) + \(toAmPm1)")
            toLabel1.text = dateFormatter.stringFromDate(sender.date)
        case 2:
            fromHour2 = getHourFromDatePicker(sender)
            fromMin2 = getMinFromDatePicker(sender)
            (fromHour2 , fromMin2) = conversionAmPm(fromHour2 , fromMin: fromMin2)
            print("\(fromHour3) + \(fromMin3) + \(fromAmPm3)")
            fromLabel2.text = dateFormatter.stringFromDate(sender.date)
        case 3:
            toHour2 = getHourFromDatePicker(sender)
            toMin2 = getMinFromDatePicker(sender)
            toLabel2.text = dateFormatter.stringFromDate(sender.date)
        case 4:
            fromHour3 = getHourFromDatePicker(sender)
            fromMin3 = getMinFromDatePicker(sender)
            fromLabel3.text = dateFormatter.stringFromDate(sender.date)
        case 5:
            toHour3 = getHourFromDatePicker(sender)
            toMin3 = getMinFromDatePicker(sender)
            toLabel3.text = dateFormatter.stringFromDate(sender.date)
        case 6:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            deliveryTimeTextField0.text = dateFormatter.stringFromDate(sender.date)
        case 7:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            deliveryTimeTextField1.text = dateFormatter.stringFromDate(sender.date)
        case 8:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            deliveryTimeTextField2.text = dateFormatter.stringFromDate(sender.date)
        case 9:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            deliveryTimeTextField3.text = dateFormatter.stringFromDate(sender.date)
        case 10:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            deliveryTimeTextField4.text = dateFormatter.stringFromDate(sender.date)
        case 11:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            deliveryTimeTextField5.text = dateFormatter.stringFromDate(sender.date)
        case 12:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            deliveryTimeTextField6.text = dateFormatter.stringFromDate(sender.date)
        case 13:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            deliveryTimeTextField7.text = dateFormatter.stringFromDate(sender.date)
        case 14:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            deliveryTimeTextField8.text = dateFormatter.stringFromDate(sender.date)
        case 15:
            toHour1 = getHourFromDatePicker(sender)
            toMin1 = getMinFromDatePicker(sender)
            deliveryTimeTextField9.text = dateFormatter.stringFromDate(sender.date)
        default:
            ""
        }
 
    }
    func conversionAmPm(fromHour:String, fromMin:String) -> (String , String) {
            let a:Int? = Int(fromHour)
            var amOrPm = ""
            var fromHour1 = Int()
            var fromHour2 = String()
            
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
        
        for i in 0...2 {
            if !(self.storeProfileData.startTime[i].from_hour == "00" && self.storeProfileData.startTime[i].from_minute == "00") {
            self.startTextFieldArray[i].text = self.storeProfileData.startTime[i].from_hour + " : " + self.storeProfileData.startTime[i].from_minute + " " + self.storeProfileData.startTime[i].from
                businessTimeingViewContraint.constant = businessViewConstant * CGFloat(i)
            }else{
                self.startTextFieldArray[i].removeFromSuperview()
                self.startLabelArray[i].removeFromSuperview()
                businessTimeingViewContraint.constant = businessViewConstant
            }
        }
        
        for i in 0...2 {
            
            if !(self.storeProfileData.endTime[i].end_hour == "00" && self.storeProfileData.endTime[i].end_minute == "00"){
            self.endTextFieldArray[i].text = self.storeProfileData.endTime[i].end_hour + " : " + self.storeProfileData.endTime[i].end_minute + " " + self.storeProfileData.endTime[i].to
                businessTimeingViewContraint.constant = businessViewConstant * CGFloat(i)
            }else{
               self.endTextFieldArray[i].removeFromSuperview()
               self.endLabelArray[i].removeFromSuperview()
                businessTimeingViewContraint.constant = businessViewConstant
            }
        }
        
        for i in 0...9 {
            
            if !(self.storeProfileData.deliveryTime[i].del_hour == "00" && self.storeProfileData.deliveryTime[i].del_min == "00"){
            self.textfieldArray[i].text = self.storeProfileData.deliveryTime[i].del_hour + " : " + self.storeProfileData.deliveryTime[i].del_min + " " + self.storeProfileData.deliveryTime[i].del
               businessTimeingViewContraint.constant = businessViewConstant * CGFloat(i)
            }else{
                self.textfieldArray[i].removeFromSuperview()
                self.deliveryTimeLabelArray[i].removeFromSuperview()
               businessTimeingViewContraint.constant = businessViewConstant
            }
        }
        
        
    }
    
    
    
}
