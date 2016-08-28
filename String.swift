//
//  String.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import Foundation

// MARK: - Base Url


// "http://192.168.1.2/sahayyam/image/"
// "http://sahayyam.com/"
// "http://192.168.1.2/sahayyam/"
// "http://sahayyam.com/image/"

let BASE_URL = "http://sahayyam.com/"
let image_base_url = "http://sahayyam.com/image/"

// MARK: - Common Url

let urlString = BASE_URL+"index.php?route=api/login"
let switchProfileUrl = BASE_URL+"index.php?route=api/switchprofile"
let customerUpdateProfileUrl = BASE_URL+"index.php?route=api/customer"
let customerUploadImageUrl = BASE_URL+"index.php?route=api/filemanager/upload"
let loginLogoutUrl = BASE_URL+"index.php?route=api/login/logout"
let checkTokenHealthUrl = BASE_URL+"index.php?route=api/login/getHealth"

// MARK: - Customers Url

let logoutUrl = BASE_URL+"index.php?route=api/login/logout"
let customerCartProductListUrl = BASE_URL+"index.php?route=api/cart/products"
let customerCheckoutListUrl = BASE_URL+"index.php?route=api/order/add"
let customerPromotionUrl = BASE_URL+"index.php?route=api/promotion/displayCustPromotion"
let customerOrdersUrl = BASE_URL+"index.php?route=api/order/getOrders"
let customerOrderDetailsUrl = BASE_URL+"index.php?route=api/order/getOrder"
let customerProductsUrl = BASE_URL+"index.php?route=api/vendorProducts"
let customerProductDetailsUrl = BASE_URL+"index.php?route=api/vendor/getProducts"
let inCustomersVendorListUrl = BASE_URL+"index.php?route=api/customer/getInfo"
let setDefaultVendorUrl = BASE_URL+"index.php?route=api/vendor/setDefaultVendor"
let customergetcartListUrl = BASE_URL+"index.php?route=api/cart/products"
let customerRemoveFromCartUrl = BASE_URL+"index.php?route=api/cart/remove"
let customerAddToCartUrl = BASE_URL+"index.php?route=api/cart/add"
let customerGetWishlistUrl = BASE_URL+"index.php?route=api/wishlist/products"
let customerAddToWishlist = BASE_URL+"index.php?route=api/wishlist/add"
let customerRemoveFromWishListUrl = BASE_URL+"index.php?route=api/wishlist/remove"
let customerUpdateProfilePopulateUrl = BASE_URL+"index.php?route=api/customer/getInfo"

// MARK:- Vendors Url



extension String
{
    var isBlank: Bool {
        get {
            let trimmed = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return trimmed.isEmpty
        }
    }
    
    var isPhoneNumber: Bool {
        let charcter  = NSCharacterSet(charactersInString: "+0123456789").invertedSet
        var filtered:NSString!
        let inputString:NSArray = self.componentsSeparatedByCharactersInSet(charcter)
        filtered = inputString.componentsJoinedByString("")
        return  self == filtered
        
    }
    
  
    
}