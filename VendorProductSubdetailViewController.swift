//
//  VendorProductSubdetailViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 29/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorProductSubdetailViewController: UIViewController {

    
    @IBOutlet weak var vendorImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var roundedView: RoundedView!
    @IBOutlet weak var offerpriceLabel: UILabel!
    
    @IBOutlet weak var servicenameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var unitTypeLabel: UILabel!
    
    @IBOutlet weak var unitValueLabel: UILabel!
    
    @IBOutlet weak var manufacturerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var subtractStockLabel: UILabel!
    @IBOutlet weak var referenceCodeLabel: UILabel!
    
    var approvedPendingList:ApprovePendingStatus!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        self.roundedView.layer.borderColor = UIColor .grayColor().CGColor
        self.roundedView.layer.borderWidth = 1.0
        self.roundedView.layer.cornerRadius = 5.0
        showAnimate()
        bindModelToViews()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindModelToViews(){
        
        if let vendorImage1 = approvedPendingList.img as? String {
            if vendorImage1 != "" {
                vendorImage.imageFromUrl(image_base_url + vendorImage1)
            }else{
                vendorImage.image = UIImage(named: "v_no_image")
            }
        }
        
        if let productName1 = approvedPendingList.product_name as? String {
            productName.text = productName1
        }
        
        if let productName = approvedPendingList.category_name as? String {
            categoryNameLabel.text = productName
        }
        
        if let productName = approvedPendingList.service_desc as? String {
            servicenameLabel.text = productName
        }
        
        if let productName = approvedPendingList!.price as? String {
            priceLabel.text = productName
        }
        
        if let productName = approvedPendingList.offerPrice as? String {
            offerpriceLabel.text = productName
        }
        
        if let productName = approvedPendingList.quantity as? String {
            quantityLabel.text = productName
        }
        
        if let productName = approvedPendingList.unit_value as? String {
            unitValueLabel.text = productName
        }
        
        if let productName = approvedPendingList.unit as? String {
            unitTypeLabel.text = productName
        }
        
        if let productName = approvedPendingList.manufacturer as? String {
            manufacturerLabel.text = productName
        }
        
        if let productName = approvedPendingList.desc as? String {
            descriptionLabel.text = productName
        }
        
        if let productName = approvedPendingList.date as? String {
            dateLabel.text = productName
        }
        
        if let productName = approvedPendingList.subtract as? String {
            subtractStockLabel.text = productName
        }
        
        if let productName = approvedPendingList.ref_code as? String {
            referenceCodeLabel.text = productName
        }
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func closeButtonAction(sender: AnyObject) {
        self.removeAnimate()
    }

}
