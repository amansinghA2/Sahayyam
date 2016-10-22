
//
//  CustomNSDate.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 22/10/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import Foundation

extension NSDate {
    func isBetweeen(date date1: NSDate, andDate date2: NSDate) -> Bool {
        return date1.compare(self).rawValue * self.compare(date2).rawValue >= 0
    }
}

