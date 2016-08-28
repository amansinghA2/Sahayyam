//
//  CheckoutViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 11/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import M13Checkbox

class CheckoutViewController: UIViewController , UITextFieldDelegate , UITableViewDelegate , UITableViewDataSource {
    
    
//    @IBOutlet weak var deliverChargesLabel: UILabel!
//    @IBOutlet weak var subTotalLabel: UILabel!
    
    
    @IBOutlet weak var expressDeliveryCheckBox: M13Checkbox!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var deliveryDateTextField: TextField!
    @IBOutlet weak var placeOrderLabel: Button!
    @IBOutlet weak var paymentOrderLabel: Button!
    @IBOutlet weak var tableView: UITableView!
    var total = CheckoutOrderTotals()
    var expressDeliveryString = String()
    var withoutExpressDeliveryString = String()
    
    var cartList:Products!{
        didSet{
            bindModelToViews()
        }
    }
    
    var checkoutDeliveryTime:CheckoutDeliveryTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenCheck()
        self.tableView.hidden = true
        
        let nib = UINib(nibName: "DeliveryTimeTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "deliveryTimeIdentifier")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CheckoutViewController.deliveryTimeLabelClicked(_:)))
        tapGesture.numberOfTapsRequired = 1
        deliveryTimeLabel.addGestureRecognizer(tapGesture)
        deliveryTimeLabel.userInteractionEnabled = true
        deliveryTimeLabel.text = "Set Time"
        
        deliveryDateTextField.placeholder = "Delivery Date"
        deliveryDateTextField.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        
        if let deliverCharges = cartList?.customerCartDetails {
            
           self.total = deliverCharges[3]
           self.expressDeliveryString = self.total.text
            
            var string1 = String()
            for i in deliverCharges {
                string1 = string1.stringByAppendingString(i.title + "         " + i.text + "          " + i.appliedPrice + "\n")
              
            }
                totalPrice.text = string1
        }
        
//        totalPrice.sizeToFit()
        // Do any additional setup after loading the view.
    }

    
    func deliveryTimeLabelClicked(sender:UITapGestureRecognizer){

        if cartList.checkoutDeliveryTime.count == 0 || (checkoutDeliveryTime.del_hour == "00" &&  checkoutDeliveryTime.del_min == "00"){
            self.tableView.hidden = false
            deliveryTimeLabel.text = "Timing Not Mentioned"
        }
        
        if self.tableView.hidden == false {
            self.tableView.hidden = true
        }else{
            self.tableView.hidden = false
        }

    }
    
//  Mark: - Tableview DataSource and Delegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.checkoutDeliveryTime.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("deliveryTimeIdentifier") as! DeliveryTimeTableViewCell
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.layer.borderWidth = 1.0
        self.tableView.layer.borderColor = UIColor.blackColor().CGColor
        self.tableView.layer.cornerRadius = 1
        self.tableView.reloadData()
        
         checkoutDeliveryTime  = cartList.checkoutDeliveryTime[indexPath.row]
        
         cell.deliveryTimeCell.text = checkoutDeliveryTime.del_hour + ":" + checkoutDeliveryTime.del_min + "  " + checkoutDeliveryTime.del
        
         return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.hidden = true
        
        checkoutDeliveryTime  = cartList.checkoutDeliveryTime[indexPath.row]
         deliveryTimeLabel.text = checkoutDeliveryTime.del_hour + ":" + checkoutDeliveryTime.del_min + "  " + checkoutDeliveryTime.del
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindModelToViews() {
        
    }

    @IBAction func paymentMethodAction(sender: AnyObject) {
        
    }
    
//    func timeFormatter() {
//        let starttimedatePicker = UIDatePicker()
//        deliveryDateTextField.inputView = starttimedatePicker
//        starttimedatePicker.datePickerMode = UIDatePickerMode.Time
//        starttimedatePicker.addTarget(self, action: #selector(CheckoutViewController.startTimeDiveChanged(_:)), forControlEvents: .ValueChanged)
//    }
//    
//    func startTimeDiveChanged(sender: UIDatePicker) {
//        let formatter = NSDateFormatter()
//        formatter.timeStyle = .ShortStyle
//        deliveryDateTextField.text = formatter.stringFromDate(sender.date)
//    }
    
    @IBAction func placeOrderAction(sender: AnyObject) {
        
        let params:[String:AnyObject] = [
            "token":token,
            "device_id":"1234",
            "urgent":"2,Rs. " + cartList.urgent_delivery + "," + "Rs. " + expressDeliveryString
        ]
        
        print(params)
        
        ServerManager.sharedInstance().customerCheckout(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
               AlertView.alertView("Order Confirmation", message: "Thank you for shopping at ", alertTitle: "OK", viewController: self)
            }else{
                AlertView.alertView("Alert", message: error!, alertTitle: "OK", viewController: self)
            }
        }
        
    }
    
    // MARK: - Custom Functions
    
    func checkBoxState() {
        
            if let state = self.expressDeliveryCheckBox?.checkState {
                switch state {
                case .Unchecked:
                    isChecked = false
            print("")
                case .Checked:
                    isChecked = true
            print("")
                case .Mixed:
                    print("")
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
