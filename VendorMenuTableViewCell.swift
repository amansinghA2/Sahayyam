//
//  VendorMenuTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 06/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var listNames: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
