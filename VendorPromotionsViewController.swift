//
//  VendorPromotionsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorPromotionsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var vendorPromotionTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
                
            }
        }
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("promotioncellIdentifier") as! VendorPromotionTableViewCell
        
        
        
        return cell
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
