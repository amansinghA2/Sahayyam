//
//  VendorApprovedDetailTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 29/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorApprovedDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var clickedIndexButton: UIButton!
    @IBOutlet weak var vendorImage: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    
    @IBOutlet weak var approvedButton: UIButton!
    
    var approvedPendingList:ApprovePendingStatus!{
        didSet{
            bindModelToViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindModelToViews() {
        
        if let vendorImage1 = approvedPendingList.img as? String {
            if vendorImage1 != "" {
                vendorImage.imageFromUrl(image_base_url + vendorImage1)
            }else{
               vendorImage.image = UIImage(named: "v_no_image")
            }
        }
        
        if let productName = approvedPendingList.product_name as? String {
            productNameLabel.text = productName
        }
        
        if let productName = approvedPendingList.category_name as? String {
            categoryNameLabel.text = productName
        }
        
        if let productName = approvedPendingList.service_desc as? String {
            serviceNameLabel.text = productName
        }

        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
