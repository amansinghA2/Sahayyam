//
//  CustomerAboutUsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerAboutUsViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var vendorNumber: UILabel!
    @IBOutlet weak var mailIdLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    var vendorInfos = [VendorInfoAboutUs]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setBackButtonForNavigation()
        let params = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().customerAboutus(params) { (isSuccessful, error, result) in
            if isSuccessful {
              self.vendorInfos = result!
               self.bindModelToViews()
            }
        }
        
        
      
     
//        versionLabel.text = String(NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleVersion"))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bindModelToViews() {
        
        for vendorInfo in vendorInfos {
            
            if let address = vendorInfo.address + vendorInfo.address1 as? String{
                locationLabel.text = address
            }
            
            if let phone = vendorInfo.telephone as? String{
                vendorNumber.text = phone
            }
            
            if let address = vendorInfo.emailId as? String{
                mailIdLabel.text = address
            }
            
//            if let address = vendorInfo. as? String{
//                locationLabel.text = address
//            }
            
            vendorName.text = defaultVendorName
            
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
