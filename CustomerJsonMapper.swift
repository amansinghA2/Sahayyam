//
//  CustomerJsonMapper.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 04/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

extension CommonJsonMapper {
    
    
    // MARK: - CART LIst
    
    class func getCartListMapper(result:[String:AnyObject]) -> [Products] {
        
        var orderLists = [Products]()
        var productList:Products!
        
        
        
        if let dic = result["products"] as? NSArray {
            
            for (_,value) in dic.enumerate() {
                productList = Products()
                
                
                //                        if let str = result["urgent_delivery_cost"]  {
                //                            productList.urgent_delivery = str as! String
                //                        }
                
                if let str = result["is_express"]  {
                    productList.is_express = str as! Bool
                }
                
                if let str = result["total_deliv_charge"]  {
                    productList.totalOrder = str as! String
                }
                
                
                if let key = value.valueForKey("key") {
                    productList.key = key as! String
                }
                if let product_id = value.valueForKey("product_id") {
                    productList.product_id = product_id as! Int
                }
                if let name = value.valueForKey("name") {
                    productList.name = name as! String
                }
                if let model = value.valueForKey("model") {
                    productList.model = model as! String
                }
                if let image = value.valueForKey("image")  {
                    productList.image =  String(image)
                }
                if let stock = value.valueForKey("stock") {
                    productList.stock = stock as! Bool
                }
                if let shipping = value.valueForKey("shipping") {
                    productList.shipping = shipping as! Bool
                }
                if let price = value.valueForKey("price") {
                    productList.price = price as! String
                }
                if let total = value.valueForKey("total") {
                    productList.total = total as! String
                }
                if let reward = value.valueForKey("reward") {
                    productList.reward = reward as! Int
                }
                if let str = value.valueForKey("quantity") as? Int {
                    productList.cartQuantity = str
                }
                
                if let dic = result["deliveryCharges"]  {
                    
                    if let str = dic["urgent_delivery"] {
                        productList.urgent_delivery = str as! String
                        
                    }
                    
                }
                
                if let arr = result["venDelivTiming"] as? NSArray {
                    for (_,value) in arr.enumerate() {
                        
                        let detail = CheckoutDeliveryTime()
                        
                        if let str = value.valueForKey("del"){
                            detail.del = str as! String
                        }
                        
                        let text:AnyObject = value.valueForKey("del_hour")!
                        if text is String {
                            detail.del_hour = text as! String
                        }else{
                            detail.del_hour = String(text)
                        }
                        
                        if let str = value.valueForKey("del_min"){
                            detail.del_min = str as! String
                        }
                        
                        productList.checkoutDeliveryTime.append(detail)
                        
                    }
                    
                    
                }
                
                
                if let arr = result["totals"] as? NSArray {
                    for (_,value) in arr.enumerate() {
                        let totalDetail = CheckoutOrderTotals()
                        
                        if let str = value.valueForKey("title") {
                            totalDetail.title = str as! String
                        }
                        
                        let text:AnyObject = value.valueForKey("text")!
                        if text is String {
                            totalDetail.text = text as! String
                        }else{
                            totalDetail.text = String(text)
                        }
                        
                        
                        if let str = value.valueForKey("appliedPrice") {
                            totalDetail.appliedPrice = str as! String
                        }
                        
                        productList.customerCartDetails.append(totalDetail)
                        
                    }
                }
                
                orderLists.append(productList)
            }
        }
        
        return orderLists
    }
    
    // MARK: -  ProductCollection lISt
    
    class func productCollectionList(result:[String:AnyObject]) -> [ProductCollectionList]{
        var productLists = [ProductCollectionList]()
        
        if let dic = result["products"] as? NSArray{
            for (_,value) in dic.enumerate() {
                let productList1 = ProductCollectionList()
                
                if let prodcuTid = value.valueForKey("product_id") {
                    productList1.product_id = prodcuTid as! Int
                }
                
                if let offerPrice = value.valueForKey("offerPrice") {
                    productList1.offerPrice = offerPrice as! String
                }
                
                let imageString = value.valueForKey("image") as! String
                productList1.image1  =  imageString
                productList1.price = value.valueForKey("price") as! String
                productList1.id = value.valueForKey("product_id") as! Int
                productList1.width = value.valueForKey("width") as! String
                productList1.height = value.valueForKey("height") as! String
                if let str = value.valueForKey("quantity") as? Int {
                    productList1.quantity1 = str
                }
                if let dic1 = value.valueForKey("product_description") as? NSArray {
                    for (_,value) in dic1.enumerate() {
                        productList1.prodnName = value.valueForKey("name")as! String
                        productList1.prodDesc = value.valueForKey("description") as! String
                    }
                }
                
                productLists.append(productList1)
                print(productList1)
            }
        }
        return productLists
    }
    
    class func getproductDetails(result:[String:AnyObject]) -> ProductDetails {
        let productDetail = ProductDetails()
        if let description = result["description"] as? String {
            productDetail.productDescription = description
        }
        
        if let name = result["name"] as? String {
            productDetail.name = name
        }
        
