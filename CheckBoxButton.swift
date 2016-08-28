//
//  CheckBoxButton.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 01/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

//@objc protocol TKCheckBoxButtonDelegate{
//    optional func checkBoxSelected(selected: Bool)
//}
//
//enum TKCheckBoxButtonType{
//    case TKCheckBoxButtonGrey
//    case TKCheckBoxButtonGreen
//}

class CheckBoxButton: UIButton {

//    var delegate:TKCheckBoxButtonDelegate?
//    var tkCheckBoxButtonType:TKCheckBoxButtonType!
    
    
    let checkedImage = UIImage(named: "ch_ic_customer")! as UIImage
    let uncheckedImage = UIImage(named: "ch_ic_city_head")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, forState: .Normal)
            } else {
                self.setImage(uncheckedImage, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(CheckBoxButton.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            if isChecked == true{
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setObject("Coding Explorer", forKey: "userNameKey")
                
                isChecked = false
            }else{
                isChecked = true
            }
        }
    }
    
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }
    
//    func setCheckBoxStyle(type:TKCheckBoxButtonType){
//        tkCheckBoxButtonType = type
//        self.selected = false
//        //        if(type == .TKCheckBoxButtonGrey){
//        //            self.setBackgroundImage(UIImage(named: "checkboxSelected"), forState: .Normal)
//        //            self.addTarget(self, action: "selfClicked", forControlEvents: .TouchUpInside)
//        //            self.tintColor = UIColor.clearColor()
//        //        }else{
//        //            self.setBackgroundImage(UIImage(named: "checkGreen"), forState: .Normal)
//        //            self.addTarget(self, action: "selfClicked", forControlEvents: .TouchUpInside)
//        //            self.tintColor = UIColor.clearColor()
//        //        }
//        
//        if(type == .TKCheckBoxButtonGrey){
//            self.setBackgroundImage(UIImage(named: "ic_add_cart"), forState: .Normal)
//            self.addTarget(self, action: #selector(CheckBoxButton.selfClicked), forControlEvents: .TouchUpInside)
//            self.tintColor = UIColor.clearColor()
//        }else{
//            self.setBackgroundImage(UIImage(named: "ic_action_wishlist"), forState: .Normal)
//            self.addTarget(self, action: #selector(CheckBoxButton.selfClicked), forControlEvents: .TouchUpInside)
//            self.tintColor = UIColor.clearColor()
//        }
//    }
//    func selfClicked(){
//        if self.selected{
//            self.selected = false
//            if(tkCheckBoxButtonType == .TKCheckBoxButtonGrey){
//                self.setBackgroundImage(UIImage(named: "ic_add_cart"), forState: .Normal)
//            }else{
//                self.setBackgroundImage(UIImage(named: "ic_action_wishlist"), forState: .Normal)
//            }
//        }
//            
//        else{
//            self.selected = true
//            if(tkCheckBoxButtonType == .TKCheckBoxButtonGrey){
//                self.setBackgroundImage(UIImage(named: "checkboxSelected"), forState: .Normal)
//            }
//            else{
//                self.setBackgroundImage(UIImage(named: "ic_action_cart"), forState: .Normal)
//            }
//        }
//        delegate?.checkBoxSelected!(self.selected)
//    }
//    
//    func setCheckboxSelected(select: Bool){
//        if select{
//            if(tkCheckBoxButtonType == .TKCheckBoxButtonGrey){
//                self.setBackgroundImage(UIImage(named: "checkboxSelected"), forState: .Normal)
//            }else{
//                self.setBackgroundImage(UIImage(named: "ic_action_cart"), forState: .Normal)
//            }
//            
//        }else{
//            if(tkCheckBoxButtonType == .TKCheckBoxButtonGrey){
//                self.setBackgroundImage(UIImage(named: "ic_add_cart"), forState: .Normal)
//            }else{
//                self.setBackgroundImage(UIImage(named: "ic_action_wishlist"), forState: .Normal)
//            }
//        }
//        self.selected = select
//    }


}
