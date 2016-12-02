//
//  CustomerImageShowSubViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 01/12/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerImageShowSubViewController: UIViewController {

    @IBOutlet weak var customerIdImage: UIImageView!

    var customerList1:CustomerList!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        showAnimate()
    NSNotificationCenter.defaultCenter().postNotificationName("disableCategoryNavigation2", object: nil)
        self.customerIdImage.layer.borderColor = UIColor .grayColor().CGColor
        self.customerIdImage.layer.borderWidth = 2.0
        self.customerIdImage.layer.cornerRadius = 10.0

        if let image = customerList1.idProofImage as? String {
            customerIdImage.imageFromUrl(image)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func cancelButton(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("refresh2", object: "enabledUserInteraction")
        self.removeAnimate()

    }
    
}
