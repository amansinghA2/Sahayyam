//
//  Customer.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 02/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import Foundation

class Customer: NSObject {

    dynamic var customerId = String()
    dynamic var firstName = String()
    dynamic var lastname = String()
    dynamic var designation = String()
    dynamic var image = String()
    dynamic var status = Bool()
    dynamic var customer_group = String()
    dynamic var telephone = String()
    dynamic var email = String()
    dynamic var ref = String()
    dynamic var cust_type  = String()
    dynamic var dated  = String()
    dynamic var allow_city  = String()
    dynamic var allow_state  = String()
    dynamic var bus_type  = String()
    dynamic var postcode  = String()
    dynamic var dob  = String()
    dynamic var address  = String()
    dynamic var address_1  = String()
    dynamic var address_2  = String()
    dynamic var city  = String()
    dynamic var zone_name  = String()
    dynamic var country  = String()
    dynamic var zone_id  = String()
    dynamic var postcode_id  = String()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
