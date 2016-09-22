//
//  SubscriptionDetailsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SubscriptionDetailsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var subscriptionDetailsTableView: UITableView!
    
    var subscriptionList = SubscriptionList()
    var subscriptionLists = [SubscriptionList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuShow(slideMenuButton, viewcontroller: self)
        tokenCheck()
        let nib1 = UINib(nibName: "SubscriptionDetailsTableViewCell", bundle: nil)
        self.subscriptionDetailsTableView.registerNib(nib1, forCellReuseIdentifier: "subscriptionDetailsIdentifier")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let params = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().getVendorSubscription(params) { (isSuccessful, error, result, dict) in
        if isSuccessful{
            self.subscriptionLists = result!
            self.subscriptionDetailsTableView.delegate = self
            self.subscriptionDetailsTableView.dataSource = self
            self.subscriptionDetailsTableView.reloadData()
        }
      }
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subscriptionLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:SubscriptionDetailsTableViewCell = tableView.dequeueReusableCellWithIdentifier("subscriptionDetailsIdentifier") as! SubscriptionDetailsTableViewCell
        cell.subscriptionList = subscriptionLists[indexPath.row]
        
        return cell
    }

    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
