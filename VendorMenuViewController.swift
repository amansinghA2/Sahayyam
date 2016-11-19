//
//  VendorMenuViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.

import UIKit

class VendorMenuViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UIGestureRecognizerDelegate {

    var listArray = []
    var listImageArray = []
    
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var menuListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       menuListTableView.delegate = self
       menuListTableView.dataSource = self
       
        let nib1 = UINib(nibName: "VendorMenuTableViewCell", bundle: nil)
        self.menuListTableView.registerNib(nib1, forCellReuseIdentifier: "menuCell")
        
        let colorTop =  UIColor(red: 255.0/255.0, green: 127.0/255.0, blue: 80.0/255.0, alpha: 1.0).CGColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 165.0/255.0, blue: 0.0/255.0, alpha: 1.0).CGColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = self.gradientView.bounds
        self.gradientView.layer.addSublayer(gradientLayer)
        self.gradientView.addSubview(vendorName)
        
        if customerType == 2 {
            listArray = ["Orders" , "Customers" , "My Products" , "Product Global List" , "New Product" , "Store Profile" ,"Promotions", "Categories" , "Subscription Details" , "Payment details" ,  "Update Vendor Profile" , "Update profile Account" , "About us" , "Logout"]
            
            listImageArray = ["v_ic_order" , "v_ic_customer" , "v_ic_products" , "v_ic_global_products" , "v_ic_new_product" , "v_ic_store_profile" , "v_ic_promotion" , "v_ic_category" , "v_ic_subscription" , "v_ic_history", "ic_personalvendoredit" , "v_ic_update" , "v_ic_store_profile", "v_ic_logout"]
        }else{
        
       listArray = ["Orders" , "Customers" , "My Products" , "Product Global List" , "New Product" , "Store Profile" ,"Promotions", "Categories" , "Subscription Details" , "Payment details" , "Switch profile" , "Update Vendor Profile" , "Update profile Account" , "About us" , "Logout"]
        
       listImageArray = ["v_ic_order" , "v_ic_customer" , "v_ic_products" , "v_ic_global_products" , "v_ic_new_product" , "v_ic_store_profile" , "v_ic_promotion" , "v_ic_category" , "v_ic_subscription" , "v_ic_history" , "ch_ic_switch_profile" , "ic_personalvendoredit" , "v_ic_update" , "v_ic_store_profile", "v_ic_logout"]
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        vendorName.text = customerFullName
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell") as! VendorMenuTableViewCell
        
        cell.listNames.text = self.listArray[indexPath.row] as? String
        cell.listImage.image = UIImage(named: self.listImageArray[indexPath.row] as! String)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        if customerType == 2 {
            switch indexPath.row {
            case 0:
            self.cellClickNavigation("Vendor" , identifier: "VendorListID")
            case 1:
            self.cellClickNavigation("Vendor" , identifier: "CustomerListID")
            case 2:
            self.cellClickNavigation("Vendor" , identifier: "MyProductsViewID")
            case 3:
            self.cellClickNavigation("Vendor" , identifier: "GlobalLIstId")
            case 4:
            self.cellClickNavigation("Vendor" , identifier: "ProductAddID")
            case 5:
            self.cellClickNavigation("Vendor" , identifier: "showStoreProfileSegue")
            case 6:
            self.cellClickNavigation("Vendor" , identifier: "vendorPromotionID")
            case 7:
            self.cellClickNavigation("Vendor" , identifier: "categoryListID")
            case 8:
            self.cellClickNavigation("Vendor" , identifier: "SubscriptionID")
            case 9:
            self.cellClickNavigation("Vendor" , identifier: "PaymentDetailsID")
            case 10:
            self.cellClickNavigation("Vendor" , identifier: "vendorEFID")
            case 11:
            let sb = UIStoryboard(name: "Vendor", bundle: nil)
            let vc1 = sb.instantiateViewControllerWithIdentifier("vendorUpdateID") as! VendorUpdateProfileViewController
            vc1.isLogin = "customerDropDown"
            let nc = UINavigationController(rootViewController: vc1)
            nc.setViewControllers([vc1], animated: true)
            nc.navigationBar.barTintColor = UIColor.orangeColor()
            self.revealViewController().setFrontViewController(nc, animated: false)
            self.revealViewController().setFrontViewPosition(FrontViewPosition.Right, animated: false)
            self.revealViewController().revealToggleAnimated(true)
            case 12:
            self.cellClickNavigation("Vendor" , identifier: "AboutUsID")
            case 13:
            alertControllerToLogout()
            default:
            print("")
        }
        }else{
        switch indexPath.row {
        case 0:
            self.cellClickNavigation("Vendor" , identifier: "VendorListID")
        case 1:
            self.cellClickNavigation("Vendor" , identifier: "CustomerListID")
        case 2:
            self.cellClickNavigation("Vendor" , identifier: "MyProductsViewID")
        case 3:
            self.cellClickNavigation("Vendor" , identifier: "GlobalLIstId")
        case 4:
            self.cellClickNavigation("Vendor" , identifier: "ProductAddID")
        case 5:
            self.cellClickNavigation("Vendor" , identifier: "showStoreProfileSegue")
        case 6:
            self.cellClickNavigation("Vendor" , identifier: "vendorPromotionID")
        case 7:
            self.cellClickNavigation("Vendor" , identifier: "categoryListID")
        case 8:
            self.cellClickNavigation("Vendor" , identifier: "SubscriptionID")
        case 9:
            self.cellClickNavigation("Vendor" , identifier: "PaymentDetailsID")
        case 10:
            self.cellClickNavigation("Main" , identifier: "SwitchUVController")
        case 11:
            self.cellClickNavigation("Vendor" , identifier: "vendorEFID")
        case 12:
            let sb = UIStoryboard(name: "Vendor", bundle: nil)
            let vc1 = sb.instantiateViewControllerWithIdentifier("vendorUpdateID") as! VendorUpdateProfileViewController
            vc1.isLogin = "customerDropDown"
            let nc = UINavigationController(rootViewController: vc1)
            nc.setViewControllers([vc1], animated: true)
            nc.navigationBar.barTintColor = UIColor.orangeColor()
            self.revealViewController().setFrontViewController(nc, animated: false)
            self.revealViewController().setFrontViewPosition(FrontViewPosition.Right, animated: false)
            self.revealViewController().revealToggleAnimated(true)
        case 13:
            self.cellClickNavigation("Vendor" , identifier: "AboutUsID")
        case 14:
            alertControllerToLogout()
        default:
            print("")
        }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func alertControllerToLogout() {
        
        let alertController = UIAlertController(title: "Alert", message: "Do You wish to logout", preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            
            self.showHud("Logging out please wait")
            let params = [
                "token":token,
                "device_id":"1234"
            ]
            
            ServerManager.sharedInstance().loginLogout(params) { (isSuccessful, error, result) in
                if isSuccessful {
                    self.hideHud()
                    self.cellClickNavigation("Main" , identifier: "LoginVC")
                }else{
                    
                }
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) in
            self.hideHud()
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    func cellClickNavigation(storyBoard:String ,identifier:String) {
        let sb = UIStoryboard(name: storyBoard, bundle: nil)
        let vc1 = sb.instantiateViewControllerWithIdentifier(identifier)
        let nc = UINavigationController(rootViewController: vc1)
        nc.setViewControllers([vc1], animated: true)
        nc.navigationBar.barTintColor = UIColor.orangeColor()
        self.revealViewController().setFrontViewController(nc, animated: false)
        self.revealViewController().setFrontViewPosition(FrontViewPosition.Right, animated: false)
        self.revealViewController().revealToggleAnimated(true)
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
