//
//  CommonJsonMapper.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 01/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import CoreData

class CommonJsonMapper: NSObject {

// MARK: - Login 

    class func loginMapper(result:[String:AnyObject])  -> CustomerLoginData {
            let loginData = CustomerLoginData()
                if let dic = result["switchprofile"]{
                    if let profileType = dic["profileType"]{
                        loginData.profileType = profileType as! Int
                    }
                    if let cust_type = dic["cust_type"]{
                        loginData.cust_type = cust_type as! Int
                    }
                }
//                if let dic1 = result["customer"] {
//                    
//                    if let str = dic1["product_id"]{
//                        loginData.id = str as! String
//                    }
//                    
//                }
                if let profile = result["profile"] {
                    loginData.profile = profile as! Bool
                    
                }
                if let cookie = result["cookie"] {
                    loginData.cookie = cookie as! String
                    
            }
        return loginData
    }
}



