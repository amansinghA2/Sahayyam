//
//  VendorsListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 16/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit


protocol DefaultVendordelegate {
    func passDefaultVendorLIst (viewcontroller:VendorsListViewController , vendorList:VendorList)
}

class VendorsListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{

    var vendorsLists = [VendorList]()
    var delegate: DefaultVendordelegate!
    
    @IBOutlet weak var vendorListTAbleView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setBackButtonForNavigation()
        self.navigationItem.hidesBackButton = true
        tokenCheck()
        
        self.showHud("Loading...")
        let nib1 = UINib(nibName: "VendorListTableViewCell", bundle: nil)
        self.vendorListTAbleView.registerNib(nib1, forCellReuseIdentifier: "vendorListIdentifier")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.showHud("Loading...")
        if Reachability.isConnectedToNetwork(){
        let params = [
            "token":token ,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().customerGetVendorsList(params) { (isSuccessful, error, result) in
            self.hideHud()
            if let results = result {
            self.vendorsLists = results
            }
            self.vendorsLists.sortInPlace() { $1.nickname > $0.nickname }
            self.vendorListTAbleView.reloadData()
            self.vendorListTAbleView.dataSource = self
            self.vendorListTAbleView.delegate = self
            self.vendorListTAbleView.reloadData()
        }
        
    }
    else{
    self.hideHud()
    AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
    }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vendorsLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vendorListIdentifier") as! VendorListTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.tag = indexPath.row

        if cell.tag == indexPath.row{
            let vendorList = self.vendorsLists[indexPath.row]
            cell.vendorList = vendorList

        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      self.delegate?.passDefaultVendorLIst(self, vendorList: self.vendorsLists[indexPath.row])
      self.toastView("Vendor update successfully changed")
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
    }
    
}