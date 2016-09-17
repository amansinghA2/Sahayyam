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
               customerLists.append(customerList)
            }
            
        }
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

  
}
