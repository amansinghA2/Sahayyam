//
//  CityHeadProfileViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CityHeadProfileViewController: UIViewController {

    
    
    @IBOutlet weak var cityHeadimage: UIImageView!
    
    @IBOutlet weak var firstNameTextField: TextField!
    
    @IBOutlet weak var lastnameTextField: TextField!
    
    @IBOutlet weak var dobTextField: TextField!
    
    @IBOutlet weak var emailIdTextfield: TextField!
    
    @IBOutlet weak var passwordTextField: TextField!
    
    @IBOutlet weak var confirmPasswordTextfield: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func uploadImage(sender: AnyObject) {
        
        
    }
    
    
    @IBAction func removeImage(sender: AnyObject) {
        
        cityHeadimage.image = nil
    }

}
