//
//  VendorJSONMapper.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorJSONMapper: NSObject {
    
    
    class func getCustomerListMapper(result:[String:AnyObject]) -> [CustomerList]  {
        
        var customerLists = [CustomerList]()
        
        if let customers = result["customers"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = CustomerList()
                
                if let name = value.valueForKey("name") as? String{
                    customerList.name = name
                }
                
                if let telephone = value.valueForKey("telephone") as? String{
                    customerList.mobileNumber = telephone
                }
                if let email = value.valueForKey("email") as? String{
                    customerList.emailId = email
                }
                
                if let reg_date = value.valueForKey("reg_date") as? String{
                    customerList.registerDate = reg_date
                }
                
                if let address_1 = value.valueForKey("address_1") as? String{
                    customerList.address = address_1
                }
                
                if let address_1 = value.valueForKey("grant") as? String{
                    customerList.grant = address_1
                }
                
                if let address_1 = value.valueForKey("customer_id") as? String{
                    customerList.customerId = address_1
                }
                customerLists.append(customerList)
            }
            
        }
        print(customerLists)
        return customerLists
    }
    
    class func getTransactionsHistoryMapper(result:[String:AnyObject]) -> [VendorPayment]  {
        
        var customerLists = [VendorPayment]()
        
        if let customers = result["success"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = VendorPayment()
                
                if let subscription = value.valueForKey("date") as? String{
                    customerList.date = subscription
                }
                if let customer = value.valueForKey("order_id") as? String{
                    customerList.orderID = customer
                }
                if let Customercount = value.valueForKey("amount") as? String{
                    customerList.amount = Customercount
                }
                if let status = value.valueForKey("transactionId") as? String{
                    customerList.transactionID = status
                }
                if let credit = value.valueForKey("paymentMethod")as? String{
                    customerList.paymentMethod = credit
                }
                
                if let date = value.valueForKey("status") as? String{
                    customerList.status = date
                }
                
                if let date = value.valueForKey("invoiceType") as? String{
                    customerList.invoiceType = date
                }
                
                customerLists.append(customerList)
            }
            
        }
        return customerLists
    }
    
    
    
    class func getSubscriptionDetailsMapper(result:[String:AnyObject]) -> [SubscriptionList]  {
        
        var customerLists = [SubscriptionList]()
        
        if let customers = result["sub"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = SubscriptionList()
                
                if let subscription = value.valueForKey("Subscription Package Name") as? String{
                    customerList.subscriptionName = subscription
                }
                if let customer = value.valueForKey("Price/Month/Customer") as? String{
                    customerList.priceMonthCustomer = customer
                }
                if let Customercount = value.valueForKey("Customer count") as? String{
                    customerList.customerCount = Customercount
                }
                if let status = value.valueForKey("status") as? String{
                    customerList.status = status
                }
                if let credit = value.valueForKey("Balance Credit"){
                    customerList.balanceCredit = credit as! Int
                }
                
                if let date = value.valueForKey("Current date") as? String{
                    customerList.startDate = date
                }
                
                if let expiresOn = value.valueForKey("Expires on") as? String{
                    customerList.expiresOn = expiresOn
                }
                
                if let daysRem = value.valueForKey("daysRem") {
                    customerList.remainingDays = daysRem as! Int
                }
                
                customerLists.append(customerList)
            }
            
        }
        return customerLists
    }
    
    
    
    class func vendorServicesMapper(result:[String:AnyObject]) -> [VendorService]  {
        
        var customerLists = [VendorService]()
        
        if let customers = result["vendor_service"] as? NSArray{
            
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
    
    
    class func  getPromotionList(result:[String:AnyObject]) -> [VendorPromotionList]  {
        
        var customerLists = [VendorPromotionList]()
        
        if let customers = result["dispalyProduct"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = VendorPromotionList()
                
                if let subscription = value.valueForKey("name") as? String{
                    customerList.name = subscription
                }
                
                if let customer = value.valueForKey("start_date_added") as? String{
                    customerList.start_date_added = customer
                }
                
                if let Customercount = value.valueForKey("end_date_added") as? String{
                    customerList.end_date_added = Customercount
                }
                
                if let status = value.valueForKey("description") as? String{
                    customerList.promotionDescription = status
                }
                
                if let status = value.valueForKey("promo_name") as? String{
                    customerList.promo_name = status
                }
                
                if let status = value.valueForKey("price") as? String{
                    customerList.price = status
                }
                
                if let status = value.valueForKey("discountPrice") as? String{
                    customerList.discount = status
                }
                
                if let status = value.valueForKey("quantity") as? String{
                    customerList.quantity = status
                }
                
                customerLists.append(customerList)
            }
            
        }
        return customerLists
    }
    
    
    
    class func  sellerPopulateDataMapper(result:[String:AnyObject]) -> SellerData  {
        
        let customerList = SellerData()
        
        if let customers = result["vendorData"]{
            if let address = customers["address"]{
                
                if let addr = address!["address_1"] as? String{
                    customerList.address_1 = addr
                }
                
                if let addr = address!["address_2"] as? String{
                    customerList.address_2 = addr
                }
                
                if let addr = address!["city"] as? String{
                    customerList.city = addr
                }
                if let addr = address!["country"] as? String{
                    customerList.country = addr
                }
                
                if let addr = address!["postcode"] as? String{
                    customerList.postcode = addr
                }
                
            }
            
            if let banner = customers["banner"] as? String{
                customerList.bannerImageString = banner
            }
            
            if let addr = customers["ms.avatar"] as? String{
                customerList.avatar = addr
            }
            
            if let addr = customers["name"] as? String{
                customerList.name = addr
            }
            
            if let addr = customers["ms.description"] as? String{
                customerList.descriptionDetails = addr
            }
            
            if let addr = customers["ms.company"] as? String{
                customerList.companyName = addr
            }
            
        }
        return customerList
    }
    
    
    
    class func  getServiceList(result:[String:AnyObject]) -> [ServiceList]  {
        var serviceLists = [ServiceList]()
      
        
        if let customers = result["service"] as? NSArray{
            for (_,value) in customers.enumerate(){
                let customerList = ServiceList()
                
                if let subscription = value.valueForKey("id") as? String{
                    customerList.id = subscription
                }
                
                if let customer = value.valueForKey("name") as? String{
                    customerList.name = customer
                }
                serviceLists.append(customerList)
            }
        }
        return serviceLists
    }
    
    class func  vendorStoreProfileMapper(result:[String:AnyObject]) -> StoreProfileData  {
        let serviceList = StoreProfileData()
        
        if let businessHoliday = result["bussinessHoliday"] as? String {
            serviceList.businessHoliday = businessHoliday
        }
        
        if let businessHoliday = result["deliveryCharges"] as? String {
            serviceList.deliveryCharges = businessHoliday
        }
        
        if let businessHoliday = result["expressDelivery"] as? String {
            serviceList.expressDelivery = businessHoliday
        }
        
        if let businessHoliday = result["minimum_order"] as? String {
            serviceList.minimum_order = businessHoliday
        }
        
        if let customers = result["deliveryTime"] as? NSArray{
            for (_,value) in customers.enumerate(){
                let customerList = DeliveryTime()
                
                if let subscription = value.valueForKey("del") as? String{
                    customerList.del = subscription
                }
                
                if let subscription = value.valueForKey("del_hour") as? String{
                    customerList.del_hour = subscription
                }
                
                if let customer = value.valueForKey("del_min") as? String{
                    customerList.del_min = customer
                }
                serviceList.deliveryTime.append(customerList)
            }
        }
        
        if let customers = result["endTime"] as? NSArray{
            for (_,value) in customers.enumerate(){
                let customerList = EndTime()
                
                if let subscription = value.valueForKey("end_hour") as? String{
                    customerList.end_hour = subscription
                }
                
                if let subscription = value.valueForKey("end_minute") as? String{
                    customerList.end_minute = subscription
                }
                
                if let customer = value.valueForKey("to") as? String{
                    customerList.to = customer
                }
                serviceList.endTime.append(customerList)
            }
        }
        
        
        if let customers = result["startTime"] as? NSArray{
            for (_,value) in customers.enumerate(){
                let customerList = StartTime()
                
                if let subscription = value.valueForKey("from") as? String{
                    customerList.from = subscription
                }
                
                if let subscription = value.valueForKey("from_hour") as? String{
                    customerList.from_hour = subscription
                }
                
                if let customer = value.valueForKey("from_minute") as? String{
                    customerList.from_minute = customer
                }
                
                serviceList.startTime.append(customerList)
            }
        }
        
        return serviceList
    }

    class func  categoryDropDownListMapper(result:[AnyObject]) -> [ProductCategoryList] {
        var serviceLists = [ProductCategoryList]()

        for dict in result {
            let serviceList = ProductCategoryList()
            if let active = dict.valueForKey("active") as? String{
                serviceList.active = active
            }

            if let active = dict.valueForKey("category_id") as? String{
                serviceList.category_id = active
            }

            if let active = dict.valueForKey("name") as? String{
                serviceList.name = active
            }

            serviceLists.append(serviceList)

        }
        
        return serviceLists
    }
    
}
    
    

