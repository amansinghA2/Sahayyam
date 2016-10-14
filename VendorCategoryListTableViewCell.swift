//
//  VendorCategoryListTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorCategoryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellClickedButton: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var imageLeftConstraint: NSLayoutConstraint!

    @IBOutlet weak var globalEditbutton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
