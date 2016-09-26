//
//  CityHeadJsonMapper.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Foundation

extension CommonJsonMapper {
    
    class func getSubsDetailsMapper(result:[String:AnyObject]) -> [SubsNameDetails]  {
        
        var customerLists = [SubsNameDetails]()
        
        if let customers = result["city_head_list"] as? NSArray{
            
            for (_,value) in customers.enumerate(){
                let customerList = SubsNameDetails()
                
                if let name = value.valueForKey("firstname") as? String{
                    customerList.firstname = name
                }
                
                if let telephone = value.valueForKey("lastname") as? String{
                    customerList.lastname = telephone
                }
                
                if let email = value.valueForKey("customer_id") as? String{
                    customerList.customer_id = email
                }
                
                customerLists.append(customerList)
            }
            
        }
        return customerLists
    }
  
    
    
}
