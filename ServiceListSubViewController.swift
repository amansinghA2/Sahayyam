//
//  ServiceListSubViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 17/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class ServiceListSubViewController: UIViewController , UIGestureRecognizerDelegate , UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var selectServiceView: RoundedView!
    @IBOutlet weak var addView: RoundedView!
    @IBOutlet weak var serviceListSubTableView: UITableView!
    var serviceList = VendorServiceList()
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceListSubTableView.hidden = true
        addView.hidden = true
        selectServiceView.hidden = true
        serviceListSubTableView.allowsMultipleSelection = true
        
        let nibName = UINib(nibName: "ServiceListSubTableViewCell", bundle:nil)
        self.serviceListSubTableView.registerNib(nibName, forCellReuseIdentifier: "subServiceListSegue")
        
        let nibName1 = UINib(nibName: "ServiceLIstSubOkTableViewCell", bundle:nil)
        self.serviceListSubTableView.registerNib(nibName1, forCellReuseIdentifier: "okButtonSegue")
        
        self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
         showAnimate()
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ServiceListSubViewController.dismissKeyboard))
//        tap.delegate = self
//        view.addGestureRecognizer(tap)
        
        serviceListFunction()
        // Do any additional setup after loading the view.
    }

    func serviceListFunction() {
        self.showHud("Loading...")
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().vendorProductGetService(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.serviceListSubTableView.hidden = false
                self.addView.hidden = false
                self.selectServiceView.hidden = false
                self.serviceList = result!
                self.serviceListSubTableView.delegate = self
                self.serviceListSubTableView.dataSource = self
                self.serviceListSubTableView.reloadData()
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return serviceList.getLeftService.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("subServiceListSegue") as! ServiceListSubTableViewCell
        let selectedIndexPaths = tableView.indexPathsForSelectedRows
        let rowIsSelected = selectedIndexPaths != nil && selectedIndexPaths!.contains(indexPath)
        cell.checkBoxView.checkState = rowIsSelected ? .Checked : .Unchecked
         
         tableHeightChange()

        if self.serviceList.getLeftService.count > 0 {
            cell.serviceList = self.serviceList.getLeftService[indexPath.row]
        }
        
//        cell.checkBoxView.addTarget(self, action: #selector(ServiceListSubViewController.checkBoxSelected(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableHeightChange()
        
        let cell = serviceListSubTableView.cellForRowAtIndexPath(indexPath) as! ServiceListSubTableViewCell
       // cell.accessoryType = .Checkmark
        cell.checkBoxView.setCheckState(.Checked, animated: true)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableHeightChange()
        let cell = serviceListSubTableView.cellForRowAtIndexPath(indexPath) as! ServiceListSubTableViewCell
       // cell.accessoryType = .None
        cell.checkBoxView.setCheckState(.Unchecked, animated: true)
    }
    
//    func checkBoxSelected(hd:String){
//        
//    }
    
    func tableHeightChange() {
        dispatch_async(dispatch_get_main_queue()) {
            self.serviceListSubTableView.layer.borderColor = UIColor .grayColor().CGColor
            self.serviceListSubTableView.layer.borderWidth = 1.0
            self.serviceListSubTableView.layer.cornerRadius = 5.0
            self.serviceListSubTableView.hidden = false
            self.addView.hidden = false
            self.selectServiceView.hidden = false
            
            var newHeight: CGFloat = self.serviceListSubTableView.contentSize.height
            let screenHeightPermissible: CGFloat = (self.view.bounds.size.height - self.serviceListSubTableView.frame.origin.y - 200)
            if newHeight > screenHeightPermissible {
                //so that table view remains scrollable when 'newHeight'  exceeds the screen bounds
                newHeight = screenHeightPermissible
            }
            var frame = self.serviceListSubTableView.frame
            frame.size.height = newHeight + 10
            self.serviceListSubTableView.frame = frame
            
            self.addView.frame.origin.y = self.serviceListSubTableView.frame.origin.y + self.serviceListSubTableView.frame.size.height
            
            //            var frame = self.selectServicesTableView.frame;
            //            frame.size.height = self.selectServicesTableView.contentSize.height + 10;
            //            self.selectServicesTableView.frame = frame
        }
    }
    
    func okButtonClicked(sender:Button) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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

    @IBAction func addButtonClicked(sender: AnyObject) {
        tableHeightChange()
        if let selectedRows = serviceListSubTableView.indexPathsForSelectedRows {
          let selectedData = selectedRows.map { serviceList.getLeftService[$0.row].id }
            print(selectedData)
            
            let str = selectedData.joinWithSeparator(",")
            
            let params = [
                "token":token,
                "device_id":"1234",
                "id":str
            ]
            
            self.showHud("Loading...")
            ServerManager.sharedInstance().vendorProductAddService(params) { (isSuccessful, error, result) in
                if isSuccessful {
          NSNotificationCenter.defaultCenter().postNotificationName("showUPdatedData", object: nil)
                    self.removeAnimate()
                    self.hideHud()
                }else{
                    self.hideHud()
                }
            }
            
        }else{
            self.toastViewForTextfield("First select the option")
        }
        
        
    }
    
    @IBOutlet weak var okButton: Button!
    @IBOutlet weak var cancelAction: Button!
    
    @IBAction func caneclButtonAction(sender: AnyObject) {
        tableHeightChange()
        self.removeAnimate()
    }

}
