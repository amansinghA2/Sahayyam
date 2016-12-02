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
                
                if let address_1 = value.valueForKey("idCardType") as? String{
                    customerList.idCardType = address_1
                }
                
                if let address_1 = value.valueForKey("idProofImage") as? String{
                    customerList.idProofImage = address_1
                }
                
                if let arr = result["idCardTypes"] as? NSArray {
                    for (_,value) in arr.enumerate() {
                        
                        let totalDetail = CustomerIDProof()

                        if let str = value.valueForKey("code") {
                            totalDetail.code = str as! String
                        }
                        
                        if let str = value.valueForKey("id") {
                            totalDetail.id = str as! String
                        }
                        
                        if let str = value.valueForKey("id_proof_type") {
                            totalDetail.id_proof_type = str as! String
                        }
                        
                        customerList.idCardTypes.append(totalDetail)
                    }
                }

                
//                if let address_1 = value.valueForKey("idCardType") as? String{
//                    customerList.idCardType = address_1
//                }
//                
//                if let address_1 = value.valueForKey("idCardTypes") as? String{
//                    customerList.idCardTypes = address_1
//                }
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
                
                if let date = value.valueForKey("payStatus") as? String{
                    customerList.payStatus = date
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
                
                if let status = value.valueForKey("product_id") as? String{
                    customerList.product_id = status
                }
                
                if let status = value.valueForKey("status") as? String{
                    customerList.status = status
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


                if let text:AnyObject = value.valueForKey("del_hour"){
                    if text is String {
                        customerList.del_hour = text as! String
                    }else{
                        customerList.del_hour = String(text)
                    }
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
                
                if let customer = value.valueForKey("to") as? String{
                    customerList.to = customer
                }
                
                if let subscription = value.valueForKey("end_minute") as? String{
                    customerList.end_minute = subscription
                }
                
                if let subscription = value.valueForKey("end_hour") as? String{
                    customerList.end_hour = subscription
                }else{
                   customerList.end_hour = "12"
                }
                
                serviceList.endTime.append(customerList)
            }
        }
        
        if let businessHoliday = result["startTime"] as? String {
            serviceList.startingTime = "0"
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
        print(serviceList)
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
    
    
    class func  unitGramMapper(result:[String:AnyObject]) -> [UnitGram] {
        var unitGrams = [UnitGram]()
        
        if let arr = result["weight_classes"] as? NSArray {
            for (_, value) in arr.enumerate() {
                let unitGram = UnitGram()
                if let languageId = value.valueForKey("language_id") as? String{
                 unitGram.language_id = languageId
                }
                
                if let languageId = value.valueForKey("title") as? String{
                    unitGram.title = languageId
                }
                
                if let languageId = value.valueForKey("unit") as? String{
                   unitGram.unit = languageId
                }
                
                if let languageId = value.valueForKey("value") as? String{
                   unitGram.value = languageId
                }
                
                if let languageId = value.valueForKey("weight_class_id") as? String{
                  unitGram.weight_class_id = languageId
                }
                unitGrams.append(unitGram)
            }
        }
        return unitGrams
    }
    
    
    class func  productDetailsDetailsMapper(result:[String:AnyObject]) -> VendorProductInDetails {
        
        
        let customerList = VendorProductInDetails()
        
            if let banner = result["name"] as? String{
                customerList.productName = banner
            }
            
            if let addr = result["price"] as? String{
                customerList.price = addr
            }
            
            if let addr = result["product_id"] as? String{
                customerList.product_id = addr
            }
            
            if let addr = result["description"] as? String{
                customerList.mDescription = addr
            }
            
            if let addr = result["quantity"] as? String{
                customerList.mQuantity = addr
            }
            
            if let banner = result["manufacturer"] as? String{
                customerList.productName = banner
            }
            
            if let addr = result["image"] as? String{
                customerList.mImgDir = addr
            }
        
            if let addr = result["images"] as? String{
            customerList.mImgDirs = addr
            }
        
            if let addr = result["offerPrice"] as? String{
                customerList.mOfferPrice = addr
            }
            
            if let addr = result["manufacturer_id"] as? Int{
                customerList.mManufacturarId = addr
            }
            
            if let addr = result["weight_class_id"] as? String{
                customerList.mWeightId = addr
            }
            
            if let addr = result["subtract"] as? String{
                customerList.mSubstract = addr
            }
            
            if let addr = result["status"] as? String{
                customerList.mStatus = addr
            }
            
            if let banner = result["service_id"] as? String{
                customerList.mService = banner
            }
            
            if let addr = result["productCategories"] as? String{
                customerList.mCategoryId = addr
            }
            
            if let addr = result["weight"] as? String{
                customerList.mUnits = addr
            }
            
            if let addr = result["productCategories"] as? String{
                customerList.mCatId = addr
            }
            
            if let addr = result["categoryName"] as? String{
                customerList.mCatName = addr
            }
            
            if let addr = result["ref_code"] as? Int{
                customerList.mRefCode = addr
            }
  
        return customerList
    }

//vendorProductGetServiceMapper
    
    class func  vendorProductGetServiceMapper(result:[String:AnyObject]) -> VendorServiceList {
        
        let unitGrams = VendorServiceList()
        if let arr = result["getLeftService"] as? NSArray {
            for (_, value) in arr.enumerate() {
                let unitGram = LeftService()
                if let languageId = value.valueForKey("bus_type") as? String{
                    unitGram.bus_type = languageId
                }
                
                if let languageId = value.valueForKey("code") as? String{
                    unitGram.code = languageId
                }
                
                if let languageId = value.valueForKey("desc") as? String{
                    unitGram.desc = languageId
                }
                
                if let languageId = value.valueForKey("id") as? String{
                    unitGram.id = languageId
                }
                unitGrams.getLeftService.append(unitGram)
            }
            
        }
        
        if let arr = result["serviceDesc"] as? NSArray {
            for (_, value) in arr.enumerate() {
                let unitGram = ServiceDesc()
                if let languageId = value.valueForKey("desc") as? String{
                    unitGram.desc = languageId
                }
                
                if let languageId = value.valueForKey("id") as? String{
                    unitGram.id = languageId
                }
                
                if let languageId = value.valueForKey("total") as? String{
                    unitGram.total = languageId
                }
                
                unitGrams.serviceDesc.append(unitGram)
            }
        }

        return unitGrams
    }
    
    
  
    class func  vendorApprovePendingMapper(result:[String:AnyObject]) -> [ApprovePendingStatus]  {
        
        var customerList = [ApprovePendingStatus]()
        
        if let arr = result["Product Details"] as? NSArray {
            for (_, value) in arr.enumerate() {
                let unitGram = ApprovePendingStatus()
                if let languageId = value.valueForKey("category_name") as? String{
                    unitGram.category_name = languageId
                }
                
                if let languageId = value.valueForKey("date") as? String{
                    unitGram.date = languageId
                }
                
                if let languageId = value.valueForKey("description") as? String{
                    unitGram.desc = languageId
                }
                
                if let languageId = value.valueForKey("i") as? String{
                    unitGram.i = languageId
                }
                
                if let languageId = value.valueForKey("img") as? String{
                    unitGram.img = languageId
                }
                
                if let languageId = value.valueForKey("manufacturer") as? String{
                    unitGram.manufacturer = languageId
                }
                
                if let languageId = value.valueForKey("offerPrice") as? String{
                    unitGram.offerPrice = languageId
                }
                
                if let languageId = value.valueForKey("price") as? String{
                    unitGram.price = languageId
                }
                
                if let languageId = value.valueForKey("product_id") as? String{
                    unitGram.product_id = languageId
                }
                
                if let languageId = value.valueForKey("product_name") as? String{
                    unitGram.product_name = languageId
                }
                
                if let languageId = value.valueForKey("quantity") as? String{
                    unitGram.quantity = languageId
                }
                
                if let languageId = value.valueForKey("ref_code") as? String{
                    unitGram.ref_code = languageId
                }
                
                if let languageId = value.valueForKey("service_desc") as? String{
                    unitGram.service_desc = languageId
                }
                
                if let languageId = value.valueForKey("subtract") as? String{
                    unitGram.subtract = languageId
                }
                
                if let languageId = value.valueForKey("unit") as? String{
                    unitGram.unit = languageId
                }
                
                if let languageId = value.valueForKey("unit_value") as? String{
                    unitGram.unit_value = languageId
                }
                
                customerList.append(unitGram)
            }
        }
        return customerList
    }
    
    class func  vendorProductCountMapper(result:[String:AnyObject]) -> ProductApprovalStatus  {
        
        let customerList = ProductApprovalStatus()
        
        if let customers = result["product Approval Status"]{
                
            if let addr = customers["Product_Approved"] as? String{
                customerList.Product_Approved = addr
            }
            
            if let addr = customers["Product_Approved_count"] as? Int{
                customerList.Product_Approved_count = addr
            }
            
            if let addr = customers["Product_Pending"] as? String{
                customerList.Product_Pending = addr
            }
            
            if let addr = customers["Product_Pending_count"] as? Int{
                customerList.Product_Pending_count = addr
            }
            
            if let addr = customers["Product_Rejected"] as? String{
                customerList.Product_Rejected = addr
            }
            
            if let addr = customers["Product_Rejected_count"] as? Int{
                customerList.Product_Rejected_count = addr
            }
        }
        return customerList
    }
    
    
    
}



