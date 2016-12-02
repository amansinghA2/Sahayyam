//
//  CityHeadJsonMapper.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Foundation

extension CommonJsonMapper {
    
    class func getSubsDetailsMapper(result:[String:AnyObject]) -> [SubsNameDetails]  {
        
        var customerLists = [SubsNameDetails]()
        
        if let customers = result["city_head_list"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = SubsNameDetails()
                
                if let name = value.valueForKey("firstname") as? String{
                    customerList.firstname = name
                }
                
                if let telephone = value.valueForKey("lastname") as? String{
                    customerList.lastname = telephone
                }
                
                if let email = value.valueForKey("customer_id") as? String{
                    customerList.customer_id = email
                }
                
                customerLists.append(customerList)
            }
            
        }
        return customerLists
    }
    
    class func vendorListForFreenMapper(result:[String:AnyObject]) -> FreeUnpaidVendorList  {
        
        let customerLists = FreeUnpaidVendorList()
        
        if let customers = result["free_vendors"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = FreeVendorList()
                
                if let name = value.valueForKey("bus_type") as? String{
                    customerList.bus_type = name
                }
                
                if let telephone = value.valueForKey("seller") as? String{
                    customerList.seller = telephone
                }
                
                if let telephone = value.valueForKey("seller_id") as? String{
                    customerList.seller_id = telephone
                }
                
                if let email = value.valueForKey("subscription_fees") as? String{
                    customerList.subscription_fees = email
                }
                
                if let telephone = value.valueForKey("telephone") as? String{
                    customerList.telephone = telephone
                }

                customerLists.freevendorList.append(customerList)
            }
            
        }
        
        return customerLists
    }
    
    
    class func vendorListForAddCustomer(result:[String:AnyObject])  -> [CHVendorSubsList] {
        
        var categoryLists = [CHVendorSubsList]()
        
        if let arr = result["cityheadVendor"] as? NSArray{
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
    
  
    
    
}
