//
//  CheckoutViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 11/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import M13Checkbox

class CheckoutViewController: UIViewController , UITextFieldDelegate , UITableViewDelegate , UITableViewDataSource , SSRadioButtonControllerDelegate{
    
    
    @IBOutlet weak var addressCheckoutButton: M13Checkbox!
    @IBOutlet weak var totalShowLabel: UILabel!
    @IBOutlet weak var subTotalShowLabel: UILabel!
    @IBOutlet weak var deliverychargesShowLabel: UILabel!
    @IBOutlet weak var priceShowLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    @IBOutlet weak var deliveryChargesLabel: UILabel!
    @IBOutlet weak var urgentAmountLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var expressDeliveryHeightCheckBox: NSLayoutConstraint!
    @IBOutlet weak var expressDeliveryHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var checkBoxConstraint: NSLayoutConstraint!
    @IBOutlet weak var expressDeliveryConstraint: NSLayoutConstraint!
    @IBOutlet weak var expressDeliveryLabel: UILabel!
    @IBOutlet weak var expressDeliveryCheckBox: M13Checkbox!
    @IBOutlet weak var cashOnDeliveryButton: M13Checkbox!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var deliveryDateTextField: UITextField!
    @IBOutlet weak var placeOrderLabel: Button!
    @IBOutlet weak var paymentOrderLabel: Button!
    @IBOutlet weak var tableView: UITableView!
    var paymentDetails = PaymentEBSDetails()
    var filterCheckoutTime = [CheckoutDeliveryTime]()
    var isCheck = false
    var total = CheckoutOrderTotals()
    var str = ""
    let radioButtonController = SSRadioButtonsController()
    var paymentTypeString = "offline"
    var dummyEmailData = DummyEmailData()
    
    @IBOutlet weak var payButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var payOnlineRadioButton: SSRadioButton!
    
    @IBOutlet weak var payOfflineRadioButton: SSRadioButton!
    
    @IBOutlet weak var expressDeliveryCheckbox: M13Checkbox!
    
    var cartList:Products!{
        didSet{
            bindModelToViews()
        }
    }
    
    var checkoutDelivery:CheckoutDeliveryTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        payButtonConstraint.constant = 0
        payOnlineRadioButton.hidden = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.deliveryDateTextField.delegate = self
        self.addressCheckoutButton.checkState = .Checked
        isCheck = false
        deliveryDateTextField.userInteractionEnabled = true
        deliveryTimeLabel.userInteractionEnabled = true
        urgentAmountLabel.text = ""
        
        radioButtonController.setButtonsArray([payOnlineRadioButton!,payOfflineRadioButton!])
        radioButtonController.delegate = self
        payOfflineRadioButton.selected = true

        if let checkoutDelivery = cartList?.checkoutDeliveryTime {
            filterCheckoutTime = checkoutDelivery.filter { (checkoutTime) -> Bool in
                if checkoutTime.del_hour != "00" || checkoutTime.del_min != "00"{
                    return true
                }
                return false
            }
        }
        
        for delilvery in filterCheckoutTime {
            self.checkoutDelivery = delilvery
        }
        
        if filterCheckoutTime.count == 0 {
            deliveryTimeLabel.userInteractionEnabled = false
            deliveryTimeLabel.text = "Timing Not Mentioned"
        }else{
            deliveryTimeLabel.userInteractionEnabled = true
            deliveryTimeLabel.text = "Set Time"
        }
        
