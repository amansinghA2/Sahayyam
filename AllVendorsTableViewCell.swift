//
//  AllVendorsTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class AllVendorsTableViewCell: UITableViewCell {

    @IBOutlet weak var vendorImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mobileLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var createdByLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var customerCountLabel: UILabel!
    
    var vendoSubsLIst:CHVendorSubsList!{
        didSet{
            bindModelToViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func bindModelToViews(){
        
        if let _ = vendoSubsLIst.firstname as? String {
            nameLabel.text = vendoSubsLIst.firstname + " " + vendoSubsLIst.lastname
        }
        
        if let telephone = vendoSubsLIst.telephone as? String {
            mobileLabel.text = telephone
        }
        
        if let email = vendoSubsLIst.email as? String {
            emailLabel.text = email
        }
        
        if let _ = vendoSubsLIst.address as? String {
            address.text = vendoSubsLIst.address + "," + vendoSubsLIst.city + "," + vendoSubsLIst.zone_name
        }
        if let createdBy = vendoSubsLIst.created_by as? String {
            createdByLabel.text = createdBy
        }
        
        if let createdBy = vendoSubsLIst.status as? String {
            if createdBy == "1" {
              statusLabel.text = "Active"
            }else {
              statusLabel.text = "Inactive"
            }
            
        }
        
        if let createdBy = vendoSubsLIst.customer_count as? String {
            customerCountLabel.text = createdBy
        }
        
        if let createdBy = vendoSubsLIst.image as? String {
            if createdBy != "" {
            vendorImage.imageFromUrl(createdBy)
            }else{
            vendorImage.image = UIImage(named: "v_no_image")
            }
        }
        
        
    }
    
}
