//
//  CustomerList.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerList: NSObject {

    dynamic var name = String()
    dynamic var mobileNumber = String()
    dynamic var emailId = String()
    dynamic var registerDate = String()
    dynamic var address = String()
    dynamic var grant = String()
    dynamic var customerId = String()
    dynamic var blockCustomerImage = String()
    dynamic var idCardType = String()
    dynamic var idProofImage = String()
    dynamic var idCardTypes = [CustomerIDProof]()
    dynamic var collapsed = true
    
}
