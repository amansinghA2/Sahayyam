//
//  StoreProfileViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class StoreProfileViewController: UIViewController , SSRadioButtonControllerDelegate , UITextFieldDelegate{

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
    
    
    @IBOutlet weak var deliveryChargesTextField: TextField!
 
    @IBOutlet weak var minOrderTExtfField: TextField!
    @IBOutlet weak var lessThanMinOrderTextField: TextField!
    let radioButtonController = SSRadioButtonsController()
    
    var storeProfileData = StoreProfileData()
    var textfieldArray = [UITextField]()
    
    var getHour = String()
    var getMinute = String()
    var getAM = String()
    
    var fromHour1 = ""
    var fromMin1 = ""
    var fromHour2 = ""
    var fromMin2 = ""
    var fromHour3 = ""
    var fromMin3 = ""
    
    var toHour1 = ""
    var toMin1 = ""
    var toHour2 = ""
    var toMin2 = ""
    var toHour3 = ""
    var toMin3 = ""
    
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
        
        radioButtonController.setButtonsArray([deliveryCharges , freeDelivery])
        radioButtonController.delegate = self
        radioButtonController.shouldLetDeSelect = true
        deliveryChargesContraint.constant = 0
        freeDeliveryContraint.constant = 0
        
        freeDeliveryView.hidden = true
        deliveryChargesView.hidden = true
        
        slideMenuShow(slideMenubButton, viewcontroller: self)
        
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
//        
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
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Time
        datePickerView.backgroundColor = UIColor.whiteColor()
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(StoreProfileViewController.handleDatePicker1(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        let dateFormatter = NSDateFormatter()
        
        if textField.text!.isEmpty {
            let currentDate = textField.text
            let date = dateFormatter.dateFromString(currentDate!)
            datePickerView.setDate(date!, animated: false)
        }
        
        dateFormatter.timeStyle = .ShortStyle
        textField.text = dateFormatter.stringFromDate(datePickerView.date)
        
    }
    
    func handleDatePicker1(sender: UIDatePicker) {
     getHour = getHourFromDatePicker(sender)
     getMinute = getMinFromDatePicker(sender)
        
    //sender.text = dateFormatter.stringFromDate(sender.date)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        switch textField {
        case fromLabel1:
            fromHour1 = getHour
            fromMin1 = getMinute
        case fromLabel2:
            fromHour2 = getHour
            fromMin2 = getMinute
        case fromLabel3:
            fromHour3 = getHour
            fromMin3 = getMinute
        case toLabel1:
            toHour1 = getHour
            toMin1 = getMinute
        case toLabel2:
            toHour2 = getHour
            toMin2 = getMinute
        case toLabel3:
            toHour3 = getHour
            toMin3 = getMinute
        case deliveryTimeTextField0:
            ""
        case deliveryTimeTextField1:
            ""
        case deliveryTimeTextField2:
            ""
        case deliveryTimeTextField3:
            ""
        case deliveryTimeTextField4:
            ""
        case deliveryTimeTextField5:
            ""
        case deliveryTimeTextField6:
            ""
        case deliveryTimeTextField7:
            ""
        case deliveryTimeTextField8:
            ""
        case deliveryTimeTextField9:
            ""
        default:
            ""
        }
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
            self.textfieldArray[i].text = self.storeProfileData.deliveryTime[i].del_hour + self.storeProfileData.deliveryTime[i].del_min + self.storeProfileData.deliveryTime[i].del
        }
        
        self.fromLabel1.text = self.storeProfileData.startTime[0].from_hour + self.storeProfileData.startTime[0].from_minute + self.storeProfileData.startTime[0].from
        
        self.fromLabel2.text = self.storeProfileData.startTime[1].from_hour + self.storeProfileData.startTime[1].from_minute + self.storeProfileData.startTime[1].from
        
        self.fromLabel3.text = self.storeProfileData.startTime[2].from_hour + self.storeProfileData.startTime[2].from_minute + self.storeProfileData.startTime[2].from
        
        self.toLabel1.text = self.storeProfileData.endTime[0].end_hour + self.storeProfileData.endTime[0].end_minute + self.storeProfileData.endTime[0].to
        
        self.toLabel2.text = self.storeProfileData.endTime[1].end_hour + self.storeProfileData.endTime[1].end_minute + self.storeProfileData.endTime[1].to
        
        self.toLabel3.text = self.storeProfileData.endTime[2].end_hour + self.storeProfileData.endTime[2].end_minute + self.storeProfileData.endTime[2].to
        
        
        
        for i in 0...9 {
            self.textfieldArray[i].text = self.storeProfileData.deliveryTime[i].del_hour + self.storeProfileData.deliveryTime[i].del_min + self.storeProfileData.deliveryTime[i].del
        }
        
        
    }
    
    
    
}
