//
//  SubsPaymentTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 26/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SubsPaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subsLabel: UILabel!
    @IBOutlet weak var subsPaymentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
