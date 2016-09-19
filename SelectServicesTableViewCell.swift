//
//  SelectServicesTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 19/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SelectServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceType: UILabel!

    @IBOutlet weak var serviceRadioButton: SSRadioButton!
    var vendorService:VendorService!{
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
    
    func bindModelToViews(){
        
        if let serviceTyp = vendorService.desc as? String{
            serviceType.text = serviceTyp
        }
        
    }
    
}
