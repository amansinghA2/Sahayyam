//
//  SubscriptionDetailsTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SubscriptionDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var supscriptionName: UILabel!
    @IBOutlet weak var priceMonthCustomer: UILabel!
    @IBOutlet weak var customerCount: UILabel!
    @IBOutlet weak var remainingDays: UILabel!
    @IBOutlet weak var expiresOn: UILabel!
    @IBOutlet weak var startdate: UILabel!
    @IBOutlet weak var balanceCredit: UILabel!
    @IBOutlet weak var status: UILabel!
    
    var subscriptionList:SubscriptionList!{
        didSet{
            bindMOdelToViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindMOdelToViews() {
        
        if let name = subscriptionList.subscriptionName as? String{
            supscriptionName.text = name
        }
        
        if let priceMonthCustomer1 = subscriptionList.priceMonthCustomer as? String{
            priceMonthCustomer.text = priceMonthCustomer1
        }
        if let name = subscriptionList.customerCount as? String{
            customerCount.text = name
        }
        if let name = subscriptionList.remainingDays as? Int{
            remainingDays.text = String(name)
        }
        if let name = subscriptionList.expiresOn as? String{
            expiresOn.text = name
        }
        if let name = subscriptionList.startDate as? String{
            startdate.text = name
        }
        if let name = subscriptionList.balanceCredit as? Int{
            balanceCredit.text = String(name)
        }
        if let name = subscriptionList.status as? String{
            status.text = name
        }
        
    }
    

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
