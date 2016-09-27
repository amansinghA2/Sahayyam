
//
//  SubsPaymentInfoViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 27/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SubsPaymentInfoViewController: UIViewController {
    
    var customerId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let params = [
        "token":token,
        "device_id":"1234",
        "seller_id":customerId
        ]
        
        print(params)
        
        ServerManager.sharedInstance().subscriptionInfo(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK:- Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}
