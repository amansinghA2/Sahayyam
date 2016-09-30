//
//  SwitchUserViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SwitchUserViewController: UIViewController  , UIApplicationDelegate{

    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    var customerLoginData:CustomerLoginData!
    
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    var custTypeString = String()
    var categoryLIsts = [CategoryList]()
    // MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
//    self.navigationController?.navigationBarHidden = false
    self.navigationItem.hidesBackButton = true
     setUpView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  }
    
//    override func viewWillAppear(animated: Bool) {
//        self.navigationController?.navigationBarHidden = true
//    }
//    
//    override func viewDidDisappear(animated: Bool) {
//        self.navigationController?.navigationBarHidden = false
//    }
    
    // MARK: Actions

    @IBAction func segueButtonAction(sender: AnyObject) {
        if Reachability.checkInternetConnectivity() {
        switch sender.tag {
        case 0:
          
            self.custTypeString = "customer"
            self.viewControllerPassing("Customer")
        case 1:
            switch profileType{
            case 1:
                  vendorEntry = "mutipleProfile"
                self.custTypeString = "vendor"
                self.viewControllerPassing("Vendor")
            case 2:
                 vendorEntry = "mutipleProfile"
                self.custTypeString = "cityhead"
                self.viewControllerPassing("CityHead")
            case 3:
                self.custTypeString = "cityhead"
                self.viewControllerPassing("CityHead")
            default:
                print("")
            }
        default:
            print("")
        }

        
        
        let params:[String:AnyObject]? = [
            "cust_type":custTypeString,
            "device_id":"1234",
            "token":token
        ]

        
        ServerManager.sharedInstance().requestSwitchProfile(params) { (isSuccessful, error, result , dicResult) in
            if (isSuccessful){
            self.categoryLIsts = result!
//                        if let dict = dicResult!["customer"] {
//                            if let firstname = dict["firstname"]{
//                
//                            }
//                
//                            if let firstname = dict["lastname"]{
//                
//                            }
//                
//                        }
                
                        if let dict = dicResult!["vendors"] {
                            if let firstname = dict["company"]{
                                
                            }
                            
                            if let firstname = dict["is_default"]{
                                
                            }
                        }
                
            filteredArr = CustomClass.DataFilter(self.categoryLIsts)
                
            let data = NSKeyedArchiver.archivedDataWithRootObject(filteredArr)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: "categoryLists")
              
            if let data = NSUserDefaults.standardUserDefaults().objectForKey("categoryLists") as? NSData {
                    filteredArr = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [CategoryList]
                }
              }
            }
          }
          else{
            AlertView.alertViewToGoToLogin("OK", message: "No internet connection", alertTitle: "OK", viewController: self)
              self.hideHud()
        }

    }

    //  MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "gotoSwitchUser"{
            let vc = segue.destinationViewController as? SwitchUserViewController
            vc!.customerLoginData = self.customerLoginData
        }
    }

    // MARK: - Custom Function
    
    func setUpView() {
        addingCustomerVendorImage()
    }

    func viewControllerPassing(storyBoard:String) {
        let sb = UIStoryboard(name: storyBoard, bundle: nil)
        let vc1 = sb.instantiateInitialViewController()! as UIViewController
        self.presentViewController(vc1, animated: false, completion:
            nil)
    }

    func addingCustomerVendorImage() {
            if let image = UIImage(named: "ch_ic_customer") {
            firstButton.setImage(image, forState: .Normal)
            }
        
        label1.text = "Customer"
        
            switch profileType{
            case 1:
                if let image = UIImage(named: "ch_ic_vendor") {
                    secondButton.setImage(image, forState: .Normal)
                }
                label2.text = "Vendor"
            case 2:
                if let image = UIImage(named: "ch_ic_vendor") {
                    secondButton.setImage(image, forState: .Normal)
                }
                label2.text = "CityHead"
            case 3:
                if let image = UIImage(named: "ch_ic_city_head") {
                    secondButton.setImage(image, forState: .Normal)
                }
                label2.text = "State Head"
            case 4:
                if let image = UIImage(named: "ch_ic_city_head") {
                    secondButton.setImage(image, forState: .Normal)
                }
                label2.text = "CountryHead"
            default:
                print("")
            }
    }

}
