//
//  VendorOrderDetailsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorOrderDetailsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    @IBOutlet weak var orderDetailsTableView: UITableView!
    var vendorListData = CustomerOrders()
    var customerDetails = CustomerOrderDetails()
   // var orderDetailsList = CustomerOrderDetails()
    
    @IBOutlet weak var orderStatusButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showHud("Loading...")
        
        tokenCheck()
        setUpView()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.showHud("Loading...")
        let params = [
        "order_id":vendorListData.order_id,
        "device_id":"1234",
        "token":token
        ]

        ServerManager.sharedInstance().vendorOrderDetails(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
               self.customerDetails = result!
               self.orderDetailsTableView.delegate = self
               self.orderDetailsTableView.dataSource = self
               self.orderDetailsTableView.reloadData()
            }else{
                self.hideHud()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)  -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return self.customerDetails.orderProducts.count
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("oderproductDetailsIdentifier") as! OrderProductDetailsTableViewCell
            cell.orderNoLabel.text = self.customerDetails.sales_order
            cell.dateLabel.text = self.customerDetails.date_added
            cell.paymentLabel.text = self.customerDetails.payment_method
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("customerDetailsIdentifier") as! CustomerDetailsTableViewCell
            cell.addressLabel.text = self.customerDetails.payment_address
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("orderDetailsIdentifier") as! DetailsOrderTableViewCell
            let orderProduct = self.customerDetails.orderProducts[indexPath.row]
            
            switch self.customerDetails.suborder_status_id {
            case "7":
                cell.cancelOrderLabel.backgroundColor = UIColor.redColor()
                cell.cancelOrderLabel.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                cell.cancelOrderLabel.setTitle("Order Cancelled", forState: .Normal)
            default:
                ""
            }
            
            switch orderProduct.order_status {
            case "7":
                cell.cancelOrderLabel.backgroundColor = UIColor.redColor()
                cell.cancelOrderLabel.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                cell.cancelOrderLabel.setTitle("Order Cancelled", forState: .Normal)
            default:
                ""
            }
            
            cell.cancelOrderLabel.tag = indexPath.row
            cell.cancelOrderLabel.addTarget(self, action: #selector(VendorOrderDetailsViewController.cancelOrderAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            cell.vendorProducts = orderProduct
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("orderDetailsFooter") as! OrderDetailsFotterTableViewCell
            cell.vendorOrderList = self.customerDetails
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("orderDetailsFooter") as! OrderDetailsFotterTableViewCell
            cell.vendorOrderList = self.customerDetails
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("orderDetailHeader") as! OrderDetailHeaderTableViewCell
        switch section {
        case 0:
            header.headerName.text = "Order Details"
        case 1:
            header.headerName.text = "Customer Details"
        case 2:
            header.headerName.text = "Products"
        default:
            print("No More Sections")
        }
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 3:
            return 0
        default:
            print("")
        }
        return 44
    }

    func cancelOrderAction(sender:UIButton) {
        
        let alertController = UIAlertController(title: "Alert", message: "Do you want to cancel the order" , preferredStyle: .Alert)
        

        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            self.showHud("Loading...")
            
            let cell = sender.superview?.superview as! DetailsOrderTableViewCell
            let indexPath = self.orderDetailsTableView.indexPathForCell(cell)
        
            let params = [
                "token":token,
                "device_id":"1234",
                "order_id":self.customerDetails.order_id,
                "product_id":self.customerDetails.orderProducts[indexPath!.row].productId
            ]
            
            ServerManager.sharedInstance().cancelOrder(params) { (isSuccessful, error, result) in
                if isSuccessful {
                    cell.cancelOrderLabel.backgroundColor = UIColor.redColor()
                    cell.cancelOrderLabel.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                    cell.cancelOrderLabel.setTitle("Order Cancelled", forState: .Normal)
                    self.hideHud()
                }else{
                    self.hideHud()
                    AlertView.alertView("Alert", message: "Server Error", alertTitle: "OK", viewController: self)
                }
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action) in
            self.hideHud()
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func orderStatusButtonAction(sender: AnyObject) {
        
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("orderStatusId") as! OrderStatusViewController
        self.addChildViewController(popOverVC)
        popOverVC.customerDetails = self.customerDetails
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        
       // self.performSegueWithIdentifier("orderStatusSegue", sender: nil)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func setUpView() {
       // setBackButtonForNavigation()
        
        self.showHud("Loading...")
        let nib1 = UINib(nibName: "DetailsOrderTableViewCell", bundle: nil)
        self.orderDetailsTableView.registerNib(nib1, forCellReuseIdentifier: "orderDetailsIdentifier")
        let nib2 = UINib(nibName: "OrderDetailHeaderTableViewCell", bundle: nil)
        self.orderDetailsTableView.registerNib(nib2, forCellReuseIdentifier: "orderDetailHeader")
        let nib3 = UINib(nibName: "OrderDetailsFotterTableViewCell", bundle: nil)
        self.orderDetailsTableView.registerNib(nib3, forCellReuseIdentifier: "orderDetailsFooter")
        let nib4 = UINib(nibName: "OrderProductDetailsTableViewCell", bundle: nil)
        self.orderDetailsTableView.registerNib(nib4, forCellReuseIdentifier: "oderproductDetailsIdentifier")
        let nib5 = UINib(nibName: "CustomerDetailsTableViewCell", bundle: nil)
        self.orderDetailsTableView.registerNib(nib5, forCellReuseIdentifier: "customerDetailsIdentifier")

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
