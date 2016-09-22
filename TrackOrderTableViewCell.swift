//
//  TrackOrderTableViewCell.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 02/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit


class TrackOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderNamelabel: UILabel!
    @IBOutlet weak var dateoutlet: UILabel!
    @IBOutlet weak var saleOrderId: UILabel!
    @IBOutlet weak var orderreceivedStatus: UILabel!
    @IBOutlet weak var NoOFProductsLabel: UILabel!
    @IBOutlet weak var productTotalPrice: UILabel!
    
    var trackLoadData:CustomerOrders!{
        didSet{
            bindModeltoViews()
        }
    }
    
    var vendorLoadData:CustomerOrders!{
        didSet{
            bindModeltoViews1()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindModeltoViews() {
        
        if let orderName = trackLoadData?.name {
            self.orderNamelabel.text = orderName
        }
        
        if let date = trackLoadData?.date_added {
            self.dateoutlet.text = date
        }
        
        if let saleOrder = trackLoadData?.status {
            self.orderreceivedStatus.text = saleOrder
        }

        if let saleOrder = trackLoadData?.products {
            self.NoOFProductsLabel.text = String(saleOrder)
        }

        if let saleOrder = trackLoadData?.total {
            self.productTotalPrice.text = String(saleOrder)
        }
        
        if let saleOrder = trackLoadData?.sales_order {
            self.saleOrderId.text = String(saleOrder)
        }
 
    }
    
    func bindModeltoViews1() {

        if let saleOrder = vendorLoadData?.sales_order {
            self.saleOrderId.text = String(saleOrder)
        }
        
        if let saleOrder = vendorLoadData?.customerName {
            self.orderNamelabel.text = String(saleOrder)
        }
        
        if let saleOrder = vendorLoadData?.payment_method {
                self.NoOFProductsLabel.text = String(saleOrder)
        }
        
        if let saleOrder = vendorLoadData?.total {
            self.productTotalPrice.text = String(saleOrder)
        }
        
        if let date = vendorLoadData?.date_added {
            self.dateoutlet.text = date
        }
        
        if let saleOrder = vendorLoadData?.suborder_status {
            self.orderreceivedStatus.text = saleOrder
        }
        
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
