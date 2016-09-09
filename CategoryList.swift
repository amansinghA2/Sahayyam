
//
//  CategoryList.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 27/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CategoryList: NSObject {

    dynamic var category_id = String()
    dynamic var name = String()
    dynamic var parent_id = String()
//    dynamic var service_id = String()
//    dynamic var service_name = String()
//    dynamic var disabled = String()
    dynamic var isglobel = String()
 //   dynamic var seller_id = String()
    dynamic var active = String()
    dynamic var level = String()
//    dynamic var sort_order = String()
    dynamic var products = String()
    dynamic var collapsed = true
//    init(category_id: String, name: String , parent_id: String, isglobel: String, active: String, level: Int , products: String) {
//        self.category_id = name
//        self.name = name
//        self.parent_id = parent_id
//        self.isglobel = isglobel
//        self.active = active
//        self.level = level
//        self.products = products
//    }
    
    override init() {}
    
    required init(coder decoder: NSCoder) {
        self.category_id = decoder.decodeObjectForKey("category_id") as! String
        self.name = decoder.decodeObjectForKey("name") as! String
        self.parent_id = decoder.decodeObjectForKey("parent_id") as! String
        self.isglobel = decoder.decodeObjectForKey("isglobel") as! String
        self.active = decoder.decodeObjectForKey("active") as! String
        self.level = decoder.decodeObjectForKey("level") as! String
      //  self.level = decoder.decodeObjectForKey("level") as! Int
        self.products = decoder.decodeObjectForKey("products") as! String
       // self.collapsed = decoder.decodeObjectForKey("collapsed") as! Bool
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.category_id, forKey: "category_id")
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeObject(self.parent_id, forKey: "parent_id")
        coder.encodeObject(self.isglobel, forKey: "isglobel")
        coder.encodeObject(self.active, forKey: "active")
        coder.encodeObject(self.level, forKey: "level")
        coder.encodeObject(self.products, forKey: "products")
       // coder.encodeObject(self.collapsed, forKey: "collapsed")
        
    }
    
}
