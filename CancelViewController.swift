//
//  CancelViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/12/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
var jsondict=NSMutableDictionary()
class CancelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CancelViewController.ResponseNew(_:)), name: "JSON_NEW", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("JSON_DICT", object: nil, userInfo: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ResponseNew(message:NSNotification)
    {
        if message.name == "JSON_NEW" {
            print("Response = \(message.object!)")
            jsondict = message.object as! NSMutableDictionary
        } }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