        tokenCheck()
        self.tableView.hidden = true
        setBackButtonForNavigation()
        let nib = UINib(nibName: "DeliveryTimeTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "deliveryTimeIdentifier")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CheckoutViewController.deliveryTimeLabelClicked(_:)))
        tapGesture.numberOfTapsRequired = 1
        deliveryTimeLabel.addGestureRecognizer(tapGesture)
        
        deliveryDateTextField.placeholder = "Delivery Date"
        
        if let deliverCharges = cartList?.customerCartDetails {
            
            let offerPrice = deliverCharges[0]
            let deliveryCharges = deliverCharges[1]
            let subTotal = deliverCharges[2]
            let total = deliverCharges[3]
            
            if offerPrice.title != "" {
                offerPriceLabel.text = offerPrice.title
            }
            
            if deliveryCharges.title != "" {
                deliveryChargesLabel.text = deliveryCharges.title
            }
            
            if subTotal.title != "" {
                subTotalLabel.text = subTotal.title
            }
            
            if total.title != "" {
                totalLabel.text = total.title
            }
            
            if offerPrice.title != "" {
                priceShowLabel.text = offerPrice.text
            }
            
            if deliveryCharges.title != "" {
                deliverychargesShowLabel.text = deliveryCharges.text
            }
            
            if subTotal.title != "" {
                subTotalShowLabel.text = "Rs. "  + CustomClass.roundOfDecimal(subTotal.text)
            }
            
            if total.title != "" {
                totalShowLabel.text = "Rs. "  + CustomClass.roundOfDecimal(total.text)
            }
        }
    }
    
