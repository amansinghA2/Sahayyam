//
//  VendorListTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 16/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorListTableViewCell: UITableViewCell {

    @IBOutlet weak var storeName: UILabel!
    
    @IBOutlet weak var mobileNumber: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var timingLabel: UILabel!
    
    @IBOutlet weak var vendorImage: UIImageView!
    var vendorList:VendorList!{
        didSet{
            bindModelToViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func  bindModelToViews(){
      
        if let nickname = vendorList?.nickname {
            self.storeName.text! = nickname
        }
        
        if let address_1 = vendorList?.address_1 {
            self.addressLabel.text = address_1
        }
        
        if let tel = vendorList?.tel {
            self.mobileNumber.text = tel
        }
        
        if let fromToDate = vendorList?.fromToDate {
            self.timingLabel.text = fromToDate
        }
        
        if let vendorImage = vendorList?.image {
            if vendorImage != "" {
            let str = image_base_url + vendorImage
            self.vendorImage.imageFromUrl(str)
            }
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
