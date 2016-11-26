//
//  AddCustomerViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 24/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class AddCustomerViewController: UIViewController , UIGestureRecognizerDelegate , DropperDelegate{

    var dropper = Dropper(width: 131, height: 141)
    
    @IBOutlet weak var mobileNumberTextfield: TextField!
    @IBOutlet weak var selectVendor: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StoreProfileViewController.dismissKeyboard))
        tap.delegate = self
        view.addGestureRecognizer(tap)
        mobileNumberTextfield.setTextFieldStyle(TextFieldStyle.MobileNumber)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func dismissKeyboard() {
        self.view.endEditing(true)
        dropper.hideWithAnimation(0.1)
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if CGRectContainsPoint(self.dropper.bounds, touch.locationInView(dropper)){
            return false
        }else{
            return true
        }
    }
    
    @IBAction func selectVendorAction(sender: AnyObject) {
        
        if dropper.status == .Hidden {
            dropper = Dropper(x: selectVendor.frame.origin.x, y: selectVendor.frame.origin.y + selectVendor.frame.size.height, width: selectVendor.frame.size.width, height: 150)
            dropper.tag = 3
            dropper.items = ["Sunday" , "Monday" , "Tuesday" , "Wednesday" , "Thursday" , "Friday" , "Saturday"]
            dropper.theme = Dropper.Themes.Black(UIColor.grayColor())
            dropper.delegate = self
            dropper.cellBackgroundColor = UIColor.grayColor()
            dropper.cellColor = UIColor.whiteColor()
            dropper.spacing = 1
            dropper.cellTextSize = 13.0
            dropper.cornerRadius = 3
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, position: Dropper.Position.Top, button: selectVendor)
        } else {
            dropper.hideWithAnimation(0.1)
        }
        
    }

    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {
        
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
