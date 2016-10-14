//
//  VendorPromotionTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorPromotionTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    @IBOutlet weak var deactivateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var notifyButton: UIButton!

    var vendorPromotionList:VendorPromotionList!{
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

    func bindModelToViews() {

        if let name = vendorPromotionList.name as? String{
            nameLabel.text = name
        }

        if let name = vendorPromotionList.price as? String{
            priceLabel.text = "On Price: INR. " + name + "/-"
        }


        if vendorPromotionList.discount != "" {
        if let name = vendorPromotionList.discount as? String{
            discountLabel.text = "Discount: INR. " + name + "/-"
        }
        }

        if let name = vendorPromotionList.name as? String{
            nameLabel.text = name
        }

        if let name = vendorPromotionList.start_date_added as? String{
            startDate.text = "Start: " + name
        }

        if let name = vendorPromotionList.end_date_added as? String{
            endDate.text = "End: " + name
        }

    }
    
}
