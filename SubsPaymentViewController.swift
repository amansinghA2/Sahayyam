//
//  SubsPaymentViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SubsPaymentViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate{

    @IBOutlet weak var subsTableView: UITableView!
    var searchBar = UISearchBar()
    @IBOutlet weak var subsSegmentControl: UISegmentedControl!
    var subsDetails = [CHVendorSubsList]()
    var customerId = String()
    var pendingInvoiceList = PendingInvoiceList()
    var pendingInvoiceLists = [PendingInvoiceList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        let nib = UINib(nibName: "SubsPaymentTableViewCell", bundle: nil)
        self.subsTableView.registerNib(nib, forCellReuseIdentifier: "subPaymentIdentifier")
        
        let nib1 = UINib(nibName: "PendingInvoiceTableViewCell", bundle: nil)
        self.subsTableView.registerNib(nib1, forCellReuseIdentifier: "pendingInvoiceIdentifier")
        
        setUpSubsInfo("")
        
        // Do any additional setup after loading the view.
    }

    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        searchBar.placeholder = "Enter Mobile No. or Name"
        self.navigationItem.titleView = searchBar
    }
    
    // Search Bar delegates
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        switch subsSegmentControl.selectedSegmentIndex {
        case 0:
            setUpSubsInfo(searchText)
        case 1:
            setUpVendorInvoice(searchText)
        default:
            print("")
        }
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
      
    }
    
    func setUpSubsInfo(filterName:String) {
        let params = [
            "token":token,
            "device_id":"1234",
            "filter_name":filterName
        ]
        
        ServerManager.sharedInstance().chVendorListForSbbscription(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.subsDetails = result!
                self.subsTableView.delegate = self
                self.subsTableView.dataSource = self
                self.subsTableView.reloadData()
            }
        }
    }
    
    func setUpVendorInvoice(filterName:String) {
        
       self.showHud("Loading...")
        
        let params = [
        "token":token,
        "device_id":"1234",
        "filter_name":filterName
        ]
        
       ServerManager.sharedInstance().chVendorInvoiceList(params) { (isSuccessful, error, result, dictResult) in
        if isSuccessful {
            self.pendingInvoiceLists = result!
            self.subsTableView.delegate = self
            self.subsTableView.dataSource = self
            self.subsTableView.reloadData()
            self.hideHud()
        }else{
            self.hideHud()
        }
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subsSegmentControl.selectedSegmentIndex == 0 {
         return self.subsDetails.count
        }else{
          return self.pendingInvoiceLists.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if subsSegmentControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("subPaymentIdentifier") as! SubsPaymentTableViewCell
            
            cell.subsLabel.text = self.subsDetails[indexPath.row].firstname + " " + self.subsDetails[indexPath.row].lastname
            
            cell.subsPaymentButton.addTarget(self, action: #selector(SubsPaymentViewController.subsButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("pendingInvoiceIdentifier") as! PendingInvoiceTableViewCell
            
            cell.pendingInvoiceList = self.pendingInvoiceLists[indexPath.row]
            
//            cell.subsLabel.text = self.subsDetails[indexPath.row].firstname + " " + self.subsDetails[indexPath.row].lastname
            
            cell.payOnlineButton.addTarget(self, action: #selector(SubsPaymentViewController.onlineButtontapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.payOfflineButton.addTarget(self, action: #selector(SubsPaymentViewController.offlineButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
        }
       
    }
    
    func onlineButtontapped(sender:Button) {
        let cell = sender.superview?.superview as! PendingInvoiceTableViewCell
        let indexPath = self.subsTableView.indexPathForCell(cell)
        
        pendingInvoiceList = pendingInvoiceLists[(indexPath?.row)!]
        
        self.performSegueWithIdentifier("payOnlineIdentifier", sender: nil)
        
    }
    
    func offlineButtonTapped(sender:Button) {
        let cell = sender.superview?.superview as! PendingInvoiceTableViewCell
        let indexPath = self.subsTableView.indexPathForCell(cell)
        
        pendingInvoiceList = pendingInvoiceLists[(indexPath?.row)!]
        
        self.performSegueWithIdentifier("payOfflineIdentifier", sender: nil)
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func subsButtonTapped(sender:UIButton){
        let cell = sender.superview?.superview as! SubsPaymentTableViewCell
        let indexPath = self.subsTableView.indexPathForCell(cell)
        customerId = self.subsDetails[(indexPath?.row)!].customer_id
        self.performSegueWithIdentifier("showPaymentInfoSegue", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPaymentInfoSegue" {
            let vc = segue.destinationViewController as! AddSubscriptionViewController
            vc.customerId = self.customerId
            print(self.customerId)
        }else if segue.identifier == "payOnlineIdentifier" {
            let vc = segue.destinationViewController as! PayOnlineViewController
            vc.pendingInvoiceList = self.pendingInvoiceList
        }else if segue.identifier == "payOfflineIdentifier" {
            let vc = segue.destinationViewController as! PayOfflineViewController
            vc.pendingInvoiceList = self.pendingInvoiceList
        }
    }
    
    @IBAction func subsPaymentSegmentAction(sender: AnyObject) {
        
        if subsSegmentControl.selectedSegmentIndex == 0 {
            setUpSubsInfo("")
        }else{
            setUpVendorInvoice("")
        }
        
    }

}
