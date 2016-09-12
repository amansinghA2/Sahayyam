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
    var trackLoadData = CustomerOrders()
   // var orderDetailsList = CustomerOrderDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showHud("Loading...")
        self.orderDetailsTableView.delegate = self
        self.orderDetailsTableView.dataSource = self
        
        tokenCheck()
        setUpView()
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
            return 4
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
            cell.orderNoLabel.text = "asd"
            cell.dateLabel.text = "asda"
            cell.paymentLabel.text = "asdasd"
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("customerDetailsIdentifier") as! CustomerDetailsTableViewCell
//            cell.addressLabel.text = self.orderDetailsList.payment_address
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("orderDetailsIdentifier") as! DetailsOrderTableViewCell
//            let orderProduct = self.orderDetailsList.orderProducts[indexPath.row]
            return cell
        case 3:
            let cell = tableView.dequeueReusableCellWithIdentifier("orderDetailsFooter") as! OrderDetailsFotterTableViewCell
//            cell.orderdetailList = self.orderDetailsList
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("orderDetailsFooter") as! OrderDetailsFotterTableViewCell
//            cell.orderdetailList = self.orderDetailsList
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
    
    
    //    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //        switch section {
    //        case 2:
    //            let footer = tableView.dequeueReusableCellWithIdentifier("orderDetailsFooter") as! OrderDetailsFotterTableViewCell
    //
    //            footer.orderdetailList = self.orderDetailsList
    //
    //            orderDetailsTableView.tableFooterView = footer
    //             return footer
    //        default:
    //            print("No more footers")
    //        }
    //        return nil
    //    }
    
    //    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        switch section {
    //        case 2:
    //            return UITableViewAutomaticDimension
    //        default:
    //            return 0
    //        }
    //    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func setUpView() {
        setBackButtonForNavigation()
        
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
//        if Reachability.isConnectedToNetwork(){
//            let params:[String : AnyObject] = [
//                "token":token,
//                "device_id":"1234",
//                "order_id": trackLoadData.order_id
//            ]
//            
//            print(params)
//            
//            ServerManager.sharedInstance().customerOrderDetails(params) { (isSuccessful, error, result) in
//                if isSuccessful {
//                    self.hideHud()
//                    self.orderDetailsList = result!
//                    self.orderDetailsTableView.delegate = self
//                    self.orderDetailsTableView.dataSource = self
//                    self.orderDetailsTableView.reloadData()
//                }
//            }
//        }
//        else{
//            self.hideHud()
//            AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
//        }
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
