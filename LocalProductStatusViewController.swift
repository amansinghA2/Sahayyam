//
//  LocalProductStatusViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 22/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class LocalProductStatusViewController: UIViewController {

    @IBOutlet weak var approvedProductLabel: UILabel!
    
    @IBOutlet weak var pendingProductLabel: UILabel!
    
    @IBOutlet weak var rejectedProductLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params = [
        "token":token,
        "device_id":"1234",
        ]
        
        ServerManager.sharedInstance().addNewVendor(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
               self.hideHud()
            }else{
                self.hideHud()
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getDetails(sender: AnyObject) {
        
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
