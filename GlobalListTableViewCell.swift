//
//  GlobalListTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class GlobalListTableViewCell: UITableViewCell {

    @IBOutlet weak var addButtonLabel: Button!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var addButtonImage: UIImageView!
    var getProductCollectionLists1:ProductCollectionList!{
        didSet{
            bindModeltoViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindModeltoViews(){
        if let customerProductImage1 = getProductCollectionLists1?.image1 {
            if customerProductImage1 != "" {
                self.productImage.imageFromUrl(customerProductImage1)
            } else {
                self.productImage.image = UIImage(named: "v_no_image")
            }
        }
        
        if let customerProductName = getProductCollectionLists1?.vendorName {
            self.productName.text = customerProductName
        }
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func productAddAction(sender: AnyObject) {
        
        
        
    }
}
