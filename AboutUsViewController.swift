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
    @IBAction func sendEmailAction(sender: AnyObject) {
        
        self.showHud("Loading...")
        
        let params = [
            "token":token,
            "device_id":"1234",
            "name":nameTextField.text,
            "email":addresstextField.text,
            "email_subject":emailTextField.text,
            "message":messageTextField.text
        ]
        
        print(params)
        
        ServerManager.sharedInstance().vendorAboutUs(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
            }else{
              self.hideHud()  
            }
        }
 
        
    }

}
