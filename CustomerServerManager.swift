//
//  CustomerServerManager.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 29/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

extension ServerManager {

    // MARK: Customer Products List

    func customerProducts(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [ProductCollectionList]? , result1:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, customerProductsUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr  = CommonJsonMapper.productCollectionList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , result1: dict as? [String : AnyObject])
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil , result1: nil)
                    }
                }
           }
    }

    func customerProductDetails(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: ProductDetails?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, customerProductDetailsUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let detail = CommonJsonMapper.getproductDetails(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result:detail)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
         }
    }

    // MARK: Cart List

    func customerGetCartList(params:[String:AnyObject]?,  completionClosure: (isSuccessful:Bool,error:String?, result: [Products]? , dict:[String : AnyObject]?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, customergetcartListUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getCartListMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , dict: dict as? [String : AnyObject])
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dict: nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil , dict: nil)
                    }
                }
        }
    }

    func customerAddToCart(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerAddToCartUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let res = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            if let result = dict["success"]!{
                                if result as! Bool {
                                    completionClosure(isSuccessful: true, error: nil, result: dict as? Dictionary<String, String>)
                                }else{
                                    completionClosure(isSuccessful: false, error: nil, result: dict as? Dictionary<String, String>)
                                }
                            }
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
           }
     }
    
    func customerEditToCart(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerEditToCartUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let res = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            if let result = dict["success"]!{
                                if result as! Bool {
                                    completionClosure(isSuccessful: true, error: nil, result: dict as? Dictionary<String, String>)
                                }else{
                                    completionClosure(isSuccessful: false, error: nil, result: dict as? Dictionary<String, String>)
                                }
                            }
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
                }
        }
    }


    func customerRemoveFromCart(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {

        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerRemoveFromCartUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let res = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            completionClosure(isSuccessful: true, error: nil, result: dict as? Dictionary<String, String>)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):

                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }

    // MARK: - Checkout

    func customerCheckout(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [String:AnyObject]?) -> Void) {

        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerCheckoutListUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let res = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                          
                            completionClosure(isSuccessful: true, error: nil, result: dict as? [String : AnyObject])
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }

    // MARK: Wish LIst

    func customerGetWishlistList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result:[WishlistProductList]?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerGetWishlistUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr  =  CommonJsonMapper.getWishlistListMapper(dict as! [String : AnyObject])
                            print(arr)
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure( let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }

    func customerAddtoWishlist(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerAddToWishlist, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            completionClosure(isSuccessful: true, error: nil, result: dict as? Dictionary<String, String>)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }

    func customerRemovefromWishlist(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, customerRemoveFromWishListUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            completionClosure(isSuccessful: true, error: nil, result: dict as? Dictionary<String, String>)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }

    // MARK: - Promotion

    func customerPromotion (params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [DisplayPromotionDetails]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, customerPromotionUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let res = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.customerPromotionOrdersMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }
    

    // MARK: Track Orders

    func customerOrders(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [CustomerOrders]?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, customerOrdersUrl, parameters: params, encoding: .URL, headers: headers)
            .responseData { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let data = response.result.value {
                            let dict = JSON(data: data)
                            let arr = CommonJsonMapper.customerProductsOrdersMapper(dict)
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }
                        else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }

    func customerOrderDetails(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: CustomerOrderDetails?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, customerOrderDetailsUrl, parameters: params, encoding: .URL, headers: headers)
            .validate()
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                         let arr = CommonJsonMapper.customerProductsDetailsMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
                }
        }
    }

    // MARK: - Vendors List and Default vendor

    
    func customerGetVendorsList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [VendorList]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, inCustomersVendorListUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                          let arr = CommonJsonMapper.getVendorList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        print(error)
                      completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
                }
        }
    }

    
    func customerSetDefaultVendor(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [CategoryList]?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, setDefaultVendorUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                       completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
                }
        }
    }

    // MARK: - Update Profile

    func customerUpdateProfilePopulateData(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: PopulateData?) -> Void) {
        
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerUpdateProfilePopulateUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.customerPopulateDataMapper((dict as? [String:AnyObject])!)
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                       completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
                }
            }
        }

    func customerUpdateProfile(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerUpdateProfileUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            completionClosure(isSuccessful: true, error: nil, result: dict as? Dictionary<String, String>)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
             }
        }
    }
    
    func customerUploadImage(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result:[String : AnyObject]?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerUploadImageUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            completionClosure(isSuccessful: true, error: nil, result: dict as? [String:AnyObject])
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
               }
         }
    }
    
// MARK: - Push Notification
    
    func customerPushNotifications(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result:[String : AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, customerPushNotificationUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            completionClosure(isSuccessful: true, error: nil, result: dict as? [String:AnyObject])
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
                }
        }
    }
    
// MARK: - OTP Functionality
    
    func customerOTP(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerForgotPasswordUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            if let isSuccess = dict["success"] as? Bool{
                                if isSuccess == true {
                                    completionClosure(isSuccessful: true, error: nil, result: dict as? [String:AnyObject])
                                }else{
                                    completionClosure(isSuccessful: false, error: nil, result: nil)
                                }
                            }
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
                }
        }
    }
    
    // About Us
    
    func customerAboutus(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result:[VendorInfoAboutUs]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, aboutUsUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.aboutUsVendorMapper((dict as? [String:AnyObject])!)
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
                }
        }
    }

    

}
