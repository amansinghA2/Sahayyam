//
//  UnderConstructionViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class UnderConstructionViewController: UIViewController {

    @IBOutlet weak var logoutButton: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if vendorEntry == "onlyVendor"{
        
        }else{
            logoutButton.hidden = true
          back()
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewControllerWithIdentifier("LoginVC") as! LoginViewController
        self.navigationController?.pushViewController(vc1, animated: true)
//        AlertView.alertViewToGoToLogin("Alert", message: "Do you wish to logout", alertTitle: "OK", viewController: self)
    }

    func back() {
    let backButton = UIButton(frame: CGRectMake(0,0,26,26))
    backButton.setBackgroundImage(UIImage(named: "keyboard-left-arrow-button (1)"), forState: .Normal)
    let barbackButtonitem = UIBarButtonItem(customView: backButton)
    backButton.exclusiveTouch = true
    backButton.addTarget(self, action:#selector(popCurrentViewControl), forControlEvents: UIControlEvents.TouchUpInside)
    self.navigationItem.leftBarButtonItem = barbackButtonitem
    self.navigationItem.hidesBackButton = true
    }
    
    func popCurrentViewControl() {
        self.performSegueWithIdentifier("switchProfileSegue", sender: nil)
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
