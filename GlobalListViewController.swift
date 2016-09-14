//
//  GlobalListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class GlobalListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var globalListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        globalListTableView.delegate = self
        globalListTableView.dataSource = self
        let nib1 = UINib(nibName: "GlobalListTableViewCell", bundle: nil)
        self.globalListTableView.registerNib(nib1, forCellReuseIdentifier: "goToGlobalListCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let params = [
            "token":token,
            "product_name":"",
            "limit":"25",
            "page":"1",
            "device_id":"1234",
            "global":"1",
            "service_id":"51"
        ]
        
        ServerManager.sharedInstance().vendorMyProductsList(params) { (isSuccessful, error, result) in
            if isSuccessful {
                
            }
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("goToGlobalListCell") as! GlobalListTableViewCell
        
        cell.addButtonLabel.addTarget(self, action: #selector(GlobalListViewController.addProductAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    //MARK: - Custom Actions
    
    func addProductAction(sender:UIButton) {
        let cell = sender.superview?.superview as! GlobalListTableViewCell
        let indexPath = globalListTableView.indexPathForCell(cell)
        
        
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
