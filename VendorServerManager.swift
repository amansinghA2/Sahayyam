//
//  VendorServerManager.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

extension ServerManager {
    
 
    func vendorsCategoryList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [ProductCollectionList]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, categoryUrl, parameters: params, encoding: .URL, headers: headers)
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
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }
    
    func getCustomerList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: ProductDetails?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, getCustomerUrl, parameters: params, encoding: .URL, headers: headers)
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
    
    func getVendorSubscription(params:[String:AnyObject]?,  completionClosure: (isSuccessful:Bool,error:String?, result: [Products]? , dict:[String : AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorSubscriptionurl, parameters: params, encoding: .URL, headers: headers)
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
    
    func getTransactions(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, transactionsUrl, parameters: params, encoding: .URL, headers: headers)
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
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }
    
    func viewVendorOrders(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, viewordersUrl, parameters: params, encoding: .URL, headers: headers)
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
    
    
    func getVendorGlobalList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {
        
        //token, product_name, limit, page, device_id, global=1, service_id
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, globalLIstUrl, parameters: params, encoding: .URL, headers: headers)
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
    
    func getVendorServices(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [String:AnyObject]?) -> Void) {
        
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, getVendorServicesUrl, parameters: params, encoding: .URL, headers: headers)
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
    
    func vendorMyProductsList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result:[WishlistProductList]?) -> Void) {
        
        //token, product_name,  limit, page, device_id, global=0, service_id
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, myproductsGlobalListUrl, parameters: params, encoding: .URL, headers: headers)
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
    
    func autocompleteCategoryList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {
        
        //token, service_id, service_id, filter_name
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, autoCompleteCategoryUrl, parameters: params, encoding: .URL, headers: headers)
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
    
    func displayPromotionList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {
        
        //token, device_id
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, displayPromotionListUrl, parameters: params, encoding: .URL, headers: headers)
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
    
    func addPromotion(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {
        //token, device_id, product[name], product[productQuantity], product[image], product[amount], product[productUnitId], product[description], product[fromDate], product[endDate], product[productDiscountType], product[amtDiscountType], product[productId], product[product_id], product[promotion_id]
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, addpromotionUrl, parameters: params, encoding: .URL, headers: headers)
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
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }
    
    
    // MARK: Track Orders
    
    func editProduct(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [CustomerOrders]?) -> Void) {
        
        // token, device_id, manufacturer_id, manufacturer, product_category[], product_id, product_description[1][name], product_description[1][description], image, price, product_special[0][price], weight_class_id, weight, quantity, subtract, "status, product_description[1][meta_title], "model, service_id, product_special[0][customer_group_id], product_special[0][date_start], product_special[0][date_end], product_special[0][priority], ref_code
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, editproducturl, parameters: params, encoding: .URL, headers: headers)
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
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
        }
    }
    
    func editPromotion(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: CustomerOrderDetails?) -> Void) {
        
        //token, device_id, product[name], product[productQuantity], product[image], product[amount], product[productUnitId], product[description], product[fromDate], product[endDate], product[productDiscountType], product[amtDiscountType], product[productId], product[promotion_id]
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, editpromotionurl, parameters: params, encoding: .URL, headers: headers)
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
    
    
    func registerCustomer(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [VendorList]?) -> Void) {
        
        // token, device_id, telephone
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, registerCustomerUrl , parameters: params, encoding: .URL, headers: headers)
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
    
    
    func vendorOrderDetails(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [CategoryList]?) -> Void) {
        
        // order_id, device_id, token
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendororderdetailsUrl , parameters: params, encoding: .URL, headers: headers)
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
    
    
    
}