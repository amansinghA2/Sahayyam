//
//  Validations.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import SwiftLoader

class Validations: NSObject {
    
    class func isValidPassAndConfirmPassword(password:String , confirmPassword:String) -> Bool{
    
    if (password == confirmPassword) && (password.characters.count == confirmPassword.characters.count) {
        return true
    }else {
        return false
    }
    
   }
  
}