//
//  RoundedView.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 05/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class RoundedView: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = true;
    }
    
    override func drawRect(rect: CGRect){
       
    }
   

}
