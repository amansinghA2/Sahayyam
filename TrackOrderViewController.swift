//
//  TrackOrderViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 02/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class TrackOrderViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    
    @IBOutlet weak var trackOrderTableView: UITableView!
    var trackLoadDataList = [CustomerOrders]()
    var trackLoadData:CustomerOrders = CustomerOrders()
    var selectedIndexPath = NSIndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenCheck()
        self.showHud("Loading...")
        setBackButtonForNavigation()
        
        let nib = UINib(nibName: "TrackOrderTableViewCell", bundle: nil)
        trackOrderTableView.registerNib(nib, forCellReuseIdentifier: "trackOrderCell")
            if Reachability.isConnectedToNetwork(){
                
        let params:[String:AnyObject]? = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().customerOrders(params) { (isSuccessful, error, result) in
            self.trackLoadDataList = result!
            self.trackOrderTableView.dataSource = self
            self.trackOrderTableView.delegate = self
            self.trackOrderTableView.reloadData()
            self.hideHud()
         }
     }
     else {
            self.hideHud()
            AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
      }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trackLoadDataList.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TrackOrderTableViewCell = tableView.dequeueReusableCellWithIdentifier("trackOrderCell") as! TrackOrderTableViewCell
        
        trackLoadData = self.trackLoadDataList[indexPath.row]
        cell.trackLoadData = trackLoadData
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        selectedIndexPath = indexPath
        
//      trackLoadData.products = self.trackLoadDataList[indexPath.row].products
        
        self.performSegueWithIdentifier("trackOrderDetailsSegue", sender: nil)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 
        if segue.identifier == "trackOrderDetailsSegue" {
            let vc = segue.destinationViewController as! OrderDetailsViewController
            vc.trackLoadData.order_id = self.trackLoadDataList[selectedIndexPath.row].order_id
            print("\(vc.trackLoadData.products)")
        }
        
    }
 

}
