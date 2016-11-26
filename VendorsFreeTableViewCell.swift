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
    
//    var vendoSubsLIst:CHVendorSubsList!{
//        didSet{
//            bindModelToViews()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    func bindModelToViews(){
//        
//        if let _ = vendoSubsLIst.firstname as? String {
//            nameLabel.text = vendoSubsLIst.firstname + " " + vendoSubsLIst.lastname
//        }
//        
//        if let telephone = vendoSubsLIst.telephone as? String {
//            mobileLabel.text = telephone
//        }
//        
//        if let _ = vendoSubsLIst.firstname as? String {
//            nameLabel.text = vendoSubsLIst.firstname + " " + vendoSubsLIst.lastname
//        }
//        
//        if let _ = vendoSubsLIst.email as? String {
//            email.text = vendoSubsLIst.firstname + " " + vendoSubsLIst.lastname
//        }
//        
//        if let _ = vendoSubsLIst.firstname as? String {
//            nameLabel.text = vendoSubsLIst.firstname + " " + vendoSubsLIst.lastname
//        }
//        
//        
//    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
