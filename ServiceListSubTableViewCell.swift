//
//  ServiceListSubTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import M13Checkbox

class ServiceListSubTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var checkBoxView: M13Checkbox!
    
    var serviceList:LeftService!{
        didSet{
            bindModelToViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindModelToViews() {
        
        if let desc = serviceList.desc as? String{
            serviceNameLabel.text = desc
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
