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
                
                if let profile = value.valueForKey("is_default") as? String {
                    vendorList.defaultVendorId = profile
                    
                }
                
                if let profile = value.valueForKey("nickname") as? String{
                    vendorList.nickname = profile
                    
                }
                
                if let profile = value.valueForKey("address_1") as? String {
                    vendorList.address_1 = profile
                    
                }
                
                if let profile = value.valueForKey("tel") as? String {
                    vendorList.tel = profile
                    
                }
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
    
    class func aboutUsVendorMapper(result:[String:AnyObject])  -> [VendorInfoAboutUs] {

         var vendorInfos = [VendorInfoAboutUs]()
        
        if let getAddress = result["getAddress"] as? NSArray{
        
        for dict in getAddress {
         let vendorInfo = VendorInfoAboutUs()
        if let name = dict["address_1"] as? String{
            vendorInfo.address = name
        }
        
        if let name = dict["address_2"] as? String{
            vendorInfo.address1 = name
        }
        
        if let name = dict["city"] as? String{
            vendorInfo.city = name
        }
        
        if let name = dict["email"] as? String{
            vendorInfo.emailId = name
        }
        
        if let name = dict["postcode"] as? String{
            vendorInfo.postCode = name
        }
        
        if let name = dict["telephone"] as? String{
            vendorInfo.telephone = name
        }
        
         vendorInfos.append(vendorInfo)
        }
        
        }
        return vendorInfos
    }

    class func addVendorGetDataMapper(result:[String:AnyObject])  -> [CHVendorGetData] {
        
        var categoryLists = [CHVendorGetData]()
        
        if let arr = result["info"] as? NSArray{
            for (_, value) in arr.enumerate(){
                let categoryList = CHVendorGetData()
                if let categoryID = value.valueForKey("city_id") as? String{
                    categoryList.city_id = categoryID
                }
                if let categoryName = value.valueForKey("city_name") as? String{
                   categoryList.city_name = categoryName
                }
                if let categoryName = value.valueForKey("country_id") as? String{
                    categoryList.country_id = categoryName
                }
                if let categoryName = value.valueForKey("country_name") as? String{
                    categoryList.country_name = categoryName
                }
                if let categoryName = value.valueForKey("state") as? String{
                    categoryList.state = categoryName
                }
                if let categoryName = value.valueForKey("status") as? String{
                    categoryList.status = categoryName
                }
                if let categoryName = value.valueForKey("zone_id") as? String{
                    categoryList.zone_id = categoryName
                }
               categoryLists.append(categoryList)
            }
        }
       return categoryLists
    }
    
    
    class func cityWisepincodeMapper(result:[String:AnyObject])  -> CHCitywisePincode {
        
        let categoryLists = CHCitywisePincode()
        
        if let countryId = result["country_id"] as? String {
            categoryLists.country_id = countryId
        }
        
        if let countryId = result["country_name"] as? String {
            categoryLists.country_name = countryId
        }
        
        if let countryId = result["zone_id"] as? String {
            categoryLists.zone_id = countryId
        }
        
        if let countryId = result["city_id"] as? String {
            categoryLists.city_id = countryId
        }
        
        if let countryId = result["state"] as? String {
            categoryLists.state = countryId
        }
        
        if let countryId = result["city_name"] as? String {
            categoryLists.city_name = countryId
        }
        
        if let countryId = result["status"] as? String {
            categoryLists.status = countryId
        }
        
        if let arr = result["postcodes"] as? NSArray{
            for (_, value) in arr.enumerate(){
                let categoryList = CHVendorPostcodes()
                if let categoryID = value.valueForKey("id") as? String{
                    categoryList.id = categoryID
                }
                if let categoryName = value.valueForKey("postcode") as? String{
                    categoryList.postcode = categoryName
                }
                if let categoryName = value.valueForKey("code") as? String{
                    categoryList.code = categoryName
                }
        
                categoryLists.postcodesList.append(categoryList)
            }
        }
        return categoryLists
    }
    
    
    class func vendorListForSubscriptionMapper(result:[String:AnyObject])  -> [CHVendorSubsList] {
        
        var categoryLists = [CHVendorSubsList]()
        
        if let arr = result["city_head_list"] as? NSArray{
            for (_, value) in arr.enumerate(){
                let categoryList = CHVendorSubsList()
                if let categoryID = value.valueForKey("firstname") as? String{
                    categoryList.firstname = categoryID
                }
                if let categoryName = value.valueForKey("lastname") as? String{
                    categoryList.lastname = categoryName
                }
                if let categoryName = value.valueForKey("telephone") as? String{
                    categoryList.telephone = categoryName
                }
                if let categoryName = value.valueForKey("address") as? String{
                    categoryList.address = categoryName
                }
                if let categoryName = value.valueForKey("city") as? String{
                    categoryList.city = categoryName
                }
                if let categoryName = value.valueForKey("zone_name") as? String{
                    categoryList.zone_name = categoryName
                }
                if let categoryName = value.valueForKey("zone_id") as? String{
                    categoryList.zone_id = categoryName
                }
                if let categoryName = value.valueForKey("address") as? String{
                    categoryList.address = categoryName
                }
                if let categoryName = value.valueForKey("city") as? String{
                    categoryList.city = categoryName
                }
                if let categoryName = value.valueForKey("zone_name") as? String{
                    categoryList.zone_name = categoryName
                }
                if let categoryName = value.valueForKey("created_by") as? String{
                    categoryList.created_by = categoryName
                }
                if let categoryName = value.valueForKey("status") as? String{
                    categoryList.status = categoryName
                }
                if let categoryName = value.valueForKey("customer_count") as? String{
                    categoryList.customer_count = categoryName
                }
                if let categoryName = value.valueForKey("email") as? String{
                    categoryList.email = categoryName
                }
                if let categoryName = value.valueForKey("image") as? String{
                    categoryList.image = categoryName
                }
                if let categoryName = value.valueForKey("customer_id") as? String{
                    categoryList.customer_id = categoryName
                }
                categoryLists.append(categoryList)
            }
        }
        return categoryLists
    }

    class func getSubscriptionInfoMapper(result:[String:AnyObject])  -> SubsInfoDetails {
        
        let categoryLists = SubsInfoDetails()
        
        if let countryId = result["WorkingSubscription"] as? String {
            categoryLists.WorkingSubscription = countryId
        }
        
        if let countryId = result["activecustomer"] as? String {
            categoryLists.activecustomer = countryId
        }
        
        if let countryId = result["zone_assignid"] as? String {
            categoryLists.assign = countryId
        }
        
        if let countryId = result["checksellersubscriptiontype"] as? String {
            categoryLists.checksellersubscriptiontype = countryId
        }
        
        if let arr = result["period"] as? NSArray{
            for (_, value) in arr.enumerate(){
                let categoryList = CHSubsTime()
                if let categoryID = value.valueForKey("id") as? String{
                    categoryList.id = categoryID
                }
                if let categoryName = value.valueForKey("name") as? String{
                    categoryList.name = categoryName
                }
                
                categoryLists.period.append(categoryList)
            }
        }
        
        if let arr = result["pkg"] as? NSArray{
            for (_, value) in arr.enumerate(){
                let categoryList = CHSubsPackage()
                if let categoryID = value.valueForKey("commission_id") as? String{
                    categoryList.commission_id = categoryID
                }
                if let categoryName = value.valueForKey("free_paid") as? String{
                    categoryList.free_paid = categoryName
                }
                if let categoryName = value.valueForKey("name") as? String{
                    categoryList.name = categoryName
                }
                if let categoryName = value.valueForKey("status") as? String{
                    categoryList.status = categoryName
                }
                if let categoryName = value.valueForKey("description") as? String{
                    categoryList.desc = categoryName
                }
                categoryLists.pkg.append(categoryList)
            }
        }
        
        if let arr = result["sub_detail"] as? NSArray{
            for (_, value) in arr.enumerate(){
                let categoryList = CHSubsInfoDetail()
                if let categoryID = value.valueForKey("amount") as? String{
                    categoryList.amount = categoryID
                }
                if let categoryName = value.valueForKey("count") as? String{
                    categoryList.count = categoryName
                }
                if let categoryName = value.valueForKey("pStatus") as? String{
                    categoryList.pStatus = categoryName
                }
                if let categoryName = value.valueForKey("sub_pkg") as? String{
                    categoryList.sub_pkg = categoryName
                }
                categoryLists.sub_detail.append(categoryList)
            }
        }
        
        if let arr = result["sub_type"] as? NSArray{
            for (_, value) in arr.enumerate(){
                let categoryList = CHSubType()
                if let categoryID = value.valueForKey("description") as? String{
                    categoryList.desc = categoryID
                }
                if let categoryName = value.valueForKey("flat") as? String{
                    categoryList.flat = categoryName
                }
                if let categoryName = value.valueForKey("name") as? String{
                    categoryList.name = categoryName
                }
                if let categoryName = value.valueForKey("percent") as? String{
                    categoryList.percent = categoryName
                }
                if let categoryName = value.valueForKey("status") as? String{
                    categoryList.status = categoryName
                }
                categoryLists.sub_type.append(categoryList)
            }
        }
        
        return categoryLists
    }
    
}
