//
//  Double.swift
//  Sahayyam
//
//  Created by Aman on 9/22/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

extension Double {

    func roundToPlaces(places:Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }

}
