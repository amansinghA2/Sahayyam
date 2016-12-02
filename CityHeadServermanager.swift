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
    
    func subscriptionInfo(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: SubsInfoDetails? , dictResult:[String:AnyObject]?) -> Void) {
        
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
                            let arr = CommonJsonMapper.getSubscriptionInfoMapper(dict as! [String : AnyObject])
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

    
    func addVendorGetData(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CHVendorGetData]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, addVendorPopulateDataUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.addVendorGetDataMapper(dict as! [String : AnyObject])
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

    
    func cityWisePincodeLocation(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: CHCitywisePincode? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, getCityWisePincodeUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.cityWisepincodeMapper(dict as! [String : AnyObject])
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
    
    
    func chVendorListForSbbscription(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CHVendorSubsList]? , dictResult:[String:AnyObject]?) -> Void) {
        
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
                            let arr = CommonJsonMapper.vendorListForSubscriptionMapper(dict as! [String : AnyObject])
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
    
    func chVendorListFree(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: FreeUnpaidVendorList? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, freeToPaidUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.vendorListForFreenMapper(dict as! [String : AnyObject])
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
    
    func chAddCustomerGetdataUrl(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CHVendorSubsList]? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, cityheadAddCustomerUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.vendorListForAddCustomer(dict as! [String : AnyObject])
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
    
    func chAddCustomerUrl(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: FreeUnpaidVendorList? , dictResult:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, addSingleCustomerUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.vendorListForFreenMapper(dict as! [String : AnyObject])
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