    func didSelectButton(aButton: UIButton?) {
        if aButton == payOnlineRadioButton {
            paymentTypeString = "online"
        }else{
            paymentTypeString = "offline"
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if cartList.is_express == false {
            expressDeliveryCheckBox.hidden = true
            expressDeliveryLabel.hidden = true
            expressDeliveryHeightCheckBox.constant = 0
            expressDeliveryHeightContraint.constant = 0
        }
        addressLabel.text = address
    }
    
    func deliveryTimeLabelClicked(sender:UITapGestureRecognizer){
        
        if filterCheckoutTime.count == 0 {
            self.tableView.hidden = true
        }else{
            if self.tableView.hidden == false {
                self.tableView.hidden = true
            }else{
                self.tableView.hidden = false
            }
        }
    }
    
    //  Mark: - Tableview DataSource and Delegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterCheckoutTime.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("deliveryTimeIdentifier") as! DeliveryTimeTableViewCell
        
        
        self.tableView.layer.borderWidth = 1.0
        self.tableView.layer.borderColor = UIColor.blackColor().CGColor
        self.tableView.layer.cornerRadius = 1
        
        checkoutDelivery  = filterCheckoutTime[indexPath.row]
        
        cell.deliveryTimeCell.text = checkoutDelivery.del_hour + ":" + checkoutDelivery.del_min + "  " + checkoutDelivery.del
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.hidden = true
        
        checkoutDelivery  = filterCheckoutTime[indexPath.row]
        deliveryTimeLabel.text = checkoutDelivery.del_hour + ":" + checkoutDelivery.del_min + "  " + checkoutDelivery.del
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindModelToViews() {
        
    }
    
    @IBAction func paymentMethodAction(sender: AnyObject) {
        
    }
    
    
    @IBAction func placeOrderAction(sender: AnyObject) {
        self.showHud("Please Wait...")
        self.view.endEditing(true)
        checkBoxState()
        if isCheck == true {
            str = "2,Rs. " + cartList.urgent_delivery + ","  + cartList.totalOrder.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
            customerChekout()
        }
        else{
            if deliveryDateTextField.text == "" {
                AlertView.alertView("Alert", message: "DeliveryDate cannot be left blank", alertTitle: "OK", viewController: self)
                self.hideHud()
            }else{
                str = "1," + String(deliveryDateTextField.text!) + "," + String(deliveryTimeLabel.text!)
                customerChekout()
            }
        }
    }
    
    
    // MARK: - Custom Functions
    
    //    @IBAction func cashOnDeliveryAction(sender: AnyObject) {
    //        if self.cashOnDeliveryButton.checkState == .Unchecked{
    //            deliveryDateTextField.userInteractionEnabled = true
    //            self.expressDeliveryCheckBox.checkState = .Checked
    //            deliveryTimeLabel.text = "Set Time"
    //            deliveryDateTextField.userInteractionEnabled = false
    //            deliveryTimeLabel.userInteractionEnabled = false
    //            tableView.hidden = true
    //            isCheck = true
    //            deliveryDateTextField.text = ""
    //            urgentAmountLabel.text = "Rs. " + cartList.urgent_delivery + "/- INR added"
    //        }else{
    //            isCheck = false
    //           self.expressDeliveryCheckBox.checkState = .Unchecked
    //            deliveryDateTextField.userInteractionEnabled = true
    //            deliveryTimeLabel.userInteractionEnabled = true
    //            urgentAmountLabel.text = ""
    //        }
    //    }
    //
    //    @IBAction func expressDeliveryAction(sender: AnyObject) {
    //        if self.expressDeliveryCheckBox?.checkState == .Unchecked {
    //            isCheck = false
    //            deliveryDateTextField.userInteractionEnabled = true
    //            deliveryTimeLabel.userInteractionEnabled = true
    //            self.cashOnDeliveryButton.checkState = .Checked
    //            urgentAmountLabel.text = ""
    //        }else{
    //            isCheck = true
    //            self.cashOnDeliveryButton.checkState = .Unchecked
    //            deliveryTimeLabel.text = "Set Time"
    //            deliveryDateTextField.userInteractionEnabled = false
    //            deliveryTimeLabel.userInteractionEnabled = false
    //            tableView.hidden = true
    //            deliveryDateTextField.text = ""
    //            urgentAmountLabel.text = "Rs. " + cartList.urgent_delivery + "/- INR added"
    //        }
    //
    //    }
    
    
    func customerChekout() {
        self.showHud("Loading...")
        if Reachability.isConnectedToNetwork(){
            let params:[String:AnyObject] = [
                "token":token,
                "device_id":"1234",
                "urgent":str,
                "orderType":paymentTypeString
            ]
            
            print(params)
            
            ServerManager.sharedInstance().customerCheckout(params) { (isSuccessful, error, result , result1) in
                if isSuccessful {
                    self.hideHud()
                    self.paymentDetails = result1!
                    if let successOnline = result!["success_online"] as? Bool {
                        if successOnline == true {
                            
                            self.showHud("Loading...")
                            
                            let params = [
                                "token":token,
                                "device_id":"1234",
                                "order_id":self.paymentDetails.order_id,
                                "seller_id":self.paymentDetails.seller_id
                            ]
                            let str =  CustomClass.roundOfDecimal(result!["total"]!)
                            ServerManager.sharedInstance().getDummyData(params) { (isSuccessful, error, result) in
                                if isSuccessful {
                                  
                                    self.dummyEmailData = result!
                                    let paymentView = PaymentModeViewController(nibName: "PaymentModeViewController", bundle: nil)
                                    paymentView.paymentAmtString = str;
                                    paymentView.strSaleAmount = str;
                                    paymentView.strCurrency = self.paymentDetails.currency_code;
                                    paymentView.strDisplayCurrency = "";
                                    // Reference no has to be configured
                                    paymentView.reference_no = self.paymentDetails.order_id;
                                    paymentView.strDescription = "ABCD";
                                    paymentView.strBillingName = self.dummyEmailData.name;
                                    paymentView.strBillingAddress = self.dummyEmailData.address;
                                    paymentView.strBillingCity = self.dummyEmailData.city;
                                    paymentView.strBillingState = "";
                                    paymentView.strBillingPostal = self.dummyEmailData.postcode;
                                    paymentView.strBillingCountry = "IND";
                                    paymentView.strBillingEmail = self.dummyEmailData.email;
                                    paymentView.strBillingTelephone = self.dummyEmailData.telephone;
                                    // Non mandatory parameters
                                    paymentView.strDeliveryName = "Aman";
                                    paymentView.strDeliveryAddress = "Kharghar";
                                    paymentView.strDeliveryCity = "Mumbai";
                                    paymentView.strDeliveryState = "Maharashtra";
                                    paymentView.strDeliveryPostal = "410210";
                                    paymentView.strDeliveryCountry = "IND";
                                    paymentView.strDeliveryTelephone = "9869796388";
                                    
                                    // Dynamic Values configuration
                                    // var dynamicKeyValueDictionary: NSMutableDictionary = NSMutableDictionary()
                                    // dynamicKeyValueDictionary.setValue("savings", forKey: "account_detail")
                                    // dynamicKeyValueDictionary.setValue("gold", forKey: "merchant_type")
                                    // paymentView.dynamicKeyValueDictionary = dynamicKeyValueDictionary
                                    self.navigationController!.pushViewController(paymentView, animated: true)
                                    
                                    self.hideHud()
                                }else{
                                    self.hideHud()
                                }
                            }
                        }else{
                            let str =  CustomClass.roundOfDecimal(result!["total"]!)
                            let refreshAlert = UIAlertController(title: "Order Confirmation", message: "Thank you for shopping at \(result!["store_name"]!) , your Order Id \(result!["sales_order"]!) , Order value Rs. \(str)/- dated \(result!["date_added"]!)  has been successfully placed.", preferredStyle: UIAlertControllerStyle.Alert)
                            
                            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                                NSNotificationCenter.defaultCenter().postNotificationName("getBasicProducts", object: nil)
                                self.navigationController?.popToRootViewControllerAnimated(true)
                                }
                                ))
                            
                            self.presentViewController(refreshAlert, animated: true, completion: nil)
                        }
                    }else{
                        let str =  CustomClass.roundOfDecimal(result!["total"]!)
                        let refreshAlert = UIAlertController(title: "Order Confirmation", message: "Thank you for shopping at \(result!["store_name"]!) , your Order Id \(result!["sales_order"]!) , Order value Rs. \(str)/- dated \(result!["date_added"]!)  has been successfully placed.", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                            NSNotificationCenter.defaultCenter().postNotificationName("getBasicProducts", object: nil)
                            self.navigationController?.popToRootViewControllerAnimated(true)
                            }
                            ))
                        
                        self.presentViewController(refreshAlert, animated: true, completion: nil)
                    }
                }else{
                    AlertView.alertViewWithPopup("Alert", message: error!, alertTitle: "OK", viewController: self)
                    self.hideHud()
                }
            }
        }
        else{
            self.hideHud()
            AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
        }
    }
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        addDatePickerToTextField()
        return true
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.endEditing(true)
        if deliveryDateTextField.text!.isEmpty{
            let date = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            deliveryDateTextField.text = dateFormatter.stringFromDate(date)
        }
        if isCheck == true {
            deliveryDateTextField.text = ""
        }
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    private func addDatePickerToTextField(){
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.minimumDate = NSDate()
        datePickerView.backgroundColor = UIColor.whiteColor()
        deliveryDateTextField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(CheckoutViewController.handleDatePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if !deliveryDateTextField.text!.isEmpty {
            let currentDate = deliveryDateTextField.text
            let date = dateFormatter.dateFromString(currentDate!)
            datePickerView.setDate(date!, animated: false)
        }
    }
    
    
    @IBAction func expressDeliveryAction(sender: AnyObject) {
        checkBoxState()
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        deliveryDateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func checkBoxState(){
        if let state = self.expressDeliveryCheckbox?.checkState {
            switch state {
            case .Unchecked:
                isCheck = false
                deliveryDateTextField.userInteractionEnabled = true
                deliveryTimeLabel.userInteractionEnabled = true
                urgentAmountLabel.text = ""
            case .Checked:
                isCheck = true
                deliveryTimeLabel.text = "Set Time"
                deliveryDateTextField.userInteractionEnabled = false
                deliveryTimeLabel.userInteractionEnabled = false
                tableView.hidden = true
                deliveryDateTextField.text = ""
                urgentAmountLabel.text = "Rs. " + cartList.urgent_delivery + "/- INR added"
            case .Mixed:
                print("")
            }
        }
    }
    
}
