//
//  VendorPromotionsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorPromotionsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var vendorPromotionTableView: UITableView!

    var vendorPromotionsLists = [VendorPromotionList]()
    var vendorPromotionsList:VendorPromotionList!

    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuShow(slideMenuButton, viewcontroller: self)
        let nibName = UINib(nibName: "VendorPromotionTableViewCell", bundle:nil)
        self.vendorPromotionTableView.registerNib(nibName, forCellReuseIdentifier: "promotioncellIdentifier")
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
        
        ServerManager.sharedInstance().displayPromotionList(params) { (isSuccessful, error, result) in
            if isSuccessful {
              self.vendorPromotionsLists = result!
              self.vendorPromotionTableView.delegate = self
              self.vendorPromotionTableView.dataSource = self
              self.vendorPromotionTableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendorPromotionsLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("promotioncellIdentifier") as! VendorPromotionTableViewCell
        
        cell.vendorPromotionList = self.vendorPromotionsLists[indexPath.row]
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        vendorPromotionsList = self.vendorPromotionsLists[indexPath.row]
        print(self.vendorPromotionsList)
        self.performSegueWithIdentifier("goToEditPromotion", sender: nil)
    }

    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    @IBAction func createPromotionAction(sender: AnyObject) {
        self.performSegueWithIdentifier("goToCreatePromotion", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToEditPromotion" {
            let vc = segue.destinationViewController as? PromotionTypeViewController
            vc!.vendorPromotionList = self.vendorPromotionsList
            vc!.str = "fromEdit"
            print(vc!.vendorPromotionList)
        }else{

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
