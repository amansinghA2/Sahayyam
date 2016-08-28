//
//  ForgotPasswordViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 01/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var mobileNumberTextfield: TextField!
    @IBOutlet weak var birthDatetextfield: TextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        mobileNumberTextfield.setTextFieldStyle(TextFieldStyle.MobileNumber)
        birthDatetextfield.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        
  
        
//        var vc = PDTSimpleCalendarViewController()
//        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
//        calendar.locale = NSLocale.currentLocale()
//        calendar.timeZone = NSDate.localTimeZone()
//        vc.calendar = calendar

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func senOTPAction(sender: AnyObject){

        if mobileNumberTextfield.text?.isPhoneNumber  == true && mobileNumberTextfield.text?.isBlank == false {
            
            
            
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
