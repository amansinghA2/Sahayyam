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
import Google
import CloudKit

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
var devicetoken = String()
var gcmSenderID = "297087598426"
var registrationOptions = [String:AnyObject]()
var gcmRegistrationToken: String?
let gcmRegistrationKey = "onRegistrationCompleted"
var connectedToGCM = false
var subscribedToTopic = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , GGLInstanceIDDelegate , GCMReceiverDelegate{

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
//        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
//        let pushNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)
//        
//        application.registerUserNotificationSettings(pushNotificationSettings)
//        application.registerForRemoteNotifications()
//        
//        if let launchOptions = launchOptions {
//           
//        }
        
        // ...
        // Register for remote notifications
//            let settings: UIUserNotificationSettings =
//                UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
//            application.registerUserNotificationSettings(settings)
//
//            application.registerUserNotificationSettings(settings)
//            application.registerForRemoteNotifications()
        
        var configureError:NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        gcmSenderID = GGLContext.sharedInstance().configuration.gcmSenderID
        // [END_EXCLUDE]
        // Register for remote notifications
        let settings: UIUserNotificationSettings =
            UIUserNotificationSettings( forTypes: [.Alert, .Badge, .Sound], categories: nil )
        application.registerUserNotificationSettings( settings )
        application.registerForRemoteNotifications()
        // [END register_for_remote_notifications]
        // [START start_gcm_service]
        let gcmConfig = GCMConfig.defaultConfig()
        gcmConfig.receiverDelegate = self
        GCMService.sharedInstance().startWithConfig(gcmConfig)
        
        
        // Create a config and set a delegate that implements the GGLInstaceIDDelegate protocol.
        if let defaultVendName = NSUserDefaults.standardUserDefaults().objectForKey("defaultvendorName"){
            defaultVendorName = defaultVendName as! String
        }
        
        if let defaultVendName = NSUserDefaults.standardUserDefaults().objectForKey("tel"){
            telephone = defaultVendName as! String
        }
        
        if let defaultVendName = NSUserDefaults.standardUserDefaults().objectForKey("vendorAddress"){
            vendorAddress = defaultVendName as! String
        }

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


    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for i in 0..<deviceToken.length {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        devicetoken = tokenString
        print(devicetoken)
        
        let instanceIDConfig = GGLInstanceIDConfig.defaultConfig()
        instanceIDConfig.delegate = self
        // Start the GGLInstanceID shared instance with that config and request a registration
        // token to enable reception of notifications
        GGLInstanceID.sharedInstance().startWithConfig(instanceIDConfig)
        registrationOptions = [kGGLInstanceIDRegisterAPNSOption:deviceToken,
                               kGGLInstanceIDAPNSServerTypeSandboxOption:true]
        GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID,
                                                                 scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: gcmRegistrationHandler)
//        print("tokenString: \(tokenString)")
//        
//        print("DEVICE TOKEN = \(deviceToken)")
//        let resstr = String(data: deviceToken, encoding: 4)
//        devicetoken = resstr!
//        print(devicetoken)
    }
    
    func gcmRegistrationHandler(registrationToken: String!, error: NSError!) {
        if (registrationToken != nil) {
            gcmRegistrationToken = registrationToken
            print("GCM Registration Token: \(registrationToken)")
            let userInfo = ["registrationToken": registrationToken]
            NSNotificationCenter.defaultCenter().postNotificationName(
                gcmRegistrationKey, object: nil, userInfo: userInfo)
        } else {
            print("Registration to GCM failed with error: \(error.localizedDescription)")
            let userInfo = ["error": error.localizedDescription]
            NSNotificationCenter.defaultCenter().postNotificationName(gcmRegistrationKey, object: nil, userInfo: userInfo)
        }
    }
    
    // MARK: - GGLInstanceIDDelegate
    
    
    func onTokenRefresh() {
        // A rotation of the registration tokens is happening, so the app needs to request a new token.
        print("The GCM registration token needs to be changed.")
        GGLInstanceID.sharedInstance().tokenWithAuthorizedEntity(gcmSenderID,
                                                                 scope: kGGLInstanceIDScopeGCM, options: registrationOptions, handler: gcmRegistrationHandler)
    }
    
    // MARK: - GCMReceiverDelegate
    func willSendDataMessageWithID(messageID: String!, error: NSError!) {
        if (error != nil) {
            // Failed to send the message.
        } else {
            // Will send message, you can save the messageID to track the message
        }
    }
    
    func didSendDataMessageWithID(messageID: String!) {
        // Did successfully send message identified by messageID
    }
    // [END upstream_callbacks]
    
    func didDeleteMessagesOnServer() {
        // Some messages sent to this device were deleted on the GCM server before reception, likely
        // because the TTL expired. The client should notify the app server of this, so that the app
        // server can resend those messages.
    }
    
    func subscribeToTopic() {
        // If the app has a registration token and is connected to GCM, proceed to subscribe to the
        // topic
        let subscriptionTopic = "/topics/test-global"
        if(gcmRegistrationToken != nil && connectedToGCM) {
            GCMPubSub.sharedInstance().subscribeWithToken(gcmRegistrationToken, topic: subscriptionTopic,
                                                          options: nil, handler: {(error) -> Void in
                                                            if (error != nil) {
                                                                // Treat the "already subscribed" error more gently
                                                                if error.code == 3001 {
                                                                    print("Already subscribed to \(subscriptionTopic)")
                                                                } else {
                                                                    print("Subscription failed: \(error.localizedDescription)");
                                                                }
                                                            } else {
                                                                subscribedToTopic = true;
                                                                NSLog("Subscribed to \(subscriptionTopic)");
                                                            }
            })
        }
    }
    
  
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Connect to the GCM server to receive non-APNS notifications
        GCMService.sharedInstance().connectWithHandler({(error:NSError?) -> Void in
            if let error = error {
                print("Could not connect to GCM: \(error.localizedDescription)")
            } else {
               // self.connectedToGCM = true
                connectedToGCM = true
                print("Connected to GCM")
            }
        })
    }
    
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print(error)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        application.applicationIconBadgeNumber += 1
        
        print(userInfo)
        let apsInfo = userInfo["aps"] as! NSDictionary
        
        var alertMessage = ""
        print("********************** Received Notif")
        
        if let alert = apsInfo["alert"] as? String{
            alertMessage = alert
            print(alertMessage)
        }
        else if let alert = apsInfo["alert"] as? NSDictionary, let body = alert["body"] as?  String {
            alertMessage = body
            print(alertMessage)
        }
        
        
        // If the application is currently on screen "Active" then we trigger a custom banner View for that notification to be shown
        // Else the system will handle that and put it in the notification center
        if application.applicationState == UIApplicationState.Active {
            print("App Active")
//            AGPushNoteView.showWithNotificationMessage(alertMessage, autoClose: true, completion: { () -> Void in
//                // Do nothing
//            })
        }
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        GCMService.sharedInstance().disconnect()
        
        connectedToGCM = false
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

//    func applicationDidBecomeActive(application: UIApplication) {
//        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
       // self.saveContext()

    }

    func viewControllerPassing(storyBoard:String , identifier:String) {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
        let viewController = storyBoard.instantiateViewControllerWithIdentifier(identifier)
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }

}

