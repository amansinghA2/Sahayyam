//
//  VndornewProductAddViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VndornewProductAddViewController: UIViewController {

    
    
    @IBOutlet weak var manufacturerLabel: UITextField!
    
    @IBOutlet weak var serviceLabel: UITextField!
    @IBOutlet weak var categoryLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionLabel: UITextField!
    
    @IBOutlet weak var referenceCodeLabel: UITextField!
    
    @IBOutlet weak var offerPriceLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var unitValueLabel: UITextField!
    @IBOutlet weak var unitTypeLabel: UITextField!
    @IBOutlet weak var quantityLabel: UITextField!
    @IBOutlet weak var substractStockLabel: UITextField!
    
    @IBOutlet weak var statusLabel: UITextField!
    
    @IBOutlet weak var productImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveButton(sender: AnyObject) {
        
        
        
    }

}
