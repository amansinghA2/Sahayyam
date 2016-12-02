//
//  CustomerJsonMapper.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 04/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import SwiftyJSON

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
                
//                if let prodcuTid = value.valueForKey("product_id") {
//                    productList1.product_id = prodcuTid as! Int
//                }
                
                let text:AnyObject = value.valueForKey("product_id")!
                if text is String {
                    productList1.product_id = text as! String
                }else{
                    productList1.product_id = String(text)
                }
                
                if let offerPrice = value.valueForKey("offerPrice") {
                    productList1.offerPrice = offerPrice as! String
                }
                
                if  let imageString = value.valueForKey("image") as? String {
                   productList1.image1  = imageString
                }
                
                if let width = value.valueForKey("price") as? String {
                    productList1.price = width
                }
                
                if let width = value.valueForKey("product_id") as? Int {
                    productList1.id = width
                }
                
                if let width = value.valueForKey("width") as? String {
                    productList1.width = width
                }
                
                if let width = value.valueForKey("height") as? String {
                    productList1.height = width
                }
                
                if let str = value.valueForKey("quantity") as? Int {
                    productList1.quantity1 = str
                }
                if let dic1 = value.valueForKey("product_description") as? NSArray {
                    for (_,value) in dic1.enumerate() {
                        productList1.prodnName = value.valueForKey("name")as! String
                        productList1.prodDesc = value.valueForKey("description") as! String
                    }
                }
                
                if let name1 = value.valueForKey("model") as? String {
                    productList1.name = name1
                }
                
                
                if let text:AnyObject = value.valueForKey("name") {
                    if text is String {
                        productList1.vendorName = text as! String
                    }else{
                       productList1.vendorName = String(text)
                    }
                }
                
