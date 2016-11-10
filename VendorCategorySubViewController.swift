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
    
    let dropper = Dropper(width: 100, height: 100)
    
    @IBOutlet weak var serviceButtonOutlet: UIButton!
    @IBOutlet weak var subCategoryTextField: UITextField!
    @IBOutlet weak var mainCategoryTextField: UITextField!
    @IBOutlet weak var mainCategoryLabel: UILabel!
    @IBOutlet weak var subCategoryLabel: UILabel!
    var categoryListIds = String()
    
    @IBOutlet weak var mainCategorycheckBox: SSRadioButton!
    @IBOutlet weak var subCategoryCheckBox: SSRadioButton!
    var categoryList = CategoryList()
    var serviceLists = [ServiceList]()
    var serviceLists1 = [VendorService]()
    var service_id = String()
    var serviceList = ServiceList()
    var radioButtonController = SSRadioButtonsController()
    var str1 = String()
    var count = Int()
    var categoryParentIDString = String()
    var categoryLists = [ProductCategoryList]()
    
    @IBOutlet weak var mainCategoryHesightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var subCtategoryHeightContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         serviceListAction("")
        if str1 == "fromCell" {
            mainCategoryTextField.text = categoryList.name
            serviceButtonOutlet.userInteractionEnabled = false
            mainCategoryHesightConstraint.constant = 0
            mainCategorycheckBox.hidden = true
            subCategoryCheckBox.hidden = false
            subCategoryCheckBox.selected = true
            mainCategoryTextField.userInteractionEnabled = false
            //autoCompleteCategoryAction(categoryList.service_id)
            serviceListAction("")
           // categoryListIds = categoryList.service_id
        }else{
            serviceButtonOutlet.userInteractionEnabled = true
            mainCategoryTextField.userInteractionEnabled = true
            subCtategoryHeightContraint.constant = 0
            subCategoryCheckBox.hidden = true
            mainCategorycheckBox.hidden = false
            mainCategorycheckBox.selected = true
            //autoCompleteCategoryAction(categoryList.service_id)
            serviceListAction("")
        }
        
        count = serviceLists.count
//        mainCategoryTextField.text = categoryList.name
        self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        showAnimate()
        radioButtonController.setButtonsArray([mainCategorycheckBox , subCategoryCheckBox])
        radioButtonController.delegate = self
        //subCategoryCheckBox.selected = true
        categoryParentIDString = categoryList.category_id
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
            dropper.spacing = 1
            dropper.cellTextSize = 12
            dropper.maxHeight = 100
            dropper.showWithAnimation(0.15, options: Dropper.Alignment.Center, button: serviceButtonOutlet)
        } else {
            dropper.hideWithAnimation(0.1)
        }

    }
    
    func DropperSelectedRow(path: NSIndexPath, contents: String, tag: Int) {
        
        mainCategoryTextField.text = "\(contents)"
        for serviceList in serviceLists1 {
            if contents == serviceList.desc {
                service_id = serviceList.id
            }
        }
//        serviceListAction(service_id)
//        autoCompleteCategoryAction(service_id)
        
//        mainCategoryTextField.text = "\(contents)"
//        for categoryList in categoryLists {
//            if contents == categoryList.name {
//                categoryListIds = categoryList.category_id
//            }
//        }
        
       // mainCategoryTextField.text = "\(contents)"
    }
    
    
    func serviceListAction(getProductDetailsServiceId:String) {
        
        let params1 = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().getVendorServices(params1) { (isSuccessful, error, result) in
            if isSuccessful {
                self.serviceLists1 = result!
//                for serviceList in self.serviceLists1 {
//                    if getProductDetailsServiceId == serviceList.id {
//                        self.mainCategoryTextField.text = serviceList.desc
//                    }
//                }
            }else{
                self.hideHud()
            }
        }
        
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
            categoryParentIDString = categoryList.category_id
            dropper.hide()
            mainCategoryLabel.text = "Main Category"
            serviceButtonOutlet.userInteractionEnabled = false
            mainCategoryTextField.text = categoryList.name
            mainCategoryTextField.userInteractionEnabled = false
            subCategoryLabel.text = "Enter Sub-category"
        }
    }
    
    @IBAction func saveButton(sender: AnyObject){
        
        if str1 == "fromCell" {
            categoryParentIDString = categoryList.category_id
            service_id = categoryList.service_id
        }else{
            categoryParentIDString = "0"
//          categoryListIds = categoryList.service_id
           // service_id = categoryList.service_id
        }

        self.showHud("Loading...")
        
        let params:[String:AnyObject] = [
        "token":token,
        "device_id":"1234",
        "parent_id":categoryParentIDString,
        "category_name":subCategoryTextField.text!,
        "service_id":service_id,
        "sort_order":"0",
        "image":""
        ]
        
        print(params)
        
        ServerManager.sharedInstance().vendorAddCategory(params) { (isSuccessful, error, result) in
            if isSuccessful{
            NSNotificationCenter.defaultCenter().postNotificationName("addMainProduct", object: nil)
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
        
        
        removeAnimate()
    }
    
    
    func autoCompleteCategoryAction(service_id:String) {
        let params = [
            "token":token,
            "device_id":"1234",
            "service_id":service_id,
            "filter_name":""
        ]
        
        ServerManager.sharedInstance().autocompleteCategoryList(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.categoryLists = result!
            }else{
                self.hideHud()
            }
        }
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
