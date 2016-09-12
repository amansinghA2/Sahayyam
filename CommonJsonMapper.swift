//
//  CommonJsonMapper.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 01/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import CoreData

class CommonJsonMapper: NSObject {

// MARK: - Login 

    class func loginMapper(result:[String:AnyObject])  -> CustomerLoginData {
            let loginData = CustomerLoginData()
                if let dic = result["switchprofile"]{
                    if let profileType = dic["profileType"] as? Int{
                        loginData.profileType = profileType
                    }
                    if let cust_type = dic["cust_type"] as? Int {
                        loginData.cust_type = cust_type
                    }
                }

                if let dic = result["customer"] {
                    if let address = dic["address"] as? String{
                        loginData.address = address
                    }
                    
                    if let address = dic["firstname"] as? String{
                        loginData.firstName = address
                    }
                    
                    if let address = dic["lastname"] as? String{
                        loginData.lastName = address
                    }
                    
                    if let city = dic["city"] as? String {
                        loginData.city = city
                    }
                    
                    if let country = dic["country"] as? String{
                        loginData.country = country
                    }
                    
                    if let postcode = dic["postcode"] as? String{
                        loginData.postcode = postcode 
                    }
                }
        
        
        
                if let profile = result["profile"] {
                    loginData.profile = profile as! Bool
                    
                }
                if let cookie = result["cookie"] {
                    loginData.cookie = cookie as! String
            }
        
        if let vendors = result["vendors"] as? NSArray{
            for (_,value) in vendors.enumerate() {
                let vendorList = VendorList()
                vendorList.defaultVendorId = value.valueForKey("is_default") as! String
                vendorList.nickname = value.valueForKey("nickname") as! String
                loginData.vendorList.append(vendorList)
            }
        }
        
        
        
        if let arr = result["category"] as? NSArray{
            for (_, value) in arr.enumerate(){
                let categoryList = CategoryList()
                if let categoryID = value.valueForKey("category_id"){
                    categoryList.category_id = categoryID as! String
                }
                if let categoryName = value.valueForKey("name"){
                    let str  = categoryName as! String
                    let name = str.stringByReplacingOccurrencesOfString("&nbsp;", withString:"")
                    categoryList.name = name
                }
                if let active = value.valueForKey("active"){
                    categoryList.active = active as! String
                }
                let level:AnyObject = value.valueForKey("level")!
                if level is String {
                    categoryList.level = level as! String
                }else{
                    categoryList.level = String(level)
                }
                if let products = value.valueForKey("products"){
                    categoryList.products = products as! String
                }
                if let parentId = value.valueForKey("parent_id"){
                    categoryList.parent_id = parentId as! String
                }
               loginData.categoryList.append(categoryList)
            }
        }
        return loginData
    }
}



