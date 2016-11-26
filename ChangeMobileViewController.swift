//
//  ChangeMobileViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 25/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ChangeMobileViewController: UIViewController {
    
    @IBOutlet weak var mobileNumberTextfield: UITextField!
    
    @IBOutlet weak var confirmMobileNumberTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonAction(sender: AnyObject) {
   
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
