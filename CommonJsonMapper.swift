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
                    if let profileType = dic["profileType"]{
                        loginData.profileType = profileType as! Int
                    }
                    if let cust_type = dic["cust_type"]{
                        loginData.cust_type = cust_type as! Int
                    }
                }

                if let dic = result["customer"] {
                    if let address = dic["address"]{
                        loginData.address = address as! String
                    }
                    
                    if let city = dic["city"]{
                        loginData.city = city as! String
                    }
                    
                    if let country = dic["country"]{
                        loginData.country = country as! String
                    }
                    
                    if let postcode = dic["postcode"]{
                        loginData.postcode = postcode as! String
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



