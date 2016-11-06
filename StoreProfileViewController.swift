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

    var toDate1 = ""
    var toDate2 = ""
    var toDate3 = ""
    var fromDate1 = ""
    var fromDate2 = ""
    var fromDate3 = ""

    var storeProfileData = StoreProfileData()
    var startTextFieldArray = [UITextField]()
    var endTextFieldArray = [UITextField]()
    var textfieldArray = [UITextField]()
    var startLabelArray = [UILabel]()
    var endLabelArray = [UILabel]()
    var labelArray = [UILabel]()

    var fromHourArray = [String]()
    var fromMinArray = [String]()
    var fromAmPmArray = [String]()
    var toHourArray = [String]()
    var toMinArray = [String]()
    var toAmPmArray = [String]()
    var delHourArray = [String]()
    var delMinArray = [String]()
    var delAmPmArray = [String]()

    var delOrFreeCharges = String()

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

        fromHourArray = [fromHour1 , fromHour2 , fromHour3]
        toHourArray = [toHour1 , toHour2 , toHour3]
        fromMinArray = [fromMin1 , fromMin2 , fromMin3]
        toMinArray = [toMin1 , toMin2 , toMin3]
        fromAmPmArray = [fromAmPm1 , fromAmPm2 , fromAmPm3]
        toAmPmArray = [toAmPm1 , toAmPm2 , toAmPm3]

        delHourArray = [delHour1 , delHour2 , delHour3 , delHour4 , delHour5 , delHour6 , delHour7 , delHour8 , delHour9 , delHour10]
        delMinArray = [deltoMin1 , deltoMin2 , deltoMin3 , deltoMin4 , deltoMin5 , deltoMin6 , deltoMin7 , deltoMin8 , deltoMin9 , deltoMin10]
        delAmPmArray = [delAmPm1 , delAmPm2 , delAmPm3 , delAmPm4 , delAmPm5 , delAmPm6 , delAmPm7 , delAmPm8 , delAmPm9 , delAmPm10]


        // businessTimingView.removeFromSuperview()
        radioButtonController.setButtonsArray([deliveryCharges , freeDelivery])
        radioButtonController.delegate = self
        //radioButtonController.shouldLetDeSelect = true
        deliveryChargesContraint.constant = 0
        freeDeliveryContraint.constant = 0
        deliveryCharges.selected = true


        fromDate1 = fromLabel1.text!
        toDate1 = toLabel1.text!
        fromDate2 = fromLabel2.text!
        toDate2 = toLabel2.text!
        fromDate3 = fromLabel3.text!
        toDate3 = toLabel3.text!

        freeDeliveryView.hidden = true
        deliveryChargesView.hidden = false
        delOrFreeCharges = "D"
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

        ServerManager.sharedInstance().vendorStoreProfileGetData(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.storeProfileData = result!
                //               if !(self.storeProfileData.startingTime == "0"){
                self.storeProfileGetdata()
                //                }
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

        if let fromLabel = toLabel1.text where !fromLabel.isEmpty{
            if !(earlierAndAfterDate(fromLabel1.text!, to: toLabel1.text!, dateString: "")){
                fromLabel1.text = ""
                toLabel1.text = ""
                //            AlertView.alertView("Alert", message: "To is greater than from", alertTitle: "OK", viewController: self)
                return false
            }
        }


        if let fromLabel = toLabel2.text where !fromLabel.isEmpty{
            if !(earlierAndAfterDate(fromLabel2.text!, to: toLabel2.text!, dateString: "")) {
                toLabel2.text = ""
                fromLabel2.text = ""
                //            AlertView.alertView("Alert", message: "To is greater than from", alertTitle: "OK", viewController: self)
                return false
            }
        }


        if let fromLabel = toLabel3.text where !fromLabel.isEmpty{
            if !(earlierAndAfterDate(fromLabel3.text!, to: toLabel3.text!, dateString: "")) {
                toLabel3.text = ""
                fromLabel3.text = ""
                //            AlertView.alertView("Alert", message: "To is greater than from", alertTitle: "OK", viewController: self)
            }
        }


        if let fromLabel = deliveryTimeTextField0.text where !fromLabel.isEmpty{
            if !checkDeliveryTime(deliveryTimeTextField0.text!){
                deliveryTimeTextField0.text = ""
                //            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
                return false
            }
        }


        if let fromLabel = deliveryTimeTextField1.text where !fromLabel.isEmpty{
            if !checkDeliveryTime(deliveryTimeTextField1
                .text!){
                deliveryTimeTextField1.text = ""
                //            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
                return false
            }
        }


        if let fromLabel = deliveryTimeTextField2.text where !fromLabel.isEmpty{
            if !checkDeliveryTime(deliveryTimeTextField2.text!){
                deliveryTimeTextField2.text = ""
                //            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
                return false
            }
        }


        if let fromLabel = deliveryTimeTextField3.text where !fromLabel.isEmpty{
            if !checkDeliveryTime(deliveryTimeTextField3.text!){
                deliveryTimeTextField3.text = ""
                //            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
                return false
            }
        }

        if let fromLabel = deliveryTimeTextField4.text where !fromLabel.isEmpty{
            if !checkDeliveryTime(deliveryTimeTextField4.text!){
                deliveryTimeTextField4.text = ""
                //            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
                return false
            }
        }

        if let fromLabel = deliveryTimeTextField5.text where !fromLabel.isEmpty{
            if !checkDeliveryTime(deliveryTimeTextField5.text!){
                deliveryTimeTextField5.text = ""
                //            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
                return false
            }
        }


        if let fromLabel = deliveryTimeTextField6.text where !fromLabel.isEmpty{
            if !checkDeliveryTime(deliveryTimeTextField6.text!){
                deliveryTimeTextField6.text = ""
                //            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
                return false
            }
        }

        if let fromLabel = deliveryTimeTextField7.text where !fromLabel.isEmpty{
            if !checkDeliveryTime(deliveryTimeTextField7.text!){
                deliveryTimeTextField7.text = ""
                //            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
                return false
            }
        }

        if let fromLabel = deliveryTimeTextField8.text where !fromLabel.isEmpty{
            if !checkDeliveryTime(deliveryTimeTextField8.text!){
                deliveryTimeTextField8.text = ""
                //            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
                return false
            }
        }


        if let fromLabel = deliveryTimeTextField9.text where !fromLabel.isEmpty{
            if !checkDeliveryTime(deliveryTimeTextField9.text!){
                deliveryTimeTextField9.text = ""
                //            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
                return false
            }
        }

        return true
    }

    func didSelectButton(aButton: UIButton?) {
        if aButton == deliveryCharges {
            delOrFreeCharges = "D"
            deliveryChargesContraint.constant = 36
            freeDeliveryContraint.constant = 0
            freeDeliveryView.hidden = true
            deliveryChargesView.hidden = false
        }else{
            delOrFreeCharges = "F"
            freeDeliveryContraint.constant = 112
            deliveryChargesContraint.constant = 0
            freeDeliveryView.hidden = false
            deliveryChargesView.hidden = true
        }
    }

    @IBAction func submitButtonClicked(sender: AnyObject) {

        self.showHud("Loading...")

        if let fromLabel = fromLabel1.text where !fromLabel.isEmpty{
            fromHour1 = getHourFromDatePicker(fromLabel)
            fromMin1 = getMinFromDatePicker(fromLabel)
            (fromHour1 , fromAmPm1) = conversionAmPm(fromHour1 , fromMin: fromMin1)
        }

        if let fromLabel = fromLabel2.text where !fromLabel.isEmpty{
            fromHour2 = getHourFromDatePicker(fromLabel)
            fromMin2 = getMinFromDatePicker(fromLabel)
            (fromHour2 , fromAmPm2) = conversionAmPm(fromHour2 , fromMin: fromMin2)
            print(fromHour2)
            print(fromMin2)
        }

        if let fromLabel = fromLabel3.text where !fromLabel.isEmpty{
            fromHour3 = getHourFromDatePicker(fromLabel)
            fromMin3 = getMinFromDatePicker(fromLabel)
            (fromHour3 , fromAmPm3) = conversionAmPm(fromHour3 , fromMin: fromMin3)
        }

        if let fromLabel = toLabel1.text where !fromLabel.isEmpty{
            toHour1 = getHourFromDatePicker(fromLabel)
            toMin1 = getMinFromDatePicker(fromLabel)
            (toHour1 , toAmPm1) = conversionAmPm(toHour1 , fromMin: toMin1)
        }

        if let fromLabel = toLabel2.text where !fromLabel.isEmpty{
            toHour2 = getHourFromDatePicker(fromLabel)
            toMin2 = getMinFromDatePicker(fromLabel)
            (toHour2 , toAmPm2) = conversionAmPm(toHour2 , fromMin: toMin2)
        }

        if let fromLabel = toLabel3.text where !fromLabel.isEmpty{
            toHour3 = getHourFromDatePicker(fromLabel)
            toMin3 = getMinFromDatePicker(fromLabel)
            (toHour3 , toAmPm3) = conversionAmPm(toHour3 , fromMin: toMin3)
        }

        if let fromLabel = deliveryTimeTextField0.text where !fromLabel.isEmpty{
            delHour1 = getHourFromDatePicker(fromLabel)
            deltoMin1 = getMinFromDatePicker(fromLabel)
            (delHour1 , delAmPm1) = conversionAmPm(delHour1 , fromMin: deltoMin1)
        }

        if let fromLabel = deliveryTimeTextField1.text where !fromLabel.isEmpty{
            delHour2 = getHourFromDatePicker(fromLabel)
            deltoMin2 = getMinFromDatePicker(fromLabel)
            (delHour2 , delAmPm2) = conversionAmPm(delHour2 , fromMin: deltoMin2)
        }

        if let fromLabel = deliveryTimeTextField2.text where !fromLabel.isEmpty{
            delHour3 = getHourFromDatePicker(fromLabel)
            deltoMin3 = getMinFromDatePicker(fromLabel)
            (delHour3 , delAmPm3) = conversionAmPm(delHour3 , fromMin: deltoMin3)
        }

        if let fromLabel = deliveryTimeTextField3.text where !fromLabel.isEmpty{
            delHour4 = getHourFromDatePicker(fromLabel)
            deltoMin4 = getMinFromDatePicker(fromLabel)
            (delHour4 , delAmPm4) = conversionAmPm(delHour4 , fromMin: deltoMin4)
        }

        if let fromLabel = deliveryTimeTextField4.text where !fromLabel.isEmpty{
            delHour5 = getHourFromDatePicker(fromLabel)
            deltoMin5 = getMinFromDatePicker(fromLabel)
            (delHour5 , delAmPm5) = conversionAmPm(delHour5 , fromMin: deltoMin5)
        }

        if let fromLabel = deliveryTimeTextField5.text where !fromLabel.isEmpty{
            delHour6 = getHourFromDatePicker(fromLabel)
            deltoMin6 = getMinFromDatePicker(fromLabel)
            (delHour6 , delAmPm6) = conversionAmPm(delHour6 , fromMin: deltoMin6)
        }

        if let fromLabel = deliveryTimeTextField6.text where !fromLabel.isEmpty{
            delHour7 = getHourFromDatePicker(fromLabel)
            deltoMin7 = getMinFromDatePicker(fromLabel)
            (delHour7 , delAmPm7) = conversionAmPm(delHour7 , fromMin: deltoMin7)
        }

        if let fromLabel = deliveryTimeTextField7.text where !fromLabel.isEmpty{
            delHour8 = getHourFromDatePicker(fromLabel)
            deltoMin8 = getMinFromDatePicker(fromLabel)
            (delHour8 , delAmPm8) = conversionAmPm(delHour8 , fromMin: deltoMin8)
        }

        if let fromLabel = deliveryTimeTextField8.text where !fromLabel.isEmpty{
            delHour9 = getHourFromDatePicker(fromLabel)
            deltoMin9 = getMinFromDatePicker(fromLabel)
            (delHour9 , delAmPm9) = conversionAmPm(delHour9 , fromMin: deltoMin9)
        }

        if let fromLabel = deliveryTimeTextField9.text where !fromLabel.isEmpty{
            delHour10 = getHourFromDatePicker(fromLabel)
            deltoMin10 = getMinFromDatePicker(fromLabel)
            (delHour10 , delAmPm10) = conversionAmPm(delHour10 , fromMin: deltoMin10)
        }

        //        delHour1 = getHourFromDatePicker(deliveryTimeTextField0.text!)
        //        deltoMin1 = getHourFromDatePicker(deliveryTimeTextField0.text!)
        //        delHour2 = getHourFromDatePicker(deliveryTimeTextField1.text!)
        //        deltoMin2 = getHourFromDatePicker(deliveryTimeTextField1.text!)
        //        delHour3 = getHourFromDatePicker(deliveryTimeTextField2.text!)
        //        deltoMin3 = getHourFromDatePicker(deliveryTimeTextField2.text!)
        //        delHour4 = getHourFromDatePicker(deliveryTimeTextField3.text!)
        //        deltoMin4 = getHourFromDatePicker(deliveryTimeTextField3.text!)
        //        delHour5 = getHourFromDatePicker(deliveryTimeTextField4.text!)
        //        deltoMin5 = getHourFromDatePicker(deliveryTimeTextField4.text!)
        //        delHour6 = getHourFromDatePicker(deliveryTimeTextField5.text!)
        //        deltoMin6 = getHourFromDatePicker(deliveryTimeTextField5.text!)
        //        delHour7 = getHourFromDatePicker(deliveryTimeTextField6.text!)
        //        deltoMin7 = getHourFromDatePicker(deliveryTimeTextField6.text!)
        //        delHour8 = getHourFromDatePicker(deliveryTimeTextField7.text!)
        //        deltoMin8 = getHourFromDatePicker(deliveryTimeTextField7.text!)
        //        delHour9 = getHourFromDatePicker(deliveryTimeTextField8.text!)
        //        deltoMin9 = getHourFromDatePicker(deliveryTimeTextField8.text!)
        //        delHour10 = getHourFromDatePicker(deliveryTimeTextField9.text!)
        //        deltoMin10 = getHourFromDatePicker(deliveryTimeTextField9.text!)

        //        (fromHour1 , fromAmPm1) = conversionAmPm(fromHour1 , fromMin: fromMin1)
        //        (fromHour2 , fromAmPm2) = conversionAmPm(fromHour2 , fromMin: fromMin2)
        //        (fromHour3 , fromAmPm3) = conversionAmPm(fromHour3 , fromMin: fromMin3)
        //        (toHour1 , toAmPm1) = conversionAmPm(toHour1 , fromMin: toMin1)
        //        (toHour2 , toAmPm2) = conversionAmPm(toHour2 , fromMin: toMin2)
        //        (toHour3 , toAmPm3) = conversionAmPm(toHour3 , fromMin: toMin3)
        //        (delHour1 , delAmPm1) = conversionAmPm(delHour1 , fromMin: deltoMin1)
        //        (delHour2 , delAmPm2) = conversionAmPm(delHour2 , fromMin: deltoMin2)
        //        (delHour3 , delAmPm3) = conversionAmPm(delHour3 , fromMin: deltoMin3)
        //        (delHour4 , delAmPm4) = conversionAmPm(delHour4 , fromMin: deltoMin4)
        //        (delHour5 , delAmPm5) = conversionAmPm(delHour5 , fromMin: deltoMin5)
        //        (delHour6 , delAmPm6) = conversionAmPm(delHour6 , fromMin: deltoMin6)
        //        (delHour7 , delAmPm7) = conversionAmPm(delHour7 , fromMin: deltoMin7)
        //        (delHour8 , delAmPm8) = conversionAmPm(delHour8 , fromMin: deltoMin8)
        //        (delHour9 , delAmPm9) = conversionAmPm(delHour9 , fromMin: deltoMin9)
        //        (delHour10 , delAmPm10) = conversionAmPm(delHour10 , fromMin: deltoMin10)

        var params = [String:AnyObject]()
        if formValidation() {
            if delOrFreeCharges == "F" {
                params = [
                    "token":token,
                    "device_id":"1234",
                    "store[0][from_hour]":fromHour1,
                    "store[0][from_minute]":fromMin1,
                    "store[0][from]":fromAmPm1,
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
                    "store[delcharges]":delOrFreeCharges,
                    "store[delchargesF]":minOrderTExtfField.text!,
                    "store[minimumOrders]":lessThanMinOrderTextField.text!,
                    "store[BusinessHolidays]":businessHolidayField.text!,
                    "store[urgentDelivery]":expressDeliveryButton.text!
                ]
            }else{
                params = [
                    "token":token,
                    "device_id":"1234",
                    "store[0][from_hour]":fromHour1,
                    "store[0][from_minute]":fromMin1,
                    "store[0][from]":fromAmPm1,
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
                    "store[delcharges]":delOrFreeCharges,
                    "store[delchargesD]":deliveryChargesTextField.text!,
                    "store[BusinessHolidays]":businessHolidayField.text!,
                    "store[urgentDelivery]":expressDeliveryButton.text!
                ]
            }

            print(params)

            ServerManager.sharedInstance().vendorStoreProfile(params) { (isSuccessful, error, result) in
                if isSuccessful {
                    self.hideHud()
                }else{
                    self.hideHud()
                }
            }
        }else{
//            AlertView.alertView("Alert", message: "Delivery Time is not in range", alertTitle: "OK", viewController: self)
            self.hideHud()
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

        let dateFormatter = NSDateFormatter()

        dateFormatter.dateFormat = "hh:mm a"
        // dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")

        switch someGlobalNSInteger {
        case 0:

            //            (fromHour1 , fromAmPm1) = conversionAmPm(fromHour1 , fromMin: fromMin1)
            //
            //            print("\(fromHour1) + \(fromMin1) + \(fromAmPm1)")

            fromLabel1.text =   dateFormatter.stringFromDate(sender.date) //fromHour1 + " : " + fromMin1 + " " + fromAmPm1

            //fromDate1 = fromLabel1.text!

        case 1:
            //
            //            (toHour1 , toAmPm1) = conversionAmPm(toHour1 , fromMin: toMin1)
            //
            //            print("\(toHour1) + \(toMin1) + \(toAmPm1)")
            //
            //            print("toDate =\(toDate1) fromDate = \(sender.date) ")

            toLabel1.text = dateFormatter.stringFromDate(sender.date)  //toHour1 + " : " + toMin1 + " " + toAmPm1

            //toDate1 = toLabel1.text!

            //            if (earlierAndAfterDate(fromDate1, to: toDate1, dateString: "")) {
            //
            //            }else{
            //                toLabel1.text = ""
            //                AlertView.alertView("Alert", message: "To is greater than from", alertTitle: "OK", viewController: self)
            //            }

        case 2:

            fromLabel2
                .text = dateFormatter.stringFromDate(sender.date)

            //            (fromHour2 , fromAmPm2) = conversionAmPm(fromHour2 , fromMin: fromMin2)
            //
            //            print("\(fromHour3) + \(fromMin3) + \(fromAmPm3)")
            //
            //            fromLabel2.text = fromHour2 + " : " + fromMin2 + " " + fromAmPm2
            //
            //            fromDate2 = fromLabel2.text!

        case 3:

            toLabel2.text = dateFormatter.stringFromDate(sender.date)

            // toLabel2.text = toHour2 + " : " + toMin2 + " " + toAmPm2

            //            (toHour2 , toAmPm2) = conversionAmPm(toHour2 , fromMin: toMin2)
            //
            //            toLabel2.text = toHour2 + " : " + toMin2 + " " + toAmPm2
            //
            //            toDate2 = toLabel2.text!

            //            if (earlierAndAfterDate(fromDate2, to: toDate2, dateString: "")) {
            //
            //            }else{
            //                toLabel2.text = ""
            //                AlertView.alertView("Alert", message: "To is greater than from", alertTitle: "OK", viewController: self)
            //            }

        case 4:

            fromLabel3.text = dateFormatter.stringFromDate(sender.date)

            //            (fromHour3 , fromAmPm3) = conversionAmPm(fromHour3 , fromMin: fromMin3)
            //
            //            fromLabel3.text = fromHour3 + " : " + fromMin3 + " " + fromAmPm3
            //
            //            fromDate3 = fromLabel3.text!

        case 5:

            toLabel3.text = dateFormatter.stringFromDate(sender.date)

            //            (toHour3 , toAmPm3) = conversionAmPm(toHour3 , fromMin: toMin3)
            //
            //            toLabel3.text = toHour3 + " : " + toMin3 + " " + toAmPm3
            //
            //            toDate3 = toLabel3.text!

            //            if (earlierAndAfterDate(fromDate3, to: toDate3, dateString: "")) {
            //
            //            }else{
            //                toLabel3.text = ""
            //                AlertView.alertView("Alert", message: "To is greater than from", alertTitle: "OK", viewController: self)
            //            }

        case 6:

            deliveryTimeTextField0.text = dateFormatter.stringFromDate(sender.date)

            //            (delHour1 , delAmPm1) = conversionAmPm(delHour1 , fromMin: deltoMin1)
            //
            //            deliveryTimeTextField0.text = delHour1 + " : " + deltoMin1 + " " + delAmPm1

            // checkDeliveryTime(deliveryTimeTextField0.text!)

        case 7:

            deliveryTimeTextField1.text = dateFormatter.stringFromDate(sender.date)

            //            (delHour2 , delAmPm2) = conversionAmPm(delHour2 , fromMin: deltoMin2)
            //
            //            deliveryTimeTextField1.text = delHour2 + " : " + deltoMin2 + " " + delAmPm2

            //checkDeliveryTime(deliveryTimeTextField1.text!)

        case 8:

            deliveryTimeTextField2.text = dateFormatter.stringFromDate(sender.date)

            //            (delHour3 , delAmPm3) = conversionAmPm(delHour3 , fromMin: deltoMin3)
            //
            //            deliveryTimeTextField2.text = delHour3 + " : " + deltoMin3 + " " + delAmPm3

            // checkDeliveryTime(deliveryTimeTextField2.text!)

        case 9:

            deliveryTimeTextField3.text = dateFormatter.stringFromDate(sender.date)


            //            delHour4 = getHourFromDatePicker(sender)
            //
            //            deltoMin4 = getMinFromDatePicker(sender)
            //
            //            (delHour4 , delAmPm4) = conversionAmPm(delHour4 , fromMin: deltoMin4)
            //
            //            deliveryTimeTextField3.text = delHour4 + " : " + deltoMin4 + " " + delAmPm4

            //  checkDeliveryTime(deliveryTimeTextField3.text!)

        case 10:

            deliveryTimeTextField4.text = dateFormatter.stringFromDate(sender.date)

            //            (delHour5 , delAmPm5) = conversionAmPm(delHour5 , fromMin: deltoMin5)
            //
            //            deliveryTimeTextField4.text = delHour5 + " : " + deltoMin5 + " " + delAmPm5

            //  checkDeliveryTime(deliveryTimeTextField4.text!)

        case 11:

            deliveryTimeTextField5.text = dateFormatter.stringFromDate(sender.date)

            //            delHour6 = getHourFromDatePicker(sender)
            //
            //            deltoMin6 = getMinFromDatePicker(sender)
            //
            //            (delHour6 , delAmPm6) = conversionAmPm(delHour6 , fromMin: deltoMin6)
            //
            //            deliveryTimeTextField5.text = delHour6 + " : " + deltoMin6 + " " + delAmPm6

            //  checkDeliveryTime(deliveryTimeTextField5.text!)

        case 12:

            deliveryTimeTextField6.text = dateFormatter.stringFromDate(sender.date)


            //            delHour7 = getHourFromDatePicker(sender)
            //
            //            deltoMin7 = getMinFromDatePicker(sender)
            //
            //            (delHour7 , delAmPm7) = conversionAmPm(delHour7 , fromMin: deltoMin7)
            //
            //            deliveryTimeTextField6.text = delHour7 + " : " + deltoMin7 + " " + delAmPm7

            //  checkDeliveryTime(deliveryTimeTextField6.text!)

        case 13:

            deliveryTimeTextField7.text = dateFormatter.stringFromDate(sender.date)

            //            delHour8 = getHourFromDatePicker(sender)
            //
            //            deltoMin8 = getMinFromDatePicker(sender)
            //
            //            (delHour8 , delAmPm8) = conversionAmPm(delHour8 , fromMin: deltoMin8)
            //
            //            deliveryTimeTextField7.text = delHour8 + " : " + deltoMin8 + " " + delAmPm8

            //  checkDeliveryTime(deliveryTimeTextField7.text!)

        case 14:

            deliveryTimeTextField8.text = dateFormatter.stringFromDate(sender.date)

            //            delHour9 = getHourFromDatePicker(sender)
            //
            //            deltoMin9 = getMinFromDatePicker(sender)
            //
            //            (delHour9 , delAmPm9) = conversionAmPm(delHour9 , fromMin: deltoMin9)
            //
            //            deliveryTimeTextField8.text = delHour9 + " : " + deltoMin9 + " " + delAmPm9

            //  checkDeliveryTime(deliveryTimeTextField8.text!)

        case 15:

            deliveryTimeTextField9.text = dateFormatter.stringFromDate(sender.date)

            //            delHour10 = getHourFromDatePicker(sender)
            //
            //            deltoMin10 = getMinFromDatePicker(sender)
            //
            //            (delHour10 , delAmPm10) = conversionAmPm(delHour10 , fromMin: deltoMin10)
            //
            //            deliveryTimeTextField9.text = delHour10 + " : " + deltoMin10 + " " + delAmPm10

            //  checkDeliveryTime(deliveryTimeTextField9.text!)

        default:
            ""
        }
    }



    func  checkDeliveryTime(dateString: String) -> Bool{

        if (isBetweenMyTwoDates(fromLabel1.text!, to: toLabel1.text!, dateString: dateString) || isBetweenMyTwoDates(fromLabel2.text!, to: toLabel2.text!, dateString: dateString) ||  isBetweenMyTwoDates(fromLabel3.text!, to: toLabel3.text!, dateString: dateString)) {
            print("delivery time is in the range of from and to")
        } else {
            //            AlertView.alertView("Alert", message: "delivery time is  not in the range of from and to", alertTitle: "OK", viewController: self)
            print("delivery time is  not in the range of from and to")
            return false
        }

        return true

    }

    func earlierAndAfterDate(from:String , to:String , dateString: String) -> Bool {
        let dateMaker = NSDateFormatter()

        dateMaker.dateFormat = "hh:mm a"
        //dateMaker.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        var start = NSDate()
        var end = NSDate()

        if from != "" {
            start = dateMaker.dateFromString(from)!
        }

        if to != "" {
            end = dateMaker.dateFromString(to)!
        }

        // let currentTime = dateMaker.dateFromString(dateString)!

        if start.compare(end) == .OrderedAscending {
            return true
        }
        return false

    }

    func isBetweenMyTwoDates(from: String, to: String, dateString: String) -> Bool {

        let dateMaker = NSDateFormatter()
        var currentTime = NSDate()
        dateMaker.dateFormat = "hh:mm a"
        //  dateMaker.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        var start = NSDate()
        var end = NSDate()

        if from != "" {
            start = dateMaker.dateFromString(from)!
        }

        if to != "" {
            end = dateMaker.dateFromString(to)!
        }

        if dateString != "" {
            currentTime = dateMaker.dateFromString(dateString)!
        }

        if start.compare(currentTime) == .OrderedAscending && end.compare(currentTime) == .OrderedDescending {
            return true
        }

        if from == "" && to == "" {
            return true
        }

        return false
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

    func getHourFromDatePicker(labelString:String) -> String
    {

        //        let dateFormatter = NSDateFormatter()
        //        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        //        let date = dateFormatter.dateFromString(labelString)
        ////        var dfTime = NSDateFormatter()
        ////        dfTime.dateFormat = "hh:mm a"
        ////        var time = dfTime.stringfrom

        let dateFormatter = NSDateFormatter()
        print(labelString)
        dateFormatter.dateFormat = "hh:mm a"
        //       // dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        let date = dateFormatter.dateFromString(labelString)
        //
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date!)

        return "\(components.hour)"
    }

    func getMinFromDatePicker(labelString:String) -> String
    {
        let dateFormatter = NSDateFormatter()

        dateFormatter.dateFormat = "hh:mm a"
        //dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00")
        let date = dateFormatter.dateFromString(labelString)

        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Hour, NSCalendarUnit.Minute] , fromDate: date!)

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
                //                fromHourArray[i] = self.storeProfileData.startTime[i].from_hour
                //                fromMinArray[i] =  self.storeProfileData.startTime[i].from_minute
                //                fromAmPmArray[i] =  self.storeProfileData.startTime[i].from
                
                if self.storeProfileData.startTime[i].from_hour == "12" && storeProfileData.startTime[i].from == "PM" {
                    
                }
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
                //                
                //                toHourArray[i] = self.storeProfileData.endTime[i].end_hour
                //                toMinArray[i] =  self.storeProfileData.endTime[i].end_minute
                //                toAmPmArray[i] =  self.storeProfileData.endTime[i].to
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
                //                delHourArray[i] = self.storeProfileData.deliveryTime[i].del_hour
                //                delMinArray[i] =  self.storeProfileData.deliveryTime[i].del_min
                //                delAmPmArray[i] = self.storeProfileData.deliveryTime[i].del
                //                businessTimeingViewContraint.constant = businessViewConstant * CGFloat(i)
            }else{
                //                self.textfieldArray[i].removeFromSuperview()
                //                self.deliveryTimeLabelArray[i].removeFromSuperview()
                //                businessTimeingViewContraint.constant = businessViewConstant
            }
        }
    }
    
}
