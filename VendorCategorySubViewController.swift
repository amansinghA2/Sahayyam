//
//  VendorCategorySubViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 29/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class VendorCategorySubViewController: UIViewController , SSRadioButtonControllerDelegate , DropperDelegate{
    
    let dropper = Dropper(width: 100, height: 200)
    
    @IBOutlet weak var serviceButtonOutlet: UIButton!

    @IBOutlet weak var subCategoryTextField: UITextField!
    @IBOutlet weak var mainCategoryTextField: UITextField!
    @IBOutlet weak var mainCategoryLabel: UILabel!
    @IBOutlet weak var subCategoryLabel: UILabel!
    
    @IBOutlet weak var mainCategorycheckBox: SSRadioButton!
    @IBOutlet weak var subCategoryCheckBox: SSRadioButton!
    var categoryList = CategoryList()
    var serviceLists = [ServiceList]()
    var serviceList = ServiceList()
    var radioButtonController = SSRadioButtonsController()
    var str = String()
    var count = Int()
    var categoryParentIDString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count = serviceLists.count
        mainCategoryTextField.text = categoryList.name
        self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        showAnimate()
        radioButtonController.setButtonsArray([mainCategorycheckBox , subCategoryCheckBox])
        radioButtonController.delegate = self
        subCategoryCheckBox.selected = true
        categoryParentIDString = categoryList.parent_id
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewDidDisappear(animated: Bool) {
//
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func categoryAction(sender: AnyObject) {

//        for serviceList in serviceLists {
//          string  = "\(string.stringByAppendingString(serviceList.name))" + " , "
//            
//        }
        
       // let arr = NSArray(serviceLists as AnyObject)
        
        var serviceNameList = [String]()
        
        for serviceList in serviceLists{
            serviceNameList.append(serviceList.name)
        }
        
        if dropper.status == .Hidden {
            dropper.tag = 1
            dropper.items = serviceNameList
            dropper.theme = Dropper.Themes.White
            dropper.delegate = self
            dropper.cornerRadius = 2
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: serviceButtonOutlet)
        } else {
            dropper.hideWithAnimation(0.1)
        }

    }
    
    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {
       // categoryLabel.text = "\(contents)"
    }
    
    
    func didSelectButton(aButton: UIButton?) {
        if aButton == mainCategorycheckBox{
            categoryParentIDString = "0"
            mainCategoryLabel.text = "Service"
            serviceButtonOutlet.userInteractionEnabled = true
            mainCategoryTextField.userInteractionEnabled = true
            mainCategoryTextField.text = categoryList.serviceName
            subCategoryLabel.text = "Enter category Name"
        }else{
            categoryParentIDString = categoryList.parent_id
            dropper.hide()
            mainCategoryLabel.text = "Main Category"
            serviceButtonOutlet.userInteractionEnabled = false
            mainCategoryTextField.text = categoryList.name
            mainCategoryTextField.userInteractionEnabled = false
            subCategoryLabel.text = "Enter Sub-category"
        }
    }
    
    @IBAction func saveButton(sender: AnyObject){
        
        let params:[String:AnyObject] = [
        "token":token,
        "device_id":"1234",
        "parent_id":categoryParentIDString,
        "category_name":subCategoryTextField.text!,
        "service_id":categoryList.service_id,
        "sort_order":"0",
        "image":""
        ]
        
        print(params)
        
        ServerManager.sharedInstance().vendorAddCategory(params) { (isSuccessful, error, result) in
            if isSuccessful{
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
        
        
        removeAnimate()
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
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
    

}
