//
//  SelectSevicesViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 19/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class SelectSevicesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var selectServicesTableView: UITableView!
    var vendorServices = [VendorService]()
    var vendorService = VendorService()
    var getProductCollectionList = [ProductCollectionList]()
    let radiobutoonControler = SSRadioButtonsController()
    var str = ""
    var selectIndexpath = NSIndexPath()
    
    @IBOutlet weak var selectServiceHeightContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    NSNotificationCenter.defaultCenter().postNotificationName("disableCategoryNavigation1", object: nil)
        if let data1 = NSUserDefaults.standardUserDefaults().objectForKey("indexKey") as? NSData{
           selectIndexpath = NSKeyedUnarchiver.unarchiveObjectWithData(data1) as! NSIndexPath
        }

       self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
       let nibName = UINib(nibName: "SelectServicesTableViewCell", bundle:nil)
       self.selectServicesTableView.registerNib(nibName, forCellReuseIdentifier: "servicesCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
       
        // Dispose of any resources that can be recreated.
    }

//    override func viewDidAppear(animated: Bool) {
//        selectServicesTableView.frame = CGRectMake(0 , 0, 219, selectServicesTableView.contentSize.height)
//
//    }
    
    
//    override func viewDidLayoutSubviews(){
//        selectServicesTableView.frame = CGRectMake(0 , 0, 219, selectServicesTableView.contentSize.height)
//        selectServicesTableView.reloadData()
//    }
    
    
//    override func updateViewConstraints() {
//        super.updateViewConstraints()
//        selectServiceHeightContraint.constant = selectServicesTableView.contentSize.height
//    }
    
    override func viewDidAppear(animated: Bool) {
        showAnimate()
    }

    override func viewWillAppear(animated: Bool) {
        
        self.showHud("Loading...")
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().getVendorServices(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
                self.vendorServices = result!
                self.selectServicesTableView.delegate = self
                self.selectServicesTableView.dataSource = self
                self.selectServicesTableView.reloadData()
            }else{
                self.hideHud()
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vendorServices.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("servicesCell") as! SelectServicesTableViewCell
        
        cell.vendorService = self.vendorServices[indexPath.row]
        cell.serviceRadioButton.tag = indexPath.row
       
        dispatch_async(dispatch_get_main_queue()) {
            
            var newHeight: CGFloat = self.selectServicesTableView.contentSize.height
            let screenHeightPermissible: CGFloat = (self.view.bounds.size.height - self.selectServicesTableView.frame.origin.y - 50)
            if newHeight > screenHeightPermissible {
                //so that table view remains scrollable when 'newHeight'  exceeds the screen bounds
                newHeight = screenHeightPermissible
            }
            var frame = self.selectServicesTableView.frame
            frame.size.height = newHeight + 10
            self.selectServicesTableView.frame = frame
            
//            var frame = self.selectServicesTableView.frame;
//            frame.size.height = self.selectServicesTableView.contentSize.height + 10;
//            self.selectServicesTableView.frame = frame
        }
//        let cell = selectServicesTableView.cellForRowAtIndexPath(selectIndexpath) as! SelectServicesTableViewCell
//        
//        cell.serviceRadioButton.selected = true
        
        _ = SSRadioButtonsController(buttons: cell.serviceRadioButton)
        
        cell.serviceRadioButton.addTarget(self, action: #selector(SelectSevicesViewController.radioButtonClicked(_:)), forControlEvents: .TouchUpInside)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     // self.vendorService = self.vendorServices[indexPath.row]
        
        let cell = selectServicesTableView.cellForRowAtIndexPath(indexPath) as! SelectServicesTableViewCell
        
        cell.serviceRadioButton.selected = true
        
//        NSUserDefaults.standardUserDefaults().setObject(indexPath , forKey: "radioButtonPath")

        let data = NSKeyedArchiver.archivedDataWithRootObject(indexPath)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "indexKey")
        
//      let cell = selectServicesTableView.cellForRowAtIndexPath(indexPath) as!
//        let params = [
//            "token":token,
//            "product_name":"",
//            "limit":"25",
//            "page":"1",
//            "device_id":"1234",
//            "global":"0",
//            "service":self.vendorServices[indexPath.row].id
//        ]
//
//        let params1 = [
//            "token":token,
//            "product_name":"",
//            "limit":"25",
//            "page":"1",
//            "device_id":"1234",
//            "global":"1",
//            "service":self.vendorServices[indexPath.row].id
//        ]
        
        let serviceString = self.vendorServices[indexPath.row].id
        let serviceString1 = self.vendorServices[indexPath.row].id
        
        NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: serviceString)
        NSNotificationCenter.defaultCenter().postNotificationName("refresh1", object: serviceString1)
        
//        ServerManager.sharedInstance().vendorMyProductsList(params) { (isSuccessful, error, result , result1) in
//            if isSuccessful {
//                self.getProductCollectionList = result!
//                self.selectServicesTableView.delegate = self
//                self.selectServicesTableView.dataSource = self
//                self.selectServicesTableView.reloadData()
//                self.removeAnimate()
//            }
//        }
        self.removeAnimate()
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func radioButtonClicked(sender:UIButton)  {
        let cell = sender.superview?.superview as! SelectServicesTableViewCell
        let indexPath = selectServicesTableView.indexPathForCell(cell)
//        let params = [
//            "token":token,
//            "product_name":"",
//            "limit":"25",
//            "page":"1",
//            "device_id":"1234",
//            "global":"0",
//            "service":self.vesndorServices[indexPath!.row].id
//        ]
//        
//        let params1 = [
//            "token":token,
//            "product_name":"",
//            "limit":"25",
//            "page":"1",
//            "device_id":"1234",
//            "global":"1",
//            "service":self.vendorServices[indexPath!.row].id
//        ]
        
        let serviceString = self.vendorServices[indexPath!.row].id
        let serviceString1 = self.vendorServices[indexPath!.row].id
        
        NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: serviceString)
        NSNotificationCenter.defaultCenter().postNotificationName("refresh1", object: serviceString1)
        
        self.removeAnimate()
        
//    you need to add an observer at your view controller                   vvv you need to add ":" here to pass the NSNotification object
     
//        ServerManager.sharedInstance().vendorMyProductsList(params) { (isSuccessful, error, result , result1) in
//            if isSuccessful {
//                self.getProductCollectionList = result!
//                self.selectServicesTableView.delegate = self
//                self.selectServicesTableView.dataSource = self
//                self.selectServicesTableView.reloadData()
//                self.removeAnimate()
//            }
//        }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
 

}