        if let image = result["images"] as? String {
            productDetail.detailsImage = image
        }else{
            productDetail.detailsImage = "v_no_image"
        }
        
        if let price = result["price"] as? String {
            productDetail.price = price
        }
        if let quantity = result["quantity"] as? String {
            productDetail.stock = quantity
        }
        
        //        if let quantity = result["quantity"] as? String {
        //            productDetail.stock = quantity
        //        }
        
        print("\(productDetail)")
        return productDetail
        
    }
    
    // MARK: - Wishlist MApper
    
    class func getWishlistListMapper(result:[String:AnyObject]) -> [WishlistProductList]{
        var wishListArray = [WishlistProductList]()
        if let arr = result["products"] as? NSArray{
            
            for (_,value) in arr.enumerate(){
                let data = WishlistProductList()
                
                
                if let thumb =  value.valueForKey("product_id") as? Int {
                    data.product_id  = thumb
                }
                
                if let thumb =  value.valueForKey("thumb") as? String {
                    data.thumb  = thumb
                }
                
                if let thumb =  value.valueForKey("name") as? String {
                    data.name  = thumb
                }
                
                if let thumb =  value.valueForKey("model") as? String {
                    data.model  = thumb
                }
                
                if let thumb =  value.valueForKey("stock") as? String {
                    data.stock1  = thumb
                }
                
                if let thumb =  value.valueForKey("price") as? String {
                    data.price  = thumb
                }
                
                if let thumb =  value.valueForKey("href") as? String {
                    data.href  = thumb
                }
                
                if let thumb =  value.valueForKey("remove") as? String {
                    data.remove  = thumb
                }
                
                wishListArray.append(data)
            }
        }
        return wishListArray
    }
    
    
    // MARK: - Track Orders LIst
    class func customerProductsOrdersMapper(result:[String:AnyObject]) -> [CustomerOrders]{
        var orderLists = [CustomerOrders]()
        
        if let arr = result["orders"] as? NSArray{
            for (_,value) in arr.enumerate(){
                let data = CustomerOrders()
                data.date_added = value.valueForKey("date_added") as! String
                data.name = value.valueForKey("name") as! String
                data.order_id = value.valueForKey("order_id") as! String
                data.products = value.valueForKey("products") as! Int
                data.sales_order = value.valueForKey("sales_order") as! String
                data.status = value.valueForKey("status") as! String
                data.total = value.valueForKey("total") as! String
                data.href = value.valueForKey("href") as! String
                
                orderLists.append(data)
                print("\(orderLists)")
            }
        }
        return orderLists
    }
    
    class func getVendorList(result:[String:AnyObject]) -> [VendorList]{
        
        var vendorLists = [VendorList]()
        
        if let arr = result["vendor"] as? NSArray{
            
            for (_, value) in arr.enumerate(){
                let vendorlist = VendorList()
                
                if let vendorId = value.valueForKey("id"){
                    vendorlist.vendorId = vendorId as! String
                }
                
                if let vendorId = value.valueForKey("nickname"){
                    vendorlist.nickname = vendorId as! String
                }
                
                if let tel = value.valueForKey("tel") {
                    vendorlist.tel = tel as! String
                }
                
                if let address_1 = value.valueForKey("address_1"){
                    vendorlist.address_1 = address_1 as! String
                }
                
                //                if let vendorId = value.valueForKey("id"){
                //                    vendorlist.address_1 = value.valueForKey("address_1") as! String
                //                }
                
                if let avatar =  value.valueForKey("avatar"){
                    let imageString = avatar as! String
                    vendorlist.image = imageString
                }
                
                if let arr = value.valueForKey("from_date") as? NSArray{
                    for (_, value) in arr.enumerate(){
                        
                        let fromHour = value.valueForKey("from_hour")
                        let from_minute = value.valueForKey("from_minute")
                        let from = value.valueForKey("from")
                        
                        vendorlist.from_date = (String(fromHour) + ":" + String(from_minute) + String(from))
                    }
                }
                
                if let arr = value.valueForKey("to_date") as? NSArray{
                    for (_, value) in arr.enumerate(){
                        let fromHour = value.valueForKey("end_hour")
                        let from_minute = value.valueForKey("end_minute")
                        let from = value.valueForKey("to")
                        
                        vendorlist.to_date = (String(fromHour) + ":" + String(from_minute) + String(from))
                    }
                    
                }
                
                vendorlist.fromToDate = vendorlist.from_date + " To " + vendorlist.to_date ?? "Timing Not Mentioned"
                
                vendorLists.append(vendorlist)
                
            }
            
        }
        return vendorLists
    }
    
    
    class func customerProductsDetailsMapper(result:[String:AnyObject]) -> CustomerOrderDetails {
        
        //var productDetails = CustomerOrderDetails()
        //        var productLists = [OrderProductList]()
        
        let productDetail = CustomerOrderDetails()
        //        var totalDetails = [CheckoutOrderTotals]()
        
        if let orderID = result["order_id"] {
            productDetail.order_id = orderID as! String
        }
        
        if let sales_order = result["sales_order"] {
            productDetail.sales_order = sales_order as! String
        }
        
