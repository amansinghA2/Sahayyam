//
//  Products.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 04/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import Foundation

class Products: NSObject {
    
        dynamic var key = String()
        dynamic var product_id = Int()
        dynamic var name = String()
        dynamic var model = String()
      //dynamic var option = []
        dynamic var cartQuantity = Int()
        dynamic var stock = Bool()
        dynamic var shipping = Bool()
        dynamic var price = String()
        dynamic var total = String()
        dynamic var reward = Int()
        dynamic var image = String()
        dynamic var urgent_delivery = String()
        dynamic var checkoutDeliveryTime = [CheckoutDeliveryTime]()
        dynamic var customerCartDetails = [CheckoutOrderTotals]()
       dynamic var is_express = Bool()
    
       dynamic var totalOrder = String()
 
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
}
