//
//  SubsPaymentViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 23/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SubsPaymentViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var subsTableView: UITableView!
    
    var subsDetails = [CHVendorSubsList]()
    var customerId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SubsPaymentTableViewCell", bundle: nil)
        self.subsTableView.registerNib(nib, forCellReuseIdentifier: "subPaymentIdentifier")
        
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
        
        ServerManager.sharedInstance().chVendorListForSbbscription(params) { (isSuccessful, error, result, dictResult) in
            if isSuccessful {
                self.subsDetails = result!
                self.subsTableView.delegate = self
                self.subsTableView.dataSource = self
                self.subsTableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subsDetails.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("subPaymentIdentifier") as! SubsPaymentTableViewCell
        
        cell.subsLabel.text = self.subsDetails[indexPath.row].firstname + " " + self.subsDetails[indexPath.row].lastname
        
        cell.subsPaymentButton.addTarget(self, action: #selector(SubsPaymentViewController.subsButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
       return cell
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
        }
    }

}
