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
    
    let dropper = Dropper(width: 164, height: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().addVendorGetData(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectCityAction(sender: AnyObject) {

        if dropper.status == .Hidden {
            dropper.tag = 1
            dropper.items = ["Larger, Longer, Item 1", "Item 2", "Item 3", "Item 4"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: citySelectionButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }

    @IBAction func postcodeCityAction(sender: AnyObject) {
        
        let params = [
            "token":token ,
            "device_id":"1234",
            "city_id":""
        ]
        
        ServerManager.sharedInstance().cityWisePincodeLocation(params) { (isSuccessful, error, result, dictResult) in
            
        }

        
        if dropper.status == .Hidden {
            dropper.tag = 1
            dropper.items = ["Larger, Longer, Item 1", "Item 2", "Item 3", "Item 4"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: postalCodeButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    @IBAction func serviceAction(sender: AnyObject) {
        if dropper.status == .Hidden {
            dropper.tag = 1
            dropper.items = ["Larger, Longer, Item 1", "Item 2", "Item 3", "Item 4"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: serviceButtonOutler)
        } else {
            dropper.hideWithAnimation(0.1)
        }
    }
    
    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {
        
        
        
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
