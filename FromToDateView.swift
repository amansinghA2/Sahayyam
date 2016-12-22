//
//  FromToDateView.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 16/12/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class FromToDateView: UIView {
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "FromToDateView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
