//
//  Button.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit


let cornerRadius:CGFloat = 4.0

class Button: UIButton {
    
    override func awakeFromNib() {
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func commonInit(){
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = UIColor.orangeColor()
    }

    
}

