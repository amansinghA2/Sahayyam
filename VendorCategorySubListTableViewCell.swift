//
//  VendorCategorySubListTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 06/10/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorCategorySubListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var globalEditButton: UIButton!
    @IBOutlet weak var cellClickedButton: UIButton!
    @IBOutlet weak var productName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
