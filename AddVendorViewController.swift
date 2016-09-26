//
//  AddVendorViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class AddVendorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
