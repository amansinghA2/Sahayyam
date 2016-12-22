
//
//  ProductServicesDetailViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ProductServicesDetailViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var servicesDetailTableView: UITableView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    var serviceDetails = CHServiceDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainListFunction("25", page: "1")
        
        let nib1 = UINib(nibName: "ProductServiceDetailTableViewCell", bundle: nil)
        self.servicesDetailTableView.registerNib(nib1, forCellReuseIdentifier: "serviceNameIdentifier")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serviceDetails.product_details.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("serviceNameIdentifier") as! ProductServiceDetailTableViewCell
        cell.serviceNameLabel.text = self.serviceDetails.product_details[indexPath.row].category_name
        return cell
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func mainListFunction(limit:String , page:String) {
        
        self.showHud("Loading...")
        
        let params = [
            "token":token,
            "device_id":"1234",
            "limit":limit,
            "page":page
        ]
        
        ServerManager.sharedInstance().chProductDetailsList(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.serviceDetails = result!
                if let service = self.serviceDetails.product_details[0].service_name as? String{
                    self.categoryNameLabel.text = service
                }
                self.servicesDetailTableView.delegate = self
                self.servicesDetailTableView.dataSource = self
                self.servicesDetailTableView.reloadData()
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    
    func serviceListFunction(limit:String , page:String , service_id:String) {
        
        self.showHud("Loading...")
        
        let params = [
            "token":token,
            "device_id":"1234",
            "limit":limit,
            "page":page ,
            "service_id":service_id
        ]
        
        ServerManager.sharedInstance().chProductDetailsList(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.serviceDetails = result!
                if let service = self.serviceDetails.product_details[0].service_name as? String{
                    self.categoryNameLabel.text = service
                }
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    
    @IBAction func serviceListFunction(sender: AnyObject) {

        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("SelectServicesID") as! SelectSevicesViewController
        // popOverVC.getproductCollectionList = getProductCollectionList[(indexPath?.row)!]
        self.addChildViewController(popOverVC)
        popOverVC.str = "0"
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
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
