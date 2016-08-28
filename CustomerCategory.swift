//
//  CustomerCategory.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 02/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import Foundation

class CustomerCategory: NSObject {
    
     dynamic var category_id = String()
     dynamic var name = String()
     dynamic var parent_id = String()
     dynamic var children = String()
     dynamic var disabled = Bool()
     dynamic var isglobel = String()
     dynamic var seller_id = String()
     dynamic var active = String()
     dynamic var level = String()
     dynamic var sort_order = String()
     dynamic var products = String()
     
// Specify properties to ignore (Realm won't persist these)
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
}
