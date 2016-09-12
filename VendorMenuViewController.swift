//
//  VendorMenuViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorMenuViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var listArray = []
    var listImageArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    listArray = ["Orders" , "Customers" , "My Products" , "Product Global List" , "New Product" , "Promotions", "Categories" , "Subscription Details" , "Payment details" , "Switch profile" , "Update Vendor Profile" , "Update profile Account" , "About us" , "Logout"]
    listImageArray = ["v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order" , "v_ic_order"]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell") as! VendorMenuTableViewCell
        
        //cell.listImage.image =
        cell.listNames.text = self.listArray[indexPath.row] as? String

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        switch indexPath.row{
        case 0:
          print("Nothing")
        default:
            print("")
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
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
