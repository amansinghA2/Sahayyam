//
//  CustomerDropDownViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 05/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CustomerDropDownViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var dropDownTableView: UITableView!
    var menuArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

   tokenCheck()
        
        let nibName = UINib(nibName: "CustomerDropDownTableViewCell", bundle:nil)
        self.dropDownTableView.registerNib(nibName, forCellReuseIdentifier: "dropDownCell")
        
        menuArray = ["Wishlist" , "Promotion" , "Switch Profile" , "Track Order" , "Update Profile" , "Logout" , "About Us"]

        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(dismissPopOver),
            name: "DismissPopOverNotification",
            object: nil)

        // Do any additional setup after loading the view.
    }

    func dismissPopOver() {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {

      self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(animated: Bool) {

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dropDownCell") as! CustomerDropDownTableViewCell
        
        cell.listLabel.text = menuArray[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        switch indexPath.row {
            case 0:
                self.dropDownTableView.hidden = true
                    self.performSegueWithIdentifier("wishListSegue", sender: nil)
            case 1:
                        performSegueWithIdentifier("bestDealsSegue", sender: nil)
            case 2
                :
//                let sb = UIStoryboard(name: "Main", bundle: nil)
//                let vc1 = sb.instantiateViewControllerWithIdentifier("SwitchUVController") as! SwitchUserViewController
//                self.presentViewController(vc1, animated: true, completion:
//                    nil)
                        performSegueWithIdentifier("switchProfileSegue", sender: nil)
            case 3:
                        performSegueWithIdentifier("trackOrdersSegue", sender: nil)
            case 4:
                        performSegueWithIdentifier("updateProfileSegue", sender: nil)
            case 5:
                        viewControllerPassingAndLogout("Main")
            case 6:
                        performSegueWithIdentifier("aboutUsSegue", sender: self)
            default:
                        print("Nothing")
        }

    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: - Custom Functions
    
    func viewControllerPassingAndLogout(storyBoard:String) {
        
        let params = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().loginLogout(params) { (isSuccessful, error, result) in
            if isSuccessful {
            
            }
            let sb = UIStoryboard(name: storyBoard, bundle: nil)
            let vc1 = sb.instantiateInitialViewController()! as UIViewController
            self.presentViewController(vc1, animated: true, completion:
                nil)
        }
        
    }
    
    
    //  MARK: - Navigation

    //  In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "updateProfileSegue" {
            let nav = segue.destinationViewController as! UINavigationController
            let vc = nav.topViewController as! CustomerUpdateProfileViewController
            vc.isLogin = "customerDropDown"
//
//            ServerManager.sharedInstance().customerUpdateProfilePopulateData(nil, completionClosure: {(isSuccessful, error, result) in
//                if isSuccessful{
//                  vc.populateDataList  = result
//                    self.hideHud()
//                }
//                
//            })
        }
    }

}
