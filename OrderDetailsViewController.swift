//
//  OrderDetailsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 12/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var orderDetailsTableView: UITableView!
    
    var trackLoadData = CustomerOrders()
    var orderDetailsList = CustomerOrderDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showHud("Loading...")
        tokenCheck()
        setUpView()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 3        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return self.orderDetailsList.orderProducts.count
        default:
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        switch indexPath.section {
        case 0:
           let cell = tableView.dequeueReusableCellWithIdentifier("oderproductDetailsIdentifier") as! OrderProductDetailsTableViewCell
           cell.orderNoLabel.text = self.orderDetailsList.sales_order
           cell.dateLabel.text = self.orderDetailsList.date_added
           cell.paymentLabel.text = self.orderDetailsList.payment_method
               return cell
            
        case 1:
           let cell = tableView.dequeueReusableCellWithIdentifier("customerDetailsIdentifier") as! CustomerDetailsTableViewCell
            cell.addressLabel.text = self.orderDetailsList.payment_address
            return cell
            
        case 2:
           let cell = tableView.dequeueReusableCellWithIdentifier("orderDetailsIdentifier") as! OrderDetailsTableViewCell
           let orderProduct = self.orderDetailsList.orderProducts[indexPath.row]
           cell.orderProducts = orderProduct
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("orderDetailsFooter") as! OrderDetailsFotterTableViewCell
            
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
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 2:
            let footer = tableView.dequeueReusableCellWithIdentifier("orderDetailsFooter") as! OrderDetailsFotterTableViewCell
            
            footer.orderdetailList = self.orderDetailsList
            
            orderDetailsTableView.tableFooterView = footer
             return footer
        default:
            print("No more footers")
        }
        return nil
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 2:
            return 120
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func setUpView() {
        setBackButtonForNavigation()
        self.showHud("Loading...")
        let nib1 = UINib(nibName: "OrderDetailsTableViewCell", bundle: nil)
        self.orderDetailsTableView.registerNib(nib1, forCellReuseIdentifier: "orderDetailsIdentifier")
        let nib2 = UINib(nibName: "OrderDetailHeaderTableViewCell", bundle: nil)
        self.orderDetailsTableView.registerNib(nib2, forCellReuseIdentifier: "orderDetailHeader")
        let nib3 = UINib(nibName: "OrderDetailsFotterTableViewCell", bundle: nil)
        self.orderDetailsTableView.registerNib(nib3, forCellReuseIdentifier: "orderDetailsFooter")
        let nib4 = UINib(nibName: "OrderProductDetailsTableViewCell", bundle: nil)
        self.orderDetailsTableView.registerNib(nib4, forCellReuseIdentifier: "oderproductDetailsIdentifier")
        let nib5 = UINib(nibName: "CustomerDetailsTableViewCell", bundle: nil)
        self.orderDetailsTableView.registerNib(nib5, forCellReuseIdentifier: "customerDetailsIdentifier")
              if Reachability.isConnectedToNetwork(){ 
        let params:[String : AnyObject] = [
        "token":token,
        "device_id":"1234",
        "order_id": trackLoadData.order_id
        ]
        
        print(params)
                
        ServerManager.sharedInstance().customerOrderDetails(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
                self.orderDetailsList = result!
                self.orderDetailsTableView.delegate = self
                self.orderDetailsTableView.dataSource = self
                self.orderDetailsTableView.reloadData()
            }
        }
    }
    else{
    self.hideHud()
    AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
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
