//
//  b2bcHeaderTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 15/12/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class b2bcHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var b2bTypeLabel: UILabel!
    @IBOutlet weak var b2bNameLabel: UILabel!
    
    @IBOutlet weak var customerListButtonlabel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
