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
    
    class func vendorListForFreenMapper(result:[String:AnyObject]) -> [FreeVendorList]  {
        
        var customerLists = [FreeVendorList]()
        
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

                customerLists.append(customerList)
            }
            
        }

        return customerLists
    }
    
    
    class func vendorListForUnpaidMapper(result:[String:AnyObject]) -> [UnpaidVendorList]  {
        
        var customerLists = [UnpaidVendorList]()
        
        if let customers = result["unpaid_vendors"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = UnpaidVendorList()
                
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
                
                customerLists.append(customerList)
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
    
    class func vendorCHServicesMapper(result:[String:AnyObject]) -> [VendorService]  {
        
        var customerLists = [VendorService]()
        
        if let customers = result["service"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = VendorService()
                
                if let subscription = value.valueForKey("id") as? String{
                    customerList.id = subscription
                }
                
                if let customer = value.valueForKey("bus_type") as? String{
                    customerList.bus_type = customer
                }
                
                if let Customercount = value.valueForKey("code") as? String{
                    customerList.code = Customercount
                }
                
                if let status = value.valueForKey("desc") as? String{
                    customerList.desc = status
                }
                
                customerLists.append(customerList)
            }
            
        }
        return customerLists
    }

    
    class func  vendorDashboardCountMapper(result:[String:AnyObject]) -> VendorDashboardCountList  {
        let serviceList = VendorDashboardCountList()
        
        if let businessHoliday = result["activeCustomer"] as? String {
            serviceList.activeCustomer = businessHoliday
        }
        
        if let businessHoliday = result["activeVendor"] as? String {
            serviceList.activeVendor = businessHoliday
        }
        
        if let businessHoliday = result["b2b_fs"] as? String {
            serviceList.b2b_fs = businessHoliday
        }
        
        if let businessHoliday = result["b2c_fs"] as? String {
            serviceList.b2c_fs = businessHoliday
        }
        
        if let businessHoliday = result["category_count"] as? String {
            serviceList.category_count = businessHoliday
        }
        
        if let businessHoliday = result["free_vendor"] as? String {
            serviceList.free_vendor = businessHoliday
        }
        
        if let businessHoliday = result["inactiveCustomer"] as? String {
            serviceList.inactiveCustomer = businessHoliday
        }
        
        if let businessHoliday = result["inactiveVendor"] as? String {
            serviceList.inactiveVendor = businessHoliday
        }
        
        if let businessHoliday = result["product_count"] as? String {
            serviceList.product_count = businessHoliday
        }
        
        if let businessHoliday = result["service_count"] as? String {
            serviceList.service_count = businessHoliday
        }
        
        if let businessHoliday = result["subcategory_count"] as? String {
            serviceList.subcategory_count = businessHoliday
        }
        
        if let businessHoliday = result["totalCustomer"] as? String {
            serviceList.totalCustomer = businessHoliday
        }
        
        if let businessHoliday = result["totalVendor"] as? String {
            serviceList.totalVendor = businessHoliday
        }
        
        if let businessHoliday = result["total_amonut_fees"] as? String {
            serviceList.total_amonut_fees = businessHoliday
        }
        
        if let businessHoliday = result["unpaid_vendor"] as? String {
            serviceList.unpaid_vendor = businessHoliday
        }
        
        return serviceList
    }
    
    class func vendorListForPaidUnpaid(result:[String:AnyObject]) -> [PaidUnpaidVendor]  {
        
        var customerLists = [PaidUnpaidVendor]()
        
        if let customers = result["Vendor Details"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = PaidUnpaidVendor()
                
                if let name = value.valueForKey("address") as? String{
                    customerList.address = name
                }
                
                if let telephone = value.valueForKey("bus_type") as? String{
                    customerList.bus_type = telephone
                }
                
                if let telephone = value.valueForKey("createBy") as? String{
                    customerList.createBy = telephone
                }
                
                if let email = value.valueForKey("customer") as? String{
                    customerList.customer = email
                }
                
                if let telephone = value.valueForKey("customer_id") as? String{
                    customerList.customer_id = telephone
                }
                
                if let telephone = value.valueForKey("email") as? String{
                    customerList.email = telephone
                }
                
                if let email = value.valueForKey("i") as? String{
                    customerList.i = email
                }
                
                if let telephone = value.valueForKey("image") as? String{
                    customerList.image = telephone
                }
                
                if let telephone = value.valueForKey("name") as? String{
                    customerList.name = telephone
                }
                
                if let email = value.valueForKey("status") as? String{
                    customerList.status = email
                }
                
                if let telephone = value.valueForKey("telephone") as? String{
                    customerList.telephone = telephone
                }
                
                customerLists.append(customerList)
            }
        }
        return customerLists

    }
    
    class func vendorListForB2BCDetailsMapper(result:[String:AnyObject]) -> [B2BCSubsDetails]  {
        
        var customerLists = [B2BCSubsDetails]()
        
        if let customers = result["Subscription Details"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = B2BCSubsDetails()
                
                if let name = value.valueForKey("amount") as? String{
                    customerList.amount = name
                }
                
                if let telephone = value.valueForKey("bus_type") as? String{
                    customerList.bus_type = telephone
                }
                
                if let telephone = value.valueForKey("email_id") as? String{
                    customerList.email_id = telephone
                }
                
                if let email = value.valueForKey("expiry_date") as? String{
                    customerList.expiry_date = email
                }
                
                if let telephone = value.valueForKey("i") as? String{
                    customerList.i = telephone
                }
                
                if let telephone = value.valueForKey("registration_date") as? String{
                    customerList.registration_date = telephone
                }
                
                if let email = value.valueForKey("sub_type") as? String{
                    customerList.sub_type = email
                }
                
                if let telephone = value.valueForKey("telephone") as? String{
                    customerList.telephone = telephone
                }
                
                if let telephone = value.valueForKey("vendor_name") as? String{
                    customerList.vendor_name = telephone
                }
                
                if let email = value.valueForKey("vendor_shop_name") as? String{
                    customerList.vendor_shop_name = email
                }
                
                customerLists.append(customerList)
            }
        }
        return customerLists
        
    }
    
    
    class func vendorRegDetailsListMapper(result:[String:AnyObject]) -> [VendorRegDetails]  {
        
        var customerLists = [VendorRegDetails]()
        
        if let customers = result["Vendor Registration Deatils"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = VendorRegDetails()
                
                if let name = value.valueForKey("amount") as? String{
                    customerList.amount = name
                }
                
                if let telephone = value.valueForKey("email_id") as? String{
                    customerList.email_id = telephone
                }
                
                if let telephone = value.valueForKey("registration_date") as? String{
                    customerList.registration_date = telephone
                }
 
                if let telephone = value.valueForKey("telephone") as? String{
                    customerList.telephone = telephone
                }
                
                if let telephone = value.valueForKey("vendor_name") as? String{
                    customerList.vendor_name = telephone
                }
                
                if let email = value.valueForKey("vendor_shop_name") as? String{
                    customerList.vendor_shop_name = email
                }
                
                customerLists.append(customerList)
            }
        }
        return customerLists
        
    }



    
    
}
