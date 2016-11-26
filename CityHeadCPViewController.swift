//
//  CityHeadCPViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CityHeadCPViewController: UIViewController {
    @IBOutlet weak var changePassword: TextField!

    @IBOutlet weak var confirmPassword: TextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

   
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitAction(sender: AnyObject) {
        
        let params = [
            "token":token,
            "device_id":"1234",
            "password":String(changePassword.text),
            "confirm":String(confirmPassword.text)
        ]
        
        ServerManager.sharedInstance().chPasswordChange(params) { (isSuccessful, error, result, dictResult) in
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
