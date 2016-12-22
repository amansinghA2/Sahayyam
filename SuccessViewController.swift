//
//  SuccessViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/12/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SuccessViewController.ResponseNew(_:)), name: "JSON_NEW", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SuccessViewController.successShow(_:)), name: "success", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("JSON_DICT", object: nil, userInfo: nil)

        // Do any additional setup after loading the view.
    }

    func successShow(notification:NSNotification) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Please add the below method to receive the transaction details
    func ResponseNew(message: NSNotification) {
        if (message.name == "JSON_NEW") {
//            NSLog("Response = %@", message.object)
//            jsondict = message.object
        }
    }
    
    @IBAction func submitAction(sender: AnyObject)
    {
        for (var i = 0; i < self.navigationController?.viewControllers.count; i++)
        {
            if(self.navigationController?.viewControllers[i].isKindOfClass(SubscriptionDetailsViewController) == true)
            {
                //Here ViewController is where you want to navigate from success..
                self.navigationController?.popToViewController(self.navigationController!.viewControllers[i] as! SubscriptionDetailsViewController, animated: true)
                break;
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
