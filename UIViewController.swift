//
//  UIViewController.swift
//  Sahayyam
//
//  Created by Aman Singh on 29/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Foundation
import SwiftLoader

extension UIViewController {
    
// MARK: - Navigation bar

    func setBackButtonForNavigation(){
        let backButton = UIButton(frame: CGRectMake(0,0,26,26))
        backButton.setBackgroundImage(UIImage(named: "keyboard-left-arrow-button (1)"), forState: .Normal)
        let barbackButtonitem = UIBarButtonItem(customView: backButton)
        backButton.exclusiveTouch = true
        backButton.addTarget(self, action:#selector(UIViewController.popCurrentViewController), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = barbackButtonitem
        self.navigationItem.hidesBackButton = true
    }
    
    func popCurrentViewController() {
        NSNotificationCenter.defaultCenter().postNotificationName("fromDescription", object: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
//    func disableNavigation(){
//        self.navigationController?.view.userInteractionEnabled = false
//    }
//    
//    func enableNavigation(){
//        self.navigationController?.view.userInteractionEnabled = true
//    }    
    
    func hideBackBarButton(){
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func changeNavigationBarColor(){
//      self.navigationController!.navigationBar.barTintColor = UIColor.orangeColor()
//      self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
    }

// MARK: - HUD

    func showHud(message:String){
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 120

        config.foregroundColor = UIColor.blackColor()
        config.foregroundAlpha = 0.5
        config.backgroundColor = UIColor.lightGrayColor()
        config.spinnerLineWidth = 3.0
        SwiftLoader.setConfig(config)
        SwiftLoader.show(title: message, animated: true)
        
    }
    
    func hideHud(){
        SwiftLoader.hide()
    }

    // MARK: - ALERT View

    func slideMenuShow(menuButton:UIBarButtonItem , viewcontroller:UIViewController){
        if self.revealViewController() != nil {
            self.view.endEditing(true)
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }else{
            self.view.endEditing(true)
        }
          self.revealViewController().rearViewRevealWidth = 225
    }
    
    func viewControllerPassToLogin() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc1 = sb.instantiateViewControllerWithIdentifier("LoginVC") as! LoginViewController
        self.navigationController?.pushViewController(vc1, animated: true)
        
    }
    
    func tokenCheck() {
               if Reachability.isConnectedToNetwork(){
        ServerManager.sharedInstance().checkTokenHealth(nil) { (isSuccessful, error, result) in
            if isSuccessful{
                self.hideHud()
                checkTokenHealth = true
                self.hideHud()
            }else{
                AlertView.alertViewToGoToLogin("OK", message:"error_login", alertTitle: "OK", viewController: self)
                self.hideHud()
            }
        }
    }
    else {
    self.hideHud()
    AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
       }
    }

    func toastView(text:String) {
        let toastLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height-100, 300, 25))
        toastLabel.backgroundColor = UIColor.orangeColor()
        toastLabel.textColor = UIColor.blackColor()
        toastLabel.textAlignment = NSTextAlignment.Center;
        toastLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 15)
        self.view.addSubview(toastLabel)
        toastLabel.text = text
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true
        
        UIView.animateWithDuration(2.0, delay: 0.1, options: .CurveEaseOut, animations: {
            toastLabel.alpha = 0.5
        }) { (completion) in
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

    func toastViewForTextfield(text:String) {
        let toastLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height-100, 300, 25))
        toastLabel.backgroundColor = UIColor.orangeColor()
        toastLabel.textColor = UIColor.blackColor()
        toastLabel.textAlignment = NSTextAlignment.Center;
        toastLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 15)
        self.view.addSubview(toastLabel)
        toastLabel.text = text
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true

        UIView.animateWithDuration(4.0, delay: 0.1, options: .CurveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }) { (completion) in
            
        }
    }
    
    func toastViewWithNavigation(text:String , identifierString:String) {
        let toastLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height-100, 300, 25))
        toastLabel.backgroundColor = UIColor.orangeColor()
        toastLabel.textColor = UIColor.blackColor()
        toastLabel.textAlignment = NSTextAlignment.Center;
        toastLabel.font = UIFont (name: "HelveticaNeue-Bold", size: 15)
        self.view.addSubview(toastLabel)
        toastLabel.text = text
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true
        
        UIView.animateWithDuration(3.0, delay: 0.1, options: .CurveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }) { (completion) in
            let mapViewControllerObj = self.storyboard?.instantiateViewControllerWithIdentifier(identifierString)
            //                    self.presentViewController(mapViewControllerObj!, animated: true, completion: nil)
            self.navigationController?.pushViewController(mapViewControllerObj!, animated: true)
        }
    }

    func collectionViewCustomLabel(labelString:String , collectionView:UICollectionView!) {
        let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        emptyLabel.text = labelString
        emptyLabel.textAlignment = NSTextAlignment.Center
        collectionView.backgroundView = emptyLabel
        emptyLabel.textColor = UIColor.grayColor()
    }

    func tableViewCustomLabel(labelString:String , tableView:UITableView!) {
        let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        emptyLabel.text = labelString
        emptyLabel.textAlignment = NSTextAlignment.Center
        tableView.backgroundView = emptyLabel
        emptyLabel.textColor = UIColor.grayColor()
    }


}