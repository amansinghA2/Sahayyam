//
//  CustomClass.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 29/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomClass: NSObject {

    class func DataFilter(categoryArray:[CategoryList]) -> [CategoryList]{
        
        var filteredLists = [CategoryList]()
         filteredLists = categoryArray.filter({
            if $0.parent_id == "0" {
                for category in categoryArray{
                    if $0.category_id == category.parent_id{
                        if !(category.products == "0") {
                            return true
                        }
                    }
                }
            }
            
            if !($0.products == "0") {
                return true
            }
            return false
        })
        print(filteredLists)
        return filteredLists
        
    }
    
    class func htmlTrimmed(text:String) -> String {
        let trimmedString = text.stringByReplacingOccurrencesOfString("<[^>]+>", withString: " , ", options: .RegularExpressionSearch, range: nil)
        
        return trimmedString
    }
    
    
   class func roundString(receivedString:AnyObject) -> String {
        
        var finalTotal = String()
        var total = String()
        
        let text:AnyObject = receivedString
        if text is String {
            total = text as! String
        }else{
            total = String(text)
        }
        
        let a:Double? = Double(total)
        let twoDec =  Double(round(100 * a!) / 100)
        let charset = NSCharacterSet(charactersInString: ".")
        if (total.lowercaseString.rangeOfCharacterFromSet(charset) != nil) {
            finalTotal = "Rs. " + "\(twoDec)"
        }else{
            finalTotal = "Rs. " + "\(total)" + ".00"
        }
        
     return finalTotal

    }
    
}
