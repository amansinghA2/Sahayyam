//
//  VendorsFreeTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorsFreeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mobileLabel: UILabel!
    
    @IBOutlet weak var busTypeLabel: UILabel!
    
    @IBOutlet weak var subFeesLabel: UILabel!
    
    @IBOutlet weak var subscriptionButton: UIButton!
    
    var freevendorList:FreeVendorList!{
        didSet{
            bindModelToViews()
        }
    }
    
    var unpaidVendorList:UnpaidVendorList!{
        didSet{
            bindModelToViews1()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindModelToViews(){
        
        if let busType = freevendorList.bus_type as? String {
            busTypeLabel.text = busType
        }
        
        if let telephone = freevendorList.seller as? String {
            nameLabel.text = telephone
        }
        
//      if let sellerId = freevendorList.seller_id as? String {
//            nameLabel.text = sellerId
//      }
        
        if let subsfees = freevendorList.subscription_fees as? String {
           subFeesLabel.text = subsfees
        }
        
        if let telephone = freevendorList.telephone as? String {
            mobileLabel.text = telephone
        }
        
        
    }
    
    func bindModelToViews1(){
        
        if let busType = unpaidVendorList.bus_type as? String {
            busTypeLabel.text = busType
        }
        
        if let telephone = unpaidVendorList.seller as? String {
            nameLabel.text = telephone
        }
        
        //        if let sellerId = freevendorList.seller_id as? String {
        //            nameLabel.text = sellerId
        //        }
        
        if let subsfees = unpaidVendorList.subscription_fees as? String {
            subFeesLabel.text = subsfees
        }
        
        if let telephone = unpaidVendorList.telephone as? String {
            mobileLabel.text = telephone
        }
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
