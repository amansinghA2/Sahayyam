//
//  CustomerOrderDetails.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 11/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerOrderDetails: NSObject {
    
    dynamic var order_id = String()
    dynamic var date_added = String()
    dynamic var payment_address = String()
    dynamic var sales_order = String()
    dynamic var payment_method = String()
    dynamic var orderProducts = [OrderProductList]()
    dynamic var orderTotals = [CheckoutOrderTotals]()
    
//    dynamic var title = String()
//    dynamic var text = String()
}
