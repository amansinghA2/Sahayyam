//
//  LoginData.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 02/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import Foundation

class CustomerLoginData: NSObject {
    
    dynamic var customerId = String()
    dynamic var success = Bool()
    dynamic var cookie = String()
    dynamic var customer_type = String()
    dynamic var profileType = Int()
    dynamic var cust_type = Int()
    dynamic var profile = Bool()
    dynamic var memory = String()
    dynamic var address = String()
    dynamic var city = String()
    dynamic var country = String()
    dynamic var postcode = String()
    
    
    dynamic var vendorList = [VendorList]()
    dynamic var categoryList = [CategoryList]()
    
}
