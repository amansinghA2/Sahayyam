//
//  CartProductList.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 04/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import Foundation

class CartProductList: NSObject {

    dynamic var actual_total_order = Int()
    dynamic var complete_order_total = Int()
    dynamic var is_express = Bool()
    dynamic var urgent_delivery_cost = String()
    dynamic var total_deliv_charge = String()
    dynamic var seller_id = Int()
    dynamic var mo = String()
    dynamic var del_charges = String()
    dynamic var from_date = String()
    dynamic var to_date = String()
    dynamic var del_time = String()
    dynamic var urgent_delivery = Int()
    dynamic var default_vendor_type = String()
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }

    
}
