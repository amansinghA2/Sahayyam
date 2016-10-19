//
//  AppDelegate.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import CoreData
import SwiftLoader

var token = String()
var customerType = Int()
var profileType = Int()
var profile = Bool()
var isChecked = Bool()
var defaultVendorName = String()
var defaultvendorId = String()
var sessionID = String()
var checkTokenHealth = Bool()
var defaultVendorID = String()
var filteredArr = [CategoryList]()
var address = String()
var customerFullName = String()
var telephone = String()
var vendorAddress = String()
var vendorEntry = String()
var otpId = String()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
//        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
//        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
//        
//        application.registerUserNotificationSettings(pushNotificationSettings)
//        application.registerForRemoteNotifications()
//        
//        if let launchOptions = launchOptions {
//            let userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] as? [NSObject: AnyObject]
//            let aps = userInfo!["aps"] as? [NSObject: AnyObject]
//            let alert1 = aps!["alerts"] as? String
//            let link1 = aps!["links"] as? String
//            print(userInfo)
//        }
        
        if let defaultVendName = NSUserDefaults.standardUserDefaults().objectForKey("defaultvendorName"){
            defaultVendorName = defaultVendName as! String
        }
        
        if let defaultVendName = NSUserDefaults.standardUserDefaults().objectForKey("tel"){
            telephone = defaultVendName as! String
        }
        
        if let defaultVendName = NSUserDefaults.standardUserDefaults().objectForKey("vendorAddress"){
            vendorAddress = defaultVendName as! String
        }
        
//        if let defaultVendName = NSUserDefaults.standardUserDefaults().objectForKey("defaultvendorName"){
//            defaultVendorName = defaultVendName as! String
//        }
        
        if let customerFullName1 = NSUserDefaults.standardUserDefaults().objectForKey("customerFullName"){
            customerFullName = customerFullName1 as! String
        }
        
        if let defaultVendName = NSUserDefaults.standardUserDefaults().objectForKey("defaultVendorID"){
            defaultVendorID = defaultVendName as! String
        }
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("categoryLists") as? NSData {
           filteredArr = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [CategoryList]
        }
        
        if let address1 = NSUserDefaults.standardUserDefaults().objectForKey("address"){
            address = address1 as! String
        }
        
        if NSUserDefaults.standardUserDefaults().boolForKey("isChecked"){
            if let token1 = NSUserDefaults.standardUserDefaults().objectForKey("token"){
                token = token1 as! String
                if let sessionid1 = NSUserDefaults.standardUserDefaults().objectForKey("sessionID"){
                     sessionID = sessionid1 as! String
                    
                }
            }
            
            
            
            if let customerType1 = NSUserDefaults.standardUserDefaults().objectForKey("customerType"){
                customerType = customerType1 as! Int
            }
            
            if let profileType1 = NSUserDefaults.standardUserDefaults().objectForKey("profileType"){
                profileType = profileType1 as! Int
            }
            
            if let profile1 = NSUserDefaults.standardUserDefaults().objectForKey("profile"){
                profile = profile1 as! Bool
            }
            
            if let isChecked1 = NSUserDefaults.standardUserDefaults().objectForKey("isChecked"){
                isChecked = isChecked1 as! Bool
            }

            switch profile{
            case true:
                switch customerType{
                case 1:
                    viewControllerPassing("Main", identifier: "CustomerUPViewController")
                case 2:
                    viewControllerPassing("Main", identifier: "VendorUpdateID")
                default:
                    print("")
                }
            case false:
                switch customerType{
                case 0:
                    switch profileType{
                    case 1:
                        viewControllerPassing("Main", identifier: "SwitchUVController")
                    case 3:
                        viewControllerPassing("Main", identifier: "SwitchUVController")
                    default:
                        print("")
                    }
                case 1:
                    viewControllerPassing("Customer", identifier: "revealView")
               
                case 2:
                    viewControllerPassing("Main", identifier: "LoginVC")

                case 3:
                    viewControllerPassing("Main", identifier: "SwitchUVController")
                default:
                    print("")
                }
            }


        }else{
            
        }
        
        return true
    }


//    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//        print("DEVICE TOKEN = \(deviceToken)")
//    }
//    
//    
//    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
//        print(error)
//    }
//    
//    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        print(userInfo)
//    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.

    }

    func viewControllerPassing(storyBoard:String , identifier:String) {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
        let viewController = storyBoard.instantiateViewControllerWithIdentifier(identifier)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }

}

