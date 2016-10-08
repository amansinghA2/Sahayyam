//
//  StoreProfileData.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 08/10/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class StoreProfileData: NSObject {
   dynamic var businessHoliday = String()
   dynamic var deliveryCharges = String()
    dynamic var deliveryTime = [DeliveryTime]()
   dynamic var endTime = [EndTime]()
   dynamic var expressDelivery = String()
   dynamic var minimum_order = String()
   dynamic var startTime = [StartTime]()
    
}
