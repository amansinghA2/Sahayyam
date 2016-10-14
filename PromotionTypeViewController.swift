//
//  PromotionTypeViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import M13Checkbox

class PromotionTypeViewController: UIViewController , SSRadioButtonControllerDelegate{


    var vendorPromotionList:VendorPromotionList!

    @IBOutlet weak var productnameQuantityConstraint: NSLayoutConstraint!
    @IBOutlet weak var discounttypeConstraint: NSLayoutConstraint!

    @IBOutlet weak var nameAndQuantityView: UIView!
    @IBOutlet weak var typeandValueView: UIView!

    @IBOutlet weak var amountpromotionOutlet: M13Checkbox!
    @IBOutlet weak var productPromotionOutlet: M13Checkbox!

    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var desciptionLabel: TextField!
    @IBOutlet weak var amountLabel: TextField!

    @IBOutlet weak var fromLabel: TextField!
    @IBOutlet weak var toLabel: TextField!

    @IBOutlet weak var discountValue: TextField!

    @IBOutlet weak var percentageRadioButton: SSRadioButton!
    @IBOutlet weak var amountRadioButton: SSRadioButton!

    @IBOutlet weak var productName: TextField!
    @IBOutlet weak var quantityLabel: TextField!
    @IBOutlet weak var unitDropDownButton: UIButton!
    var isCheck = false
    var str = ""
    var radioButtonController = SSRadioButtonsController()
    var discountType = String()
    
    override func viewDidLoad() {
       super.viewDidLoad()
        tokenCheck()
        
        fromLabel.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        toLabel.setTextFieldStyle(TextFieldStyle.TextFieldDOB)
        radioButtonController.setButtonsArray([amountRadioButton!,percentageRadioButton!])
        radioButtonController.delegate = self
        radioButtonController.shouldLetDeSelect = true

        if str == "fromEdit"{
            self.amountpromotionOutlet.checkState = .Checked
            productnameQuantityConstraint.constant  = 0
            nameAndQuantityView.hidden = true
            bindModelToViews()
        }else{
            productnameQuantityConstraint.constant  = 0
            nameAndQuantityView.hidden = true
            discounttypeConstraint.constant = 0
            typeandValueView.hidden = true
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createPromotion(sender: AnyObject) {

         if str == "fromEdit"{
            let params:[String:AnyObject] = [
                "product[name]":nameTextField.text!,
                "product[productQuantity]":quantityLabel.text!,
                "product[image]":"",
                "product[amount]":amountLabel.text!,
                "product[productUnitId]":"",
                "product[fromDate]":fromLabel.text!,
                "product[endDate]":toLabel.text!,
                "product[productDiscountType]":discountType,
                "product[amtDiscountType]":"",
                "product[productId]":"",
                "token":token,
                "device_id":"1234"
            ]
            
            ServerManager.sharedInstance().editPromotion(params) { (isSuccessful, error, result) in
                if isSuccessful{
                    
                }
            }
         }else{
            let params:[String:AnyObject] = [
                "product[name]":nameTextField.text!,
                "product[productQuantity]":quantityLabel.text!,
                "product[image]":"",
                "product[amount]":amountLabel.text!,
                "product[productUnitId]":"",
                "product[fromDate]":fromLabel.text!,
                "product[endDate]":toLabel.text!,
                "product[productDiscountType]":discountType,
                "product[amtDiscountType]":"",
                "product[productId]":"",
                "token":token,
                "device_id":"1234"
            ]
            
            ServerManager.sharedInstance().addPromotion(params) { (isSuccessful, error, result) in
                if isSuccessful{
                    
                }
            }

        }
        
        
    }

    func bindModelToViews() {

        if let name = vendorPromotionList.name as? String{
            nameTextField.text = name
        }

        if let name = vendorPromotionList.price as? String{
            amountLabel.text = name
        }

        if vendorPromotionList.discount != "" {
            if let name = vendorPromotionList.discount as? String{
                discountValue.text = name
            }
        }

        if let name = vendorPromotionList.start_date_added as? String{
            fromLabel.text =  name
        }

        if let name = vendorPromotionList.end_date_added as? String{
            toLabel.text =  name
        }

        if let name = vendorPromotionList.promotionDescription as? String{
            desciptionLabel.text =  name
        }

        if let name = vendorPromotionList.quantity as? String{
            quantityLabel.text = name
        }
        if let name = vendorPromotionList.promo_name as? String{
            productName.text =  name
        }

    }

    @IBAction func amountPromotionAction(sender: AnyObject) {
        
        if self.amountpromotionOutlet.checkState == .Unchecked{
             discounttypeConstraint.constant  = 0
            typeandValueView.hidden = true
            isCheck = true
        }else{
            isCheck = false
             discounttypeConstraint.constant  = 67
            typeandValueView.hidden = false
        }
    }

    @IBAction func productDescriptionAction(sender: AnyObject) {
        
        if self.productPromotionOutlet.checkState == .Unchecked{
            productnameQuantityConstraint.constant  = 0
            nameAndQuantityView.hidden = true
            isCheck = true

        }else{
            isCheck = false
            productnameQuantityConstraint.constant  = 106
            nameAndQuantityView.hidden = false
        }

    }

    func didSelectButton(aButton: UIButton?) {
        if aButton == percentageRadioButton {
            discountType = "P"
        }else{
            discountType = ""
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
