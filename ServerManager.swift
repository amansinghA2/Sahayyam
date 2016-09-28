                                  //
//  ServerManager.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ServerManager: NSObject {
    
    let defaultManager: Alamofire.Manager! = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = [
            "Content-Type": "application/graphql",
            "Accept": "text/html"
            //Optional
        ]
        return Alamofire.Manager(

        )
    }()

    class func sharedInstance() -> ServerManager {
        struct Static {
            static let sharedInstance = ServerManager()
        }
        return Static.sharedInstance
    }
    
   
    
    func requestUserLoginWithCredential(userName:String! , passWord:String!, completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: CustomerLoginData?) -> Void) {
        
        let params = [
            "username":userName,
            "password":passWord,
            "device_id":"1234"
        ]
        
        defaultManager.request(.POST, urlString, parameters: params, encoding: .URL, headers: nil)
            .responseJSON { response in
                if let  _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            if let isSuccess = dict["success"]! {
                                if isSuccess as! Bool {
                                    print(dict)
                                let loginData = CommonJsonMapper.loginMapper(dict as! [String : AnyObject])
                                    completionClosure(isSuccessful: true, error: nil, result: loginData)
                                    self.getSessionID(response)
                                }else{
                                    completionClosure(isSuccessful: false, error: nil, result: nil)
                                }
                            }
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
        }
    }
    
    func requestSwitchProfile(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, switchProfileUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            if let success = dict["success"]{
                                if success as! Bool {
                                    print(dict)
                               let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                                    completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
                                }else{
                                    completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                                }
                            }
                                }else{
                                    completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                                }
                    case .Failure( _):
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
        }
    }

    func getSessionID(response:(Response<AnyObject, NSError>)){
        let cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL((response.response?.URL)!)
        
        for (_ , element) in cookies!.enumerate() {
            if element.value.characters.count > 15 {
            sessionID = element.value
             NSUserDefaults.standardUserDefaults().setObject(sessionID, forKey: "sessionID")
              }
            }
         }
    
    // MARK: - Logout
    
    func loginLogout(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result:[String : AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
         defaultManager.request(.POST, loginLogoutUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            completionClosure(isSuccessful: true, error: nil, result: dict as? [String:AnyObject])
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(_):
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
        }
    }
    
    // MARK: - Check Token HEalth
    
    func checkTokenHealth(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result:[String : AnyObject]?) -> Void) {
        
        let params:[String:AnyObject]? = [
            "token":token,
            "device_id":"1234"
        ]
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        print(params)
        print(headers)
        
        defaultManager.request(.POST, checkTokenHealthUrl, parameters: params!, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            if let result = dict["success"] as? Bool{
                                if result {
                                    print(result)
                                    print(dict)
                                    completionClosure(isSuccessful: true, error: nil, result: dict as? [String:AnyObject])
                                }else{
                                    print(dict)
                                    let error = dict["error"] as! String
                                    completionClosure(isSuccessful: false, error: error, result: dict as? [String:AnyObject])
                                }
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
        }
    }
    
    
    func passwordChange(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result:[String : AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        print(params)
        print(headers)
        
        defaultManager.request(.POST, passswrodCOnfirmPasswordUrl, parameters: params!, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            completionClosure(isSuccessful: true,error: nil,result: nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
        }
    }

    
    
}



    

