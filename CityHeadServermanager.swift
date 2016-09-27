//
//  CityHeadServermanager.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Foundation


extension ServerManager {
    
    
    func chPasswordChange(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, changePasswordUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                                    print(dict)
                                    let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                                    completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
            
                            }
                         else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                        }
                    case .Failure( _):
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
        }
    }
    
    func subscriptionInfo(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, subscriptionInfoUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
                            
                        }
                        else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                        }
                    case .Failure( _):
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
        }
    }

    
    func freeSubscriptionInfo(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, freeSubscriptionUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
                            
                        }
                        else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                        }
                    case .Failure( _):
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
        }
    }

    
    func paidSubscriptionInfo(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, paidSubscriptionUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
                            
                        }
                        else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                        }
                    case .Failure( _):
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
        }
    }

    
    func addVendorGetData(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, addVendorPopulateDataUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
                            
                        }
                        else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
            }
        }

    
    func cityWisePincodeLocation(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, getCityWisePincodeUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
                            
                        }
                        else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                        }
                    case .Failure( _):
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
        }
    }

    
    func getCHCategories(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, getCategoriesUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
                            
                        }
                        else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                        }
                    case .Failure( _):
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
        }
    }
    
    func addNewVendor(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, chAddNewVendorUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
                        }
                        else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                        }
                    case .Failure( _):
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
            }
       }
    
    func chStorePromotionUrl(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, storePormotionUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
                            
                        }
                        else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                        }
                    case .Failure( _):
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
        }
    }
    
    
    func chVendorListForSbbscription(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [SubsNameDetails]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorListSubscriptionUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getSubsDetailsMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , dictResult: dict as? [String:AnyObject])
                            
                        }
                        else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dictResult: nil)
                        }
                    case .Failure( _):
                        completionClosure(isSuccessful: false,error: nil,result: nil , dictResult: nil)
                    }
                }
        }
    }
    
    
}

