//
//  OrderStatusViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 06/10/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class OrderStatusViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

   
    @IBOutlet weak var orderStatusTableView: UITableView!
    var customerDetails = CustomerOrderDetails()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.orderStatusTableView.delegate = self
        self.orderStatusTableView.dataSource = self
        self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        self.showAnimate()
        let nib1 = UINib(nibName: "OrderStatusTableViewCell", bundle: nil)
        self.orderStatusTableView.registerNib(nib1, forCellReuseIdentifier: "orderStatusIdentifier")
        let nib2 = UINib(nibName: "OrderDetailHeaderTableViewCell", bundle: nil)
        self.orderStatusTableView.registerNib(nib2, forCellReuseIdentifier: "orderDetailHeader")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customerDetails.orderStatuses.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("orderStatusIdentifier") as! OrderStatusTableViewCell
             cell.statusLabel.text = customerDetails.orderStatuses[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let header = tableView.dequeueReusableCellWithIdentifier("orderDetailHeader") as! OrderDetailHeaderTableViewCell
        switch section {
        case 0:
            header.headerName.text = "Select Order Status"
        default:
            print("No More Sections")
        }
        return header
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  
        let params = [
            "order_status_id":customerDetails.orderStatuses[indexPath.row].orderStatusId,
            "order_id":customerDetails.order_id,
            "suborder_id":customerDetails.suborder_id,
            "device_id":"1234",
            "token":token,
            ]
        
        print(params)
        
        ServerManager.sharedInstance().overallOrderStatusChange(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.navigationController?.popToRootViewControllerAnimated(true)
               self.removeAnimate()
            }else{
                
            }
        }
        
        
       
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    func overallOrderStatus(statusId:String) {
        
   
        
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
