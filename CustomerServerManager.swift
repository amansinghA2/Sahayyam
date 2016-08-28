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

extension ServerManager {

    // MARK: Customer Products List

    func customerProducts(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [ProductCollectionList]?) -> Void) {
        
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
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(_):
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
           }
    }

    func customerProductDetails(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: ProductDetails?) -> Void) {

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
                    case .Failure(_):
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
         }
    }

    // MARK: Cart List

    func customerGetCartList(params:[String:AnyObject]?,  completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [Products]? , dict:[String : AnyObject]?) -> Void) {

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
                        completionClosure(isSuccessful: false,error: nil,result: nil , dict: nil)
                    }
                }
        }
    }

    func customerAddToCart(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: Dictionary<String,String>?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, customerAddToCartUrl, parameters: params, encoding: .URL, headers: headers)
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
                        let errorInfo = ["code":res.statusCode,"message":error.userInfo["NSLocalizedFailureReason"]!]
                        completionClosure(isSuccessful: false,error: errorInfo,result: nil)
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
//                        let errorInfo = ["code":res.statusCode,"message":error.userInfo["NSLocalizedFailureReason"]!]
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }

    // MARK: - Checkout

    func customerCheckout(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {

        
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
                            completionClosure(isSuccessful: true, error: nil, result: dict as? Dictionary<String, String>)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        print(error)
//                        let errorInfo = ["code":res.statusCode,"message":error.userInfo["NSLocalizedFailureReason"]!]
            
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }

    // MARK: Wish LIst

    func customerGetWishlistList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result:[WishlistProductList]?) -> Void) {

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
                    case .Failure(_):
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
        }
    }

    func customerAddtoWishlist(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: Dictionary<String,String>?) -> Void) {
        
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
                    case .Failure(_):
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
        }
    }

    func customerRemovefromWishlist(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: Dictionary<String,String>?) -> Void) {

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
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
        }
    }

    // MARK: - Promotion

    func customerPromotion (params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: Dictionary<String,String>?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, customerPromotionUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let res = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            completionClosure(isSuccessful: true, error: nil, result: dict as? Dictionary<String, String>)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        let errorInfo = ["code":res.statusCode,"message":error.userInfo["NSLocalizedFailureReason"]!]
                        completionClosure(isSuccessful: false,error: errorInfo,result: nil)
                    }
                }
        }
    }
    

    // MARK: Track Orders

    func customerOrders(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CustomerOrders]?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, customerOrdersUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = CommonJsonMapper.customerProductsOrdersMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(_):
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
        }
    }

    func customerOrderDetails(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: CustomerOrderDetails?) -> Void) {

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
                    case .Failure(_):
                        //                        let errorInfo = ["code":res.statusCode,"message":error.userInfo["NSLocalizedFailureReason"]!]
                        completionClosure(isSuccessful: false,error: nil,result: nil)
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
                        //                        let errorInfo = ["code":res.statusCode,"message":error.userInfo["NSLocalizedFailureReason"]!]
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }

    
    func customerSetDefaultVendor(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: [CategoryList]?) -> Void) {

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
                    case .Failure(_):
                        //                        let errorInfo = ["code":res.statusCode,"message":error.userInfo["NSLocalizedFailureReason"]!]
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
        }
    }

    // MARK: - Update Profile

    func customerUpdateProfilePopulateData(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: PopulateData?) -> Void) {
        
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
                            let arr = CommonJsonMapper.customerPopulateDataMapper((dict as? [String:AnyObject])!)
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(_):
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
                }
            }
        }

    func customerUpdateProfile(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result: Dictionary<String,String>?) -> Void) {

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
                    case .Failure(_):
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
             }
        }
    }
    
    func customerUploadImage(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:[String:AnyObject]?, result:[String : AnyObject]?) -> Void) {

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
                    case .Failure(_):
                        completionClosure(isSuccessful: false,error: nil,result: nil)
                    }
               }
         }
    }
    
// MARK: - Categories
    

}
