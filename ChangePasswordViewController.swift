//
//  ChangePasswordViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 08/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var confirmpasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func submitButtonClicked(sender: AnyObject) {
       self.showHud("Pleast Wait...")
        
        let params:[String:AnyObject] = [
        "id":"",
        "password":passwordTextField.text!,
        "confirm":confirmpasswordTextField.text!
        ]
        
        ServerManager.sharedInstance().passwordChange(params) { (isSuccessful, error, result) in
        if isSuccessful {
            self.hideHud()
            
        }else{
            self.hideHud()
        }
      }
    }

}
