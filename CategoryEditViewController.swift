//
//  CategoryEditViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 15/10/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class CategoryEditViewController: UIViewController , DropperDelegate {
    
    
    @IBOutlet weak var categoryName: UITextField!
    
    @IBOutlet weak var statusTextField: UITextField!
    
    @IBOutlet weak var statusButton: UIButton!
    let dropper = Dropper(width: 100, height: 200)
    var serviceLists:[ServiceList]!
    var categoryList:CategoryList!
    var statusString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusTextField.text = "Enabled"
        categoryName.text = categoryList.name
        self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        showAnimate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateStatusButton(sender: AnyObject) {
        
        if dropper.status == .Hidden {
            dropper.tag = 1
            dropper.items = ["Enabled" , "Disabled"]
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 2
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: statusButton)
        } else {
            dropper.hideWithAnimation(0.1)
        }
        
    }
    
    @IBAction func updateButton(sender: AnyObject) {
//        let cell = sender.superview?.superview as! VendorCategorySubListTableViewCell
//        let indexPath = vendorCategoryTableview.indexPathForCell(cell)
        
        let params:[String:AnyObject] = [
            "token":token,
            "device_id":"1234",
            "parent_id":categoryList.parent_id,
            "category_name":categoryName.text!,
            "category_id":categoryList.category_id,
            "sort_order":"0",
            "status":statusString,
            "image":""
        ]
        
        print(params)
        
        ServerManager.sharedInstance().vendorEditcategory(params) { (isSuccessful, error, result) in
            if isSuccessful {
                
            }else{
                self.hideHud()
            }
        }
        removeAnimate()
    }

    
    @IBAction func cancelButton(sender: AnyObject) {
        removeAnimate()
    }
    
    
    @IBAction func deleteButton(sender: AnyObject) {
        
//        let cell = sender.superview?.superview as! VendorCategorySubListTableViewCell
//        let indexPath = vendorCategoryTableview.indexPathForCell(cell)
        
        let params = [
            "token":token,
            "device_id":"1234",
            "category_id":categoryList.category_id,
            ]
        
        print(params)
        
        ServerManager.sharedInstance().vendorDeletCategory(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
        removeAnimate()
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
    
    func DropperSelectedRow(path: NSIndexPath, contents: String) {
        statusTextField.text = contents
        if contents == "Enabled" {
           statusString = "1"
        }else{
            statusString = "0"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
