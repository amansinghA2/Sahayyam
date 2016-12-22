//
//  b2bcTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 15/12/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class b2bcTableViewCell: UITableViewCell {

    @IBOutlet weak var mobileNoLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var businessTypeLabel: UILabel!
    
    @IBOutlet weak var subsLabel: UILabel!
    
    @IBOutlet weak var regnDateLabel: UILabel!
    
    @IBOutlet weak var expiryDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
