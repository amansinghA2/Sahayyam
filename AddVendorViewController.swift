//
//  AddVendorViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class AddVendorViewController: UIViewController , DropperDelegate , SSRadioButtonControllerDelegate{

    @IBOutlet weak var citySelectionButton: UIButton!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var stateTextfield: UITextField!
    @IBOutlet weak var postalCodeButton: UIButton!
    @IBOutlet weak var serviceButtonOutler: UIButton!
    var service_id = String()
    var radioButtonController = SSRadioButtonsController()
    @IBOutlet weak var b2cRadioButton: SSRadioButton!
    @IBOutlet weak var b2bRadioButton: SSRadioButton!
    var isB2c = "B2C"
    var serviceLists = [VendorService]()
    var dropper = Dropper(width: 164, height: 100)
    var chVendorGetData = [CHVendorGetData]()
    var cityIdString = String()
    var postalcodeString = String()
    var cityWisePincode = CHCitywisePincode()
    var postCodeStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        radioButtonController.setButtonsArray([b2cRadioButton!,b2bRadioButton!])
        radioButtonController.delegate = self
        b2cRadioButton.selected = true
        country.userInteractionEnabled = false
        stateTextfield.userInteractionEnabled = false
        
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().addVendorGetData(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
               self.hideHud()
               self.chVendorGetData = result!
               self.cityIdString = self.chVendorGetData[0].city_id
               self.postCodeCityFunction("ViewLoad")
               self.country.text = self.chVendorGetData[0].country_name
               self.stateTextfield.text = self.chVendorGetData[0].state
               self.citySelectionButton.setTitle(self.chVendorGetData[0].city_name, forState: .Normal)
               self.bindModelToViews()
            }else{
                self.hideHud()
            }
        }
        
        getServices("")
        
        // Do any additional setup after loading the view.
    }

    
    func getServices(fromDropDown:String) {
        
        let params = [
        "token":token,
        "device_id":"1234",
        "bus":isB2c
        ]
        
        print(params)
        
        ServerManager.sharedInstance().getCHCategories(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.serviceLists = result!
                if fromDropDown == "" {
                  self.service_id = self.serviceLists[0].id
                  self.serviceButtonOutler.setTitle(self.serviceLists[0].desc, forState: .Normal)
                }
                
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    

    func bindModelToViews() {
        
        for _ in chVendorGetData {
            
            
            
        }
        
    }
    
    
    func didSelectButton(aButton: UIButton?) {
        if aButton == b2cRadioButton {
            isB2c = "B2C"
        }else{
            isB2c = "B2B"
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
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Bottom, button: citySelectionButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }

    }

    func postCodeCityFunction(a:String) {
        
        self.showHud("Loading...")
        
        let params = [
            "token":token ,
            "device_id":"1234",
            "city_id":cityIdString
        ]
        
        print(params)
        
        ServerManager.sharedInstance().cityWisePincodeLocation(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.hideHud()
                self.cityWisePincode = result!
                if a == "ViewLoad"{
                  self.postalCodeButton.setTitle(self.cityWisePincode.postcodesList[0].postcode, forState: .Normal)
                }else{
                    
                }
            }else{
                self.hideHud()
            }
        }

    }
    
    @IBAction func postcodeCityAction(sender: AnyObject) {
       
//        let params = [
//            "token":token ,
//            "device_id":"1234",
//            "city_id":cityIdString
//        ]
//        
//        print(params)
//        
//        ServerManager.sharedInstance().cityWisePincodeLocation(params) { (isSuccessful, error, result, dictResult) in
//            if isSuccessful {
           //     self.cityWisePincode = result!
                var getPostCodeList = [String]()
                self.postalcodeString = self.cityWisePincode.postcodesList[0].id
        
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
                    self.dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Bottom, button: self.postalCodeButton)
                } else {
                        self.dropper.hideWithAnimation(0.1)
                }
//                self.hideHud()
//            }else{
//                AlertView.alertViewToGoToLogin("Alert", message: "Server error", alertTitle: "OK", viewController: self)
//                self.hideHud()
//            }
//            
//        }
        
        
    }
    
    @IBAction func serviceAction(sender: AnyObject) {
        self.view.endEditing(true)
        
        getServices("fromDropDown")
        
        var serviceList = [String]()
        
        for sl in serviceLists {
            serviceList.append(sl.desc)
        }
        
        if dropper.status == .Hidden {
            dropper = Dropper(x: serviceButtonOutler.frame.origin.x, y: serviceButtonOutler.frame.origin.y + serviceButtonOutler.frame.size.height, width: serviceButtonOutler.frame.size.width, height: 150)
            dropper.tag = 3
            dropper.items = serviceList
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
                    citySelectionButton.setTitle(contents, forState: .Normal)
                    cityIdString = getData.city_id
                     postCodeCityFunction("")
                }
            }
        }else if tag == 2 {
            for data in self.cityWisePincode.postcodesList {
                if contents == data.postcode {
                 postalCodeButton.setTitle(contents, forState: .Normal)
                 postCodeStr = contents
                 postalcodeString = data.id
                }
            }
        }else{
            for serviceList in serviceLists {
                if contents == serviceList.desc {
                    serviceButtonOutler.setTitle(contents, forState: .Normal)
                    service_id = serviceList.id
                }
            }
        }
    }
    
    @IBAction func continueButtonAction(sender: AnyObject) {
     
    self.performSegueWithIdentifier("newVendorSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newVendorSegue" {
           let vc = segue.destinationViewController as! NewVendorDetailsViewController
            vc.chVendorGetData = self.chVendorGetData
            vc.isB2c = self.isB2c
            vc.postalcodeString = self.postalcodeString
            vc.postCodeStr = self.postCodeStr
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
