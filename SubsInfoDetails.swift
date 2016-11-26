//
//  SubsInfoDetails.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 25/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SubsInfoDetails: NSObject {

    dynamic var WorkingSubscription = String()
    dynamic var activecustomer = String()
    dynamic var assign = String()
    dynamic var checksellersubscriptiontype = String()
    dynamic var vendor_type = String()
    dynamic var period = [CHSubsTime]()
    dynamic var pkg = [CHSubsPackage]()
    dynamic var sub_detail = [CHSubsInfoDetail]()
    dynamic var sub_type = [CHSubType]()
    
}