        if let date_added = result["date_added"] {
            productDetail.date_added = date_added as! String
        }
        if let payment_address = result["payment_address"] {
            let str = payment_address as! String
            productDetail.payment_address = CustomClass.htmlTrimmed(str)
        }
        
        if let payment_method = result["payment_method"] {
            productDetail.payment_method = payment_method as! String
        }
        
        if let arr = result["products"] as? NSArray {
            for (_,value) in arr.enumerate(){
                let productList = OrderProductList()
                productList.name = value.valueForKey("name") as! String
                productList.quantity = value.valueForKey("quantity") as! String
                productList.price = value.valueForKey("price") as! String
                productList.total = value.valueForKey("total") as! String
                //              productLists.append(productList)
                productDetail.orderProducts.append(productList)
            }
            
        }
        
        //        productDetail.orderProducts = productLists
        
        if let urgentChargesTotal = result["urgentChargesTotal"] as? NSArray {
            for (_,value) in urgentChargesTotal.enumerate(){
                let totalDetail = CheckoutOrderTotals()
                if let totalDetailTitle = value.valueForKey("title") {
                    totalDetail.title = totalDetailTitle as! String
                }
                
                if let totalDetailTitle = value.valueForKey("text") {
                    totalDetail.text = totalDetailTitle as! String
                }
                productDetail.extraOrderCosts.append(totalDetail)
            }
        }
        
        if let urgentChargesTotal = result["urgentChargesCost"] as? NSArray {
            for (_,value) in urgentChargesTotal.enumerate(){
                let totalDetail = CheckoutOrderTotals()
                if let totalDetailTitle = value.valueForKey("title") {
                    totalDetail.title = totalDetailTitle as! String
                }
                
                if let totalDetailTitle = value.valueForKey("text") {
                    totalDetail.text = totalDetailTitle as! String
                }
                productDetail.extraDeliveryTotals.append(totalDetail)
            }
        }
        
        if let arr = result["totals"] as? NSArray {
            for (_,value) in arr.enumerate() {
                let totalDetail = CheckoutOrderTotals()
                
                if let str = value.valueForKey("title") {
                    totalDetail.title = str as! String
                }
                
                let text:AnyObject = value.valueForKey("text")!
                if text is String {
                    totalDetail.text = text as! String
                }else{
                    totalDetail.text = String(text)
                }
                
                
                if let str = value.valueForKey("appliedPrice") {
                    totalDetail.appliedPrice = str as! String
                }
            
                  productDetail.orderTotals.append(totalDetail)
                
            }
        }
        
        print(productDetail)
        return productDetail
    }
    
    
    class func customerPopulateDataMapper(result:[String:AnyObject]) -> PopulateData {
        
        let populateData = PopulateData()
        
        if let dic = result["customer"] {
            
            if let firstname = dic["firstname"] {
                populateData.firstname = firstname as! String
            }
            
            if let dateOfBirth = dic["dob"] {
                populateData.dateOfBirth = dateOfBirth as! String
            }
            
            if let lastName = dic["lastname"] {
                populateData.lastName = lastName as! String
            }
            
            if let address = dic["address"] {
                populateData.address = address as! String
            }
            
            if let address_1 = dic["address_1"] {
                populateData.address1 = address_1 as! String
            }
            
            if let address_2 = dic["address_2"] {
                populateData.address2 = address_2 as! String
            }
            
            if let city = dic["city"] {
                populateData.cityName = city as! String
            }
            
            if let email = dic["email"] {
                populateData.emailId = email as! String
            }
            
            if let postcode = dic["postcode"] {
                populateData.pincode = postcode as! String
            }
            
            //          if let postcode = dic["postcode"] {
            //                populateData.pincode = postcode as! String
            //           }
            
            if let country = dic["country"] as? String {
                populateData.country = country
            }
            
            if let telephone = dic["telephone"] as? String{
                populateData.mobileNumber = telephone
            }
            
            //          if let zone_id = dic["zone_id"] {
            //                populateData.zone_id = zone_id as! String
            //          }
            
            if let image = dic["image"] as? String {
                populateData.image1 = image
            }
            
            if let zone_name = dic["zone_id"] as? String {
                populateData.stateName = zone_name
            }
            
        }
        return populateData
    }
    
    
    
    class func getVendorcategoryList(result:[String:AnyObject]) -> [CategoryList] {
        
        var categoryLists = [CategoryList]()
        
        
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
                
                //                if let categoryID = value.valueForKey("category_id"){
                //                    categoryList.category_id = categoryID as! String
                //                }
                //                if let categoryID = value.valueForKey("category_id"){
                //                    categoryList.category_id = categoryID as! String
                //                }
                //                if let categoryID = value.valueForKey("category_id"){
                //                    categoryList.category_id = categoryID as! String
                //                }
                categoryLists.append(categoryList)
            }
            
        }
        
        print(categoryLists)
        return categoryLists
        
        //        if let firstname = dic["firstname"] {
        //            populateData.firstname = firstname as! String
        //        }
        
    }
    
    
    
}