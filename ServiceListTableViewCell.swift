//
//  ServiceListTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 21/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ServiceListTableViewCell: UITableViewCell {
    
    var serviceList:ServiceDesc!{
        didSet{
            bindModelToViews()
        }
    }
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindModelToViews() {
        
        if let desc = serviceList.desc as? String{
            serviceNameLabel.text = desc
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
