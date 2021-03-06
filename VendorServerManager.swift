
//  VendorServerManager.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import AFNetworking

extension ServerManager {
    
 
    func vendorsCategoryList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [CategoryList]? , result1:[ServiceList]?) -> Void) {
        
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
                            let arr = CommonJsonMapper.getVendorcategoryList(dict as! [String : AnyObject])
                            let arr1 = VendorJSONMapper.getServiceList(dict as! [String : AnyObject])
                            print(arr)
                            completionClosure(isSuccessful: true, error: nil, result: arr , result1:arr1)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1:nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil , result1:nil)
                    }
                }
        }
    }
    
    func getCustomerList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [CustomerList]? , dict:[String:AnyObject]? ) -> Void) {
        
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
                            let detail = VendorJSONMapper.getCustomerListMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result:detail , dict:dict as? [String : AnyObject])
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , dict:nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil , dict:nil)
                    }
                }
        }
    }
    
    // MARK: Cart List
    
    func getVendorSubscription(params:[String:AnyObject]?,  completionClosure: (isSuccessful:Bool,error:String?, result: [SubscriptionList]? , dict:[String : AnyObject]?) -> Void) {
        
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
                            let arr = VendorJSONMapper.getSubscriptionDetailsMapper(dict as! [String : AnyObject])
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
    
    func getTransactionsHistory(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [VendorPayment]? , result1:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, transactionsUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.getTransactionsHistoryMapper(dict as! [String : AnyObject])
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
    
    func viewVendorOrders(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [CustomerOrders]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID,
        ]
    
        defaultManager.request(.GET, viewordersUrl, parameters: params, encoding: .URL, headers: headers)
            .validate()
            .responseData
            { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let data = response.result.value {
                            let dict = JSON(data: data)
                            print(dict)
                            let arr = CommonJsonMapper.customerProductsOrdersMapper(dict)
                            completionClosure(isSuccessful: true, error: nil, result: arr)
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
    
    func getproductDetails(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: Dictionary<String,String>?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, getProductdetailsUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
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
    
    // MARK: - Checkout
    
    func getVendorServices(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [VendorService]?) -> Void) {

        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, getVendorServicesUrl, parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if response.response != nil {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                         let arr = VendorJSONMapper.vendorServicesMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr )
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
    
    func vendorMyProductsList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:NSError?, result:[ProductCollectionList]? , result1:[String:AnyObject]?) -> Void) {
        
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
                            let arr  =  CommonJsonMapper.productCollectionList(dict as! [String : AnyObject])
                            print(arr)
                            completionClosure(isSuccessful: true, error: nil, result: arr ,result1:dict as? [String:AnyObject] )
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1:nil)
                        }
                    case .Failure( let error):
                        print(error)
                        completionClosure(isSuccessful: false,error:error ,result: nil , result1:nil)
                }
            }
        }
    }
    
    func autocompleteCategoryList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [ProductCategoryList]?) -> Void) {
        
        // token, service_id, service_id, filter_name
        
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
                            let arr = VendorJSONMapper.categoryDropDownListMapper(dict as! [AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr )
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil)
                    }
                }
            }
       }
    
    func displayPromotionList(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [VendorPromotionList]?) -> Void) {
        
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
                            if let error = dict["error"] as? String {
                                completionClosure(isSuccessful: false, error: error, result: nil)
                            }else{
                            let arr = VendorJSONMapper.getPromotionList((dict as? [String:AnyObject])!)
                            completionClosure(isSuccessful: true, error: nil, result: arr)
                            }
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
            "Cookie":"PHPSESSID=" + sessionID,
            "Content-Length": "500"
        ]
        
        defaultManager.request(.POST, addpromotionUrl, parameters: params, encoding: .URL, headers: headers)
             .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            if let sucess = dict["success"] as? Bool {
                                if sucess == true {
                                  completionClosure(isSuccessful: true, error: nil, result: dict as? Dictionary<String, String>)
                                }else{
                                    if let error = dict["error"] as? String {
                                       completionClosure(isSuccessful: false, error: error, result: dict as? Dictionary<String, String>)
                                    }
                                }
                            }
                            
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
    
    
    // MARK: Track Orders
    
    func addProduct(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [CustomerOrders]? , result1:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, addProductUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            completionClosure(isSuccessful: true, error: nil, result: nil , result1: dict as? [String : AnyObject])
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil , result1: nil)
                    }
                }
        }
    }
    
    func globalProductAdd(params:[String:AnyObject]? , completionClosure: (isSuccessful:Bool,error:String?, result: [CustomerOrders]? , result1:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
    
        defaultManager.request(.POST, globalAddProductUrl , parameters: params , encoding: .URL, headers: headers)

            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            completionClosure(isSuccessful: true,error: nil,result: nil , result1:dict as? [String:AnyObject])
                        }
                    case .Failure(_):
                        completionClosure(isSuccessful: false,error:nil,result: nil , result1:nil)
                      }
                }
          }
    }

    func editProduct(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [CustomerOrders]? , result1:[String:AnyObject]?) -> Void) {
        
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
                           // let arr = CommonJsonMapper.customerProductsOrdersMapper(dict)
                            completionClosure(isSuccessful: true, error: nil, result: nil , result1: dict as? [String:AnyObject])
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1:nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false,error: error.localizedDescription,result: nil , result1:nil)
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
                        print(error)
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
    
    func vendorOrderDetails(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: CustomerOrderDetails?) -> Void) {
        
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
    
    func sellerInfoSave(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: CustomerOrderDetails?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, sellerInfoUrl , parameters: params, encoding: .URL, headers: headers)
            .validate()
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                        print(dict)
                      //let dict = JSON(data: data)
                        completionClosure(isSuccessful: true, error: nil, result: nil)
                        print(dict)
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil)
                        }
                    case .Failure(let error):
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil)
                    }
                }
          }
    }
    
    func sellerPopulateData(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: SellerData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, sellerPopulateUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.sellerPopulateDataMapper(dict as! [String : AnyObject])
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
    
    // MARK: - Vendor ABout Us
    
    func vendorAboutUs(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: SellerData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, vendorAboutusUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.sellerPopulateDataMapper(dict as! [String : AnyObject])
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
    
    
    func cancelOrder(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: SellerData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, cancelLIneOrder , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.sellerPopulateDataMapper(dict as! [String : AnyObject])
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
    
    func blockunblockCustomers(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: SellerData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, blockSalesExecutiveUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.sellerPopulateDataMapper(dict as! [String : AnyObject])
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
    
    func blockMyProductsImage(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: SellerData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, blockMyProductsImageUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.sellerPopulateDataMapper(dict as! [String : AnyObject])
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
    
    func overallOrderStatusChange(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: SellerData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, changeOrderStatusUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.sellerPopulateDataMapper(dict as! [String : AnyObject])
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
    
    func vendorStoreProfile(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: StoreProfileData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, storeProfileUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorStoreProfileMapper(dict as! [String : AnyObject])
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
    
    func vendorStoreProfileGetData(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: StoreProfileData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, storeProfileUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorStoreProfileMapper(dict as! [String : AnyObject])
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

    
    // Mark: - CategoryList 
    
    func vendorAddCategory(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: StoreProfileData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, vendorCategoryAddUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorStoreProfileMapper(dict as! [String : AnyObject])
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
    
    func vendorEditcategory(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: StoreProfileData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, vendorEditCategoryUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            let arr = VendorJSONMapper.vendorStoreProfileMapper(dict as! [String : AnyObject])
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
    
    func vendorDeletCategory(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: StoreProfileData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, vendorDeleteCategoryUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorStoreProfileMapper(dict as! [String : AnyObject])
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
    
    // MARK :- Promotion
    
    
    func vendorNotifcation(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: StoreProfileData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendormobileNotificationUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorStoreProfileMapper(dict as! [String : AnyObject])
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
    
    func vendorDeactivatePromotion(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: StoreProfileData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorDeactivatePromotionUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorStoreProfileMapper(dict as! [String : AnyObject])
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
    
    func vendorDeletePromotion(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: StoreProfileData?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorDeletePromotionUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorStoreProfileMapper(dict as! [String : AnyObject])
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
    
    func vendorUnitGram(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [UnitGram]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorUnitGramUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.unitGramMapper(dict as! [String : AnyObject])
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
    
    func vendorRegistration(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [UnitGram]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, vendorRegistrationUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            if let dict1 = dict["success"] as? [String:AnyObject]{
                                if let _ = dict1["registered_no"] {
                                    completionClosure(isSuccessful: true, error: "Success", result: nil)
                                }
                            }
                            
                            if let dict1 = dict["error"] as? [String:AnyObject]{
                                if let str = dict1["regular_msg"] {
                                    completionClosure(isSuccessful: true, error: str as? String, result: nil)
                                }
                                
                                if let str = dict1["number_already_registered"] {
                                    completionClosure(isSuccessful: true, error: "number_already_registered " +  (str as! String), result: nil)
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
    
    
    
    func vendorProductDetailDetails(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: VendorProductInDetails?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, productDetailDetailsURl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.productDetailsDetailsMapper(dict as! [String : AnyObject])
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
    
    func vendorProductGetService(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: VendorServiceList?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorGetServiceURl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorProductGetServiceMapper(dict as! [String : AnyObject])
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
    
    func vendorProductAddService(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: VendorProductInDetails?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, vendorUpdateServicesURl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.productDetailsDetailsMapper(dict as! [String : AnyObject])
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
    
    func vendorProductCount(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: ProductApprovalStatus?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.POST, vendorProductCountUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorProductCountMapper(dict as! [String : AnyObject])
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
    
    func vendorApprovePendingRejected(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [ApprovePendingStatus]? , result1:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorApprovePendingRejectedUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorApprovePendingMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , result1:dict as? [String:AnyObject])
                            
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1:nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil , result1: nil)
                    }
                }
        }
    }
    
    func vendorSubsReg(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [ApprovePendingStatus]? , result1:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorSubsRegUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorApprovePendingMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , result1:dict as? [String:AnyObject])
                            
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1:nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil , result1: nil)
                    }
                }
        }
    }

    
    func vendorSubsRenew(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [ApprovePendingStatus]? , result1:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorSubsRenewUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorApprovePendingMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , result1:dict as? [String:AnyObject])
                            
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1:nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil , result1: nil)
                    }
                }
        }
    }

    
    func vendorSubsSubs(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [ApprovePendingStatus]? , result1:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorSubsUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorApprovePendingMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , result1:dict as? [String:AnyObject])
                            
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1:nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil , result1: nil)
                    }
                }
        }
    }
    
    func invoicePaymentFeesPerSales(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [ApprovePendingStatus]? , result1:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorInvoicePaymentUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorApprovePendingMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , result1:dict as? [String:AnyObject])
                            
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1:nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil , result1: nil)
                    }
                }
        }
    }
    
    func vendorInvoicePaymentFreetoPaid(params:[String:AnyObject]?  ,completionClosure: (isSuccessful:Bool,error:String?, result: [ApprovePendingStatus]? , result1:[String:AnyObject]?) -> Void) {
        
        let headers = [
            "Cookie":"PHPSESSID=" + sessionID
        ]
        
        defaultManager.request(.GET, vendorInvoiceFreeToPaidUrl , parameters: params, encoding: .URL, headers: headers)
            .responseJSON { response in
                if let _ = response.response {
                    switch response.result {
                    case .Success:
                        if let dict = response.result.value {
                            print(dict)
                            let arr = VendorJSONMapper.vendorApprovePendingMapper(dict as! [String : AnyObject])
                            completionClosure(isSuccessful: true, error: nil, result: arr , result1:dict as? [String:AnyObject])
                            
                        }else{
                            completionClosure(isSuccessful: false, error: nil, result: nil , result1:nil)
                        }
                    case .Failure(let error):
                        print(error)
                        completionClosure(isSuccessful: false, error: error.localizedDescription, result: nil , result1: nil)
                    }
                }
        }
    }

    
  
}
