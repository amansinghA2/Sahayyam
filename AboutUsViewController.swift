//
//  AboutUsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 05/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    @IBOutlet weak var slidemenuButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addresstextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var messageTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButtonForNavigation()
        tokenCheck()
        
        let params = [
        "token":token,
        "device_id":"1234",
        "name":nameTextField.text,
        "email":addresstextField.text,
        "email_subject":emailTextField.text,
        "message":messageTextField.text
        ]
        
        ServerManager.sharedInstance().vendorAboutUs(params) { (isSuccessful, error, result) in
            if isSuccessful {
                
            }
        }
        
        // changeNavigationBarColor()
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