//                if let name1 = value.valueForKey("name") as? String {
//                    productList1.vendorName = name1
//                }
                
                if let name1 = value.valueForKey("service_id") as? String {
                    productList1.service_id = name1
                }
                
                productLists.append(productList1)
                print(productList1)
            }
        }
        
        print(productLists)
        return productLists
    }
    
    class func getproductDetails(result:[String:AnyObject]) -> ProductDetails {
        let productDetail = ProductDetails()
        
        if let description = result["categoryName"] as? String {
            productDetail.categoryName = description
        }
        
        if let description = result["description"] as? String {
            productDetail.productDescription = description
        }
        
        if let description = result["image"] as? String {
            productDetail.image = description
        }
        
        if let description = result["manufacturer"] as? Int {
            productDetail.manufacturer = description
        }
        
        if let description = result["manufacturer_id"] as? Int {
            productDetail.manufacturer_id = description
        }
        
        if let description = result["model"] as? String {
            productDetail.model = description
        }
        
        if let description = result["priority"] as? String {
            productDetail.priority = description
        }
        
        if let description = result["productCategories"] as? String {
            productDetail.productCategories = description
        }
        
        if let description = result["product_id"] as? Int {
            print(description)
            productDetail.product_id = description
        }
        
        if let description = result["quantity"] as? String {
            productDetail.quantity = description
        }
        
        if let description = result["ref_code"] as? String {
            productDetail.ref_code = description
        }
        
        if let description = result["service_id"] as? String {
            productDetail.service_id = description
        }
        
        if let description = result["status"] as? String {
            productDetail.status = description
        }
        
        if let description = result["subtract"] as? String {
            productDetail.subtract = description
        }
        
        if let description = result["unit"] as? Int {
            productDetail.unit = description
        }
        
        if let description = result["weight"] as? String {
            productDetail.weight = description
        }
        
        if let description = result["weight_class_id"] as? String {
            productDetail.weight_class_id = description
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
        
        if let quantity = result["offerPrice"] as? String {
            productDetail.offerPrice = quantity
        }
        
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
    
    class func customerProductsOrdersMapper(result:JSON) -> [CustomerOrders]{
        var orderLists = [CustomerOrders]()
        
        if let arr = result["orders"].array {
            for dict in arr{
                let data = CustomerOrders()
                
                if let dateAdded = dict["date_added"].string {
                    data.date_added = dateAdded
                }
                
                if let dateAdded = dict["name"].string {
                    data.name = dateAdded
                }
                
                if let dateAdded = dict["customer_name"].string {
                    data.customer_name = dateAdded
                }
                
                
                if let dateAdded = dict["order_id"].string {
                    data.order_id = dateAdded
                }
                
                if let dateAdded = dict["products"].int {
                    data.products = dateAdded
                }
                
                if let dateAdded = dict["sales_order"].string {
                    data.sales_order = dateAdded
                }
                
                if let dateAdded = dict["status"].string {
                    data.status = dateAdded
                }
                
                if let dateAdded = dict["suborder_status"].string {
                    data.suborder_status = dateAdded
                }
                
                if let dateAdded = dict["total"].string {
                    data.total = dateAdded
                }
                
                if let dateAdded = dict["href"].string {
                    data.href = dateAdded
                }
                
                if let dateAdded = dict["customer_name"].string {
                    data.customerName = dateAdded
                }
                
                if let payment_method = dict["payment_method"].string {
                    data.payment_method = payment_method
                }

                orderLists.append(data)
            }
        }
        
        print(orderLists)
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
                        
                        let fromHour = value.valueForKey("from_hour") as! String
                        let from_minute = value.valueForKey("from_minute") as! String
                        let from = value.valueForKey("from") as! String
                        
                        if fromHour == "00" && from_minute == "00" && from == "am" {
                            vendorlist.fromToDate = "Timing Not Mentioned"
                        }else{
                            vendorlist.from_date = fromHour + ":" + from_minute + from
                        }
                    }
                }else{
                    vendorlist.from_date = ""
                }
                
                if let arr = value.valueForKey("to_date") as? NSArray{
                    for (_, value) in arr.enumerate(){
                        let fromHour = value.valueForKey("end_hour") as! String
                        let from_minute = value.valueForKey("end_minute") as! String
                        let from = value.valueForKey("to") as! String
                        
                        if fromHour == "00" && from_minute == "00" && from == "am" {
                            vendorlist.fromToDate = "Timing Not Mentioned"
                        }else{
                            vendorlist.to_date = fromHour + ":" + from_minute + from
                        }
                        
                    }
                    
                }else{
                    vendorlist.to_date = ""
                }
                
                
                if vendorlist.from_date == "" && vendorlist.to_date == "" {
                   vendorlist.fromToDate = "Timing Not Mentioned"
                }
                else{
                vendorlist.fromToDate = (vendorlist.from_date + " To " + vendorlist.to_date) 
                }
                
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
        
        if let sales_order = result["suborder_id"] {
            productDetail.suborder_id = sales_order as! String
        }
        
        if let sales_order = result["suborder_status_id"] {
            productDetail.suborder_status_id = sales_order as! String
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
                
                if let totalDetailTitle = value.valueForKey("name") as? String{
                    productList.name = totalDetailTitle
                }
                
                if let totalDetailTitle = value.valueForKey("quantity") as? String{
                    productList.quantity = totalDetailTitle 
                }
                
                if  let text2 = value.valueForKey("order_status") {
                if text2 is String {
                    productList.order_status = text2 as! String
                }else{
                    productList.order_status = String(text2)
                }
                
                let text:AnyObject = value.valueForKey("price")!
                if text is String {
                    productList.price = text as! String
                }else{
                    productList.price = String(text)
                }
                }
                
                if let totalDetailTitle = value.valueForKey("product_id") as? String{
                    productList.productId = totalDetailTitle
                }
                
                let text1:AnyObject = value.valueForKey("total")!
                if text1 is String {
                    productList.total = text1 as! String
                }else{
                    productList.total = String(text1)
                }
   
              //productLists.append(productList)
                productDetail.orderProducts.append(productList)
            }
        }
        
            if let arr = result["order_status"] as? NSArray {
                for (_,value) in arr.enumerate(){
                    let productList = OrderStatus()
                    
                    if let totalDetailTitle = value.valueForKey("name") as? String{
                        productList.name = totalDetailTitle
                    }
                    
                    if let totalDetailTitle = value.valueForKey("order_status_id") as? String{
                        productList.orderStatusId = totalDetailTitle
                    }
                    
                    //productLists.append(productList)
                    productDetail.orderStatuses.append(productList)
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
            
            if let image = dic["id_card"] as? String {
                populateData.id_card = image
            }
            
            if let zone_name = dic["id_card_type"] as? String {
                populateData.id_card_type = zone_name
            }
            
            if let arr = result["id_proof"] as? NSArray {
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
                    
                    populateData.id_proof.append(totalDetail)
                }
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
                
                if let categoryID = value.valueForKey("service_name"){
                    categoryList.serviceName = categoryID as! String
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
                
                if let parentId = value.valueForKey("service_id"){
                    categoryList.service_id = parentId as! String
                }
                
                if let parentId = value.valueForKey("isglobel"){
                    categoryList.isglobel = parentId as! String
                }
                
                categoryLists.append(categoryList)
            }
            
        }
        return categoryLists
    }
    
    class func customerPromotionOrdersMapper(result:[String:AnyObject]) -> [DisplayPromotionDetails] {
        
        var categoryLists = [DisplayPromotionDetails]()
        
        //        if let dict = result["customer"] {
        //            if let name = dict["firstname"]{
        //
        //            }
        //
        //            if let name = dict["lastname"]{
        //
        //            }
        //
        //        }
        //
        //        if let dict = result["vendors"] {
        //            if let is_default = dict["company"]{
        //
        //            }
        //
        //            if let is_default = dict["is_default"]{
        //
        //            }
        //        }
        
        if let arr = result["dispalyPromotion"] as? NSArray{
            
            for (_, value) in arr.enumerate(){
                let categoryList = DisplayPromotionDetails()
                if let categoryID = value.valueForKey("name"){
                    categoryList.name = categoryID as! String
                }
                
                if let categoryName = value.valueForKey("price"){
                    let str  = categoryName as! String
                    let name = str.stringByReplacingOccurrencesOfString("&nbsp;", withString:"")
                    categoryList.price = name
                }
                if let active = value.valueForKey("discountPrice"){
                    categoryList.discountPrice = active as! String
                }
                
                if let active = value.valueForKey("discountType"){
                    categoryList.discountType = active as! String
                }
                
                let level:AnyObject = value.valueForKey("description")!
                if level is String {
                    categoryList.promotionDescription = level as! String
                }else{
                    categoryList.promotionDescription = String(level)
                }
                
                categoryLists.append(categoryList)
            }
            
        }
        
        print(categoryLists)
        return categoryLists
        
    }

    
 
}