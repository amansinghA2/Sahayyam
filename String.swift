//
//  String.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import Foundation

    // MARK: - Base Url

let BASE_URL = "http://192.168.1.2/sahayyam/"
let image_base_url = "http://192.168.1.2/sahayyam/image/"

//let BASE_URL = "http://45.118.180.96/"
//let image_base_url = "http://45.118.180.96/image/"

//let BASE_URL = "http://sahayyam.com/"
//let image_base_url = "http://sahayyam.com/image/"

    // MARK: - Common Url

let urlString = BASE_URL+"index.php?route=api/login"
let switchProfileUrl = BASE_URL+"index.php?route=api/switchprofile"
let customerUpdateProfileUrl = BASE_URL+"index.php?route=api/customer"
let customerUploadImageUrl = BASE_URL+"index.php?route=api/filemanager/upload"
let customerForgotPasswordUrl = BASE_URL+"index.php?route=api/forgetPassword/chk_valid"
let customerPushNotificationUrl = BASE_URL+"index.php?route=api/mobileNotification"
let loginLogoutUrl = BASE_URL+"index.php?route=api/login/logout"
let checkTokenHealthUrl = BASE_URL+"index.php?route=api/login/getHealth"
let passswrodCOnfirmPasswordUrl = BASE_URL+"index.php?route=api/passwordChange/changePassword"
let aboutUsUrl = BASE_URL+"index.php?route=api/contactus/getVendorAddress"

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
let customerEditToCartUrl = BASE_URL+"index.php?route=api/cart/edit"
let customerGetWishlistUrl = BASE_URL+"index.php?route=api/wishlist/products"
let customerAddToWishlist = BASE_URL+"index.php?route=api/wishlist/add"
let customerRemoveFromWishListUrl = BASE_URL+"index.php?route=api/wishlist/remove"
let customerUpdateProfilePopulateUrl = BASE_URL+"index.php?route=api/customer/getInfo"
let storeProfileUrl = BASE_URL+"index.php?route=api/storeProfile"


    // MARK:- Vendors Url

let categoryUrl = BASE_URL+"index.php?route=api/category"
let getCustomerUrl = BASE_URL+"index.php?route=api/vendor/getCustomer"
let vendorSubscriptionurl = BASE_URL+"index.php?route=api/vendor/getVendorSubscription"
let transactionsUrl = BASE_URL+"index.php?route=api/vendor/getPayHistory"
let viewordersUrl = BASE_URL+"index.php?route=api/vendorOrder/getTableData&iColumns=50"
let globalLIstUrl = BASE_URL+"index.php?route=api/vendor/globalList"
let getVendorServicesUrl = BASE_URL+"index.php?route=api/vendor/getVendorServices"
let myproductsGlobalListUrl = BASE_URL+"index.php?route=api/vendor/globalList"
let autoCompleteCategoryUrl = BASE_URL+"index.php?route=catalog/category/autocomplete"
let displayPromotionListUrl = BASE_URL+"index.php?route=api/promotion/displayPromotion"
let addpromotionUrl = BASE_URL+"index.php?route=api/promotion/addPromotion"
let editproducturl = BASE_URL+"index.php?route=api/vendor/editProduct"
let editpromotionurl = BASE_URL+"index.php?route=api/promotion/editPromotion"
let registerCustomerUrl = BASE_URL+"index.php?route=api/account-customer/register"
let vendororderdetailsUrl = BASE_URL+"index.php?route=api/vendorOrder/viewOrder"
let getProductdetailsUrl = BASE_URL + "index.php?route=api/vendor/getProducts"
let addProductUrl = BASE_URL+"index.php?route=api/vendor/addProduct"
let globalAddProductUrl = BASE_URL+"index.php?route=api/vendor/ajaxSave"
let sellerInfoUrl = BASE_URL+"index.php?route=api/vendor/jxSaveSellerInfo"
let sellerPopulateUrl = BASE_URL+"index.php?route=api/customer/getDataSeller"
let vendorAboutusUrl = BASE_URL + "index.php?route=api/contactus"
let cancelLIneOrder = BASE_URL + "index.php?route=api/vendorOrder/cancelLineOrder"
let blockSalesExecutiveUrl = BASE_URL + "index.php?route=api/vendor/customerGrant"
let blockMyProductsImageUrl = BASE_URL + "index.php?route=api/vendor/noImage"
let changeOrderStatusUrl = BASE_URL + "index.php?route=api/vendorOrder/changeOrderStatus"
let vendorCategoryAddUrl = BASE_URL + "index.php?route=api/category/addCat"
let vendorEditCategoryUrl = BASE_URL + "index.php?route=api/category/editCat"
let vendorDeleteCategoryUrl = BASE_URL + "index.php?route=api/category/deleteCat"
let vendormobileNotificationUrl = BASE_URL + "index.php?route=api/mobileNotification"
let vendorDeactivatePromotionUrl = BASE_URL + "index.php?route=api/promotion/deactivatePromotion"
let vendorDeletePromotionUrl = BASE_URL + "index.php?route=api/promotion/delPromotion"
let vendorUnitGramUrl = BASE_URL + "index.php?route=api/appUtility/getWeightClass"

    // CityHead URl

let changePasswordUrl = BASE_URL+"index.php?route=api/passwordChange"
let subscriptionInfoUrl = BASE_URL+"index.php?route=api/subscription/subscriptionInfo"
let freeSubscriptionUrl = BASE_URL+"index.php?route=api/subscription/update_subscription"
let paidSubscriptionUrl = BASE_URL+"index.php?route=api/subscription/save_ms_seller"
let addVendorPopulateDataUrl = BASE_URL+"index.php?route=api/cityHead/addVendor"
let getCityWisePincodeUrl = BASE_URL+"index.php?route=api/cityHead/getCity"
let getCategoriesUrl = BASE_URL+"index.php?route=api/cityHead/getBusAjax"
let chAddNewVendorUrl = BASE_URL+"index.php?route=api/cityHead/addVendor"
let storePormotionUrl = BASE_URL+"index.php?route=api/subscription/storeSubscription"
let vendorListSubscriptionUrl = BASE_URL+"index.php?route=api/cityHead"
let chAddNewVendor = BASE_URL+"index.php?route=api/cityHead/addVendor"

var getHour = String()
var getMinute = String()

extension String
{
    var isBlank: Bool {
        get {
            let trimmed = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return trimmed.isEmpty
        }
    }
    
    var isPhoneNumber: Bool {
        let character  = NSCharacterSet(charactersInString: "+0123456789").invertedSet
        var filtered:NSString!
        let inputString:NSArray = self.componentsSeparatedByCharactersInSet(character)
        filtered = inputString.componentsJoinedByString("")
        return  self == filtered
        
    }

}