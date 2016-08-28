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

    // MARK: - View Methods

    override func viewDidLoad() {
        super.viewDidLoad()
       
     tokenCheck()
     self.navigationItem.hidesBackButton = true
     setUpView()
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  }
    
    override func viewWillAppear(animated: Bool) {
        
 
    }
    
    // MARK: Actions

    @IBAction func segueButtonAction(sender: AnyObject) {

        switch sender.tag {
        case 0:
            self.custTypeString = "customer"
            self.viewControllerPassing("Customer")
        case 1:
            switch profileType{
            case 1:
                self.custTypeString = "vendor"
                self.viewControllerPassing("Vendor")
            case 2:
                self.custTypeString = "cityhead"
                self.viewControllerPassing("Vendor")
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

        ServerManager.sharedInstance().requestSwitchProfile(params) { (isSuccessful, error, result) in
            if (isSuccessful){
            }
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
//        self.changeNavigationBarColor()
//        hideBackBarButton()
        addingCustomerVendorImage()
        

    }

    func viewControllerPassing(storyBoard:String) {
        let sb = UIStoryboard(name: storyBoard, bundle: nil)
        let vc1 = sb.instantiateInitialViewController()! as UIViewController
        //       vc1.modalPresentationStyle = UIModalPresentationStyle.FullScreen
       // vc1.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
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
