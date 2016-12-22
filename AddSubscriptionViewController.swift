//
//  AddSubscriptionViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 25/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class AddSubscriptionViewController: UIViewController , DropperDelegate{

    @IBOutlet weak var subscriptionTypeLabel: UILabel!
    @IBOutlet weak var pricePerCustomerLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var activeCustomerLabel: UILabel!
    @IBOutlet weak var numberOfCustomersLabel: UILabel!
    
    @IBOutlet weak var subscriptionPackageLabel: UILabel!
    
    @IBOutlet weak var subscriptionTypeButton: UIButton!
    
    @IBOutlet weak var subsPricePerCustomerLabel: UILabel!
    
    @IBOutlet weak var subsNoOfCustomersLabel: UITextField!

    @IBOutlet weak var subsSubsPackageButton: UIButton!
    
    var dropper = Dropper(width: 164, height: 100)
    var subInfo = SubsInfoDetails()
    
    var customerId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showHud("Loading...")
   
        let params = [
            "token":token,
            "device_id":"1234",
            "seller_id":customerId
        ]
        
        print(params)
        
        ServerManager.sharedInstance().subscriptionInfo(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
               self.hideHud()
               self.subInfo = result!
               self.bindModelToViews()
            }else{
                self.hideHud()
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func bindModelToViews() {
        
        if subInfo.sub_type.count > 0 {
        if let subsType = subInfo.sub_type[0].desc as? String {
            subscriptionTypeLabel.text = subsType
        }
            
            if let subsType = subInfo.sub_type[0].flat as? String {
                
//                pricePerCustomerLabel.text = "INR " + CustomClass.roundOfDecimal(CustomClass.nullToNil(subsType)!)
                pricePerCustomerLabel.text = subsType
            }
        }
        
        if let subsType = subInfo.pkg[0].name as? String {
            subscriptionTypeButton.setTitle(subsType, forState: .Normal)
        }
        
        if let subsType = subInfo.period[0].name as? String {
            subsSubsPackageButton.setTitle(subsType, forState: .Normal)
        }
        
        
        if subInfo.sub_detail.count > 0{
        if let subsType = subInfo.sub_detail[0].amount as? String {
//            amountLabel.text = "INR " + CustomClass.roundOfDecimal(CustomClass.nullToNil(subsType)!)
            amountLabel.text = subsType
        }
        
        
        if let subsType = subInfo.sub_detail[0].count as? String {
            numberOfCustomersLabel.text = subsType
        }
        
        if let subsType = subInfo.sub_detail[0].sub_pkg as? String {
            subscriptionPackageLabel.text = subsType
        }
        }
        
        if let subsType = subInfo.activecustomer as? String {
            activeCustomerLabel.text = subsType
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func subsTypeAction(sender: AnyObject) {
        
        var subsPakageArray = [String]()
        
        for subPackage in self.subInfo.pkg {
            subsPakageArray.append(subPackage.name)
        }
        
        if dropper.status == .Hidden {
            dropper = Dropper(x: subscriptionTypeButton.frame.origin.x, y: subscriptionTypeButton.frame.origin.y + subscriptionTypeButton.frame.size.height, width: subscriptionTypeButton.frame.size.width, height: 150)
            dropper.tag = 1
            dropper.items = subsPakageArray
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Bottom, button: subscriptionTypeButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    @IBAction func subsSubPackageAction(sender: AnyObject) {
        
        var subsPakageArray = [String]()
        
        for subPackage in self.subInfo.period {
            subsPakageArray.append(subPackage.name)
        }
        
        if dropper.status == .Hidden {
            dropper = Dropper(x: subsSubsPackageButton.frame.origin.x, y: subsSubsPackageButton.frame.origin.y + subsSubsPackageButton.frame.size.height, width: subsSubsPackageButton.frame.size.width, height: 150)
            dropper.tag = 2
            dropper.items = subsPakageArray
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Bottom, button: subsSubsPackageButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    
    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {
        if tag == 1 {
            subscriptionTypeButton.setTitle("\(contents)", forState: .Normal)
        }else{
            subsSubsPackageButton.setTitle("\(contents)", forState: .Normal)
        }
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        
        
    }
    
    

}
