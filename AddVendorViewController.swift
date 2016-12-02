//
//  AddVendorViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class AddVendorViewController: UIViewController , DropperDelegate{

    @IBOutlet weak var citySelectionButton: UIButton!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var stateTextfield: UITextField!
    @IBOutlet weak var postalCodeButton: UIButton!
    @IBOutlet weak var serviceButtonOutler: UIButton!
    
    var dropper = Dropper(width: 164, height: 100)
    var chVendorGetData = [CHVendorGetData]()
    var cityIdString = String()
    var cityWisePincode = CHCitywisePincode()
    override func viewDidLoad() {
        super.viewDidLoad()

        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().addVendorGetData(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
               self.hideHud()
               self.chVendorGetData = result!
               self.cityIdString = self.chVendorGetData[0].city_id
               self.bindModelToViews()
            }else{
                self.hideHud()
            }
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }

    func bindModelToViews() {
        
        for _ in chVendorGetData {
            
            
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectCityAction(sender: AnyObject) {

        self.view.endEditing(true)
        
        
        var cities = [String]()
        
        for getData in chVendorGetData {
           cities.append(getData.city_name)
        }
        
        if dropper.status == .Hidden {
            dropper = Dropper(x: citySelectionButton.frame.origin.x, y: citySelectionButton.frame.origin.y + citySelectionButton.frame.size.height, width: citySelectionButton.frame.size.width, height: 150)
            dropper.tag = 1
            dropper.items = cities
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: citySelectionButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }

    }

    @IBAction func postcodeCityAction(sender: AnyObject) {
        
        let params = [
            "token":token ,
            "device_id":"1234",
            "city_id":cityIdString
        ]
        
        print(params)
        
        ServerManager.sharedInstance().cityWisePincodeLocation(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.cityWisePincode = result!
                var getPostCodeList = [String]()
                
                for data in self.cityWisePincode.postcodesList {
                    getPostCodeList.append(data.postcode)
                }
                
                if self.dropper.status == .Hidden {
                    self.dropper = Dropper(x: self.postalCodeButton.frame.origin.x, y: self.postalCodeButton.frame.origin.y + self.postalCodeButton.frame.size.height, width: self.postalCodeButton.frame.size.width, height: 150)
                    self.dropper.tag = 2
                    self.dropper.items = getPostCodeList
                    self.dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
                    self.dropper.delegate = self
                    self.dropper.cellBackgroundColor = UIColor.grayColor()
                    self.dropper.cellColor = UIColor.whiteColor()
                    self.dropper.spacing = 1
                    self.dropper.cellTextSize = 13.0
                    self.dropper.cornerRadius = 3
                    self.dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: self.postalCodeButton)
                } else {
                    self.dropper.hideWithAnimation(0.1)
                }
                
                self.hideHud()
            }else{
                AlertView.alertViewToGoToLogin("Alert", message: "Server error", alertTitle: "OK", viewController: self)
                self.hideHud()
            }
            
        }
        
        
    }
    
    @IBAction func serviceAction(sender: AnyObject) {
        self.view.endEditing(true)
        
        if dropper.status == .Hidden {
            dropper = Dropper(x: serviceButtonOutler.frame.origin.x, y: serviceButtonOutler.frame.origin.y + serviceButtonOutler.frame.size.height, width: serviceButtonOutler.frame.size.width, height: 150)
            dropper.tag = 3
            dropper.items = ["Sunday" , "Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday"]
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: serviceButtonOutler)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {
        if tag == 1 {
            for getData in chVendorGetData {
                if contents == getData.city_name {
                    cityIdString = getData.city_id 
                }
            }
        }else if tag == 2 {
//            for data in CHCitywisePincode {
//                
//            }
        }else{
            
        }
    }
    
    @IBAction func continueButtonAction(sender: AnyObject) {
     
        
        let params = [
            "token":token,
            "device_id":"1234",
            "seller[address_1]":"",
            "seller[address_2]":"",
            "seller[dob]":"",
            "seller[email]":"",
            "seller[firstname]":"",
            "seller[lastname]":"",
            "seller[nickname]":"",
            "seller[telephone]":"",
            "seller[postcode]":"",
            "seller[postcode_id]":"",
            "seller[rest]":"",
            "seller[zone_id]":"",
            "seller[bus_type]":"",
            "seller[city]":"",
            "seller[city_id]":"",
            "seller[city_name]":"",
            "seller[country_id]":""
        ]
        
        ServerManager.sharedInstance().addNewVendor(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                
            }else{
                
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
