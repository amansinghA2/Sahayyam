//
//  AlertView.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 16/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class AlertView: NSObject {

    
    class func alertView(controllertitle:String , message:String , alertTitle:String , viewController:UIViewController) {
        let alert = UIAlertController(title: controllertitle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: alertTitle, style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func alertViewOKCancel(controllertitle:String , message:String , alertTitleOK:String , alertTitleCancel:String , viewController:UIViewController) {
        let alert = UIAlertController(title: controllertitle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: alertTitleOK, style: UIAlertActionStyle.Default, handler: nil))
        alert.addAction(UIAlertAction(title: alertTitleCancel, style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }

    
    class func alertViewToGoToLogin(controllertitle:String , message:String , alertTitle:String , viewController:UIViewController) {
        let alert = UIAlertController(title: controllertitle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    
        alert.addAction(UIAlertAction(title: alertTitle, style: UIAlertActionStyle.Default, handler: { (action) in
            viewController.viewControllerPassToLogin()
        }))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func alertViewWithPopup(controllertitle:String , message:String , alertTitle:String , viewController:UIViewController) {
        let alert = UIAlertController(title: controllertitle, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: alertTitle, style: UIAlertActionStyle.Default, handler: { (action) in
            viewController.navigationController?.popViewControllerAnimated(true)
        }))
        viewController.presentViewController(alert, animated: true, completion: nil)
    }

    
}
