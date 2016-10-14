//
//  VendorCategoryListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Dropper

class VendorCategoryListViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource , DropperDelegate{

    let dropper = Dropper(width: 164, height: 100)
    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var vendorCategoryTableview: UITableView!
    
    var categoryLists = [CategoryList]()
    var categoryList = CategoryList()
    var serviceLists = [ServiceList]()
    var parentArray = [CategoryList]()
    var childArray = [CategoryList]()
    var subChildArray = [CategoryList]()
    var subSubChildArray = [CategoryList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuShow(slideMenuButton, viewcontroller: self)
        tokenCheck()
        let nib1 = UINib(nibName: "VendorCategoryListTableViewCell", bundle: nil)
        self.vendorCategoryTableview.registerNib(nib1, forCellReuseIdentifier: "categoryListIdentifier")
        let nib2 = UINib(nibName: "VendorCategorySubListTableViewCell", bundle: nil)
        self.vendorCategoryTableview.registerNib(nib2, forCellReuseIdentifier: "categorysubListIdentifier")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.showHud("Loading...")
        
        let params = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().vendorsCategoryList(params) { (isSuccessful, error, result , result1) in
            self.hideHud()
            self.categoryLists = result!
            self.serviceLists = result1!
            
            self.parentArray = self.categoryLists.filter({
                if $0.level == "0" {
                    return true
                }
                return false
            })

            self.childArray = self.categoryLists.filter({
                if $0.level == "1" {
                    return true
                }
                return false
            })

            self.vendorCategoryTableview.delegate = self
            self.vendorCategoryTableview.dataSource = self
            self.vendorCategoryTableview.reloadData()
        }
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return self.parentArray.count
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        self.subChildArray = childArray.filter({
//            if (parentArray[section].category_id == $0.parent_id) {
//                return true
//            }
//            return false
//        })
//        
//        var sectionItems = self.parentArray[Int(section)]
//        let numberOfRows = subChildArray.count
//        // For second level section headers
////        for rowItems in sectionItems {
////            numberOfRows += rowItems.count
////            // For actual table rows
////        }
//        return numberOfRows
//    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return parentArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        subChildArray = childArray.filter({
            if (parentArray[section].category_id == $0.parent_id) {
                return true
            }
            
//            if $0.isglobel == "0" {
//                return true
//            }
            
            return false
        })
        
        subSubChildArray = childArray.filter({
            if $0.isglobel == "0" {
                return true
            }
            return false
        })
        
        return subChildArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categorysubListIdentifier") as! VendorCategorySubListTableViewCell
        
        subChildArray = childArray.filter({
            if (parentArray[indexPath.section].category_id == $0.parent_id) {
                return true
            }
            
//            if $0.isglobel == "0" {
//                return true
//            }
            
            return false
        })
        
        
        cell.cellClickedButton.tag = indexPath.row
        cell.cellClickedButton.addTarget(self, action: #selector(VendorCategoryListViewController.cellClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        if subChildArray.count > 0 {
            let filterArr = subChildArray[indexPath.row]
            if filterArr.isglobel == "0" {
                 cell.globalEditButton.userInteractionEnabled = true
                cell.globalEditButton.addTarget(self, action: #selector(VendorCategoryListViewController.localEditButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                cell.deleteButton.addTarget(self, action: #selector(VendorCategoryListViewController.localDeleteButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                cell.globalEditButton.setImage(UIImage(named: "v_ic_edit_cat"), forState: .Normal)
                cell.productName.textColor = UIColor.blueColor()
            }else{
                 cell.globalEditButton.userInteractionEnabled = false
                cell.globalEditButton.setImage(UIImage(named: "v_ic_globe"), forState: .Normal)
                cell.productName.textColor = UIColor.redColor()
            }
           
            cell.productName?.text = filterArr.name
            
        }
        
        return cell
  
    }
    
   // Mark : - Custom Actions
    
    func localEditButtonClicked(sender:UIButton) {
        
        
        
        let params = [
            "token":token,
            "device_id":"1234",
            "parent_id":"",
            "category_name":"",
            "category_id":"",
            "sort_order":"0",
            "status":"",
            "image":""
            ]
        
        ServerManager.sharedInstance().vendorEditcategory(params) { (isSuccessful, error, result) in
            if isSuccessful {
                
            }else{
                self.hideHud()
            }
            
        }
    }
    
    func globalEditButtonClicked(sender:UIButton) {
        
        let params = [
            "token":token,
            "device_id":"1234",
            "parent_id":"",
            "category_name":"",
            "category_id":"",
            "sort_order":"0",
            "status":"",
            "image":""
        ]
        
        ServerManager.sharedInstance().vendorEditcategory(params) { (isSuccessful, error, result) in
            if isSuccessful {
                
            }else{
                self.hideHud()
            }
            
        }
    }
    
    func localDeleteButtonClicked(sender:UIButton) {
        
        let params = [
            "token":token,
            "device_id":"1234",
            "category_id":""
        ]
        
        ServerManager.sharedInstance().vendorDeletCategory(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    
    func globalDeleteButtonClicked(sender:UIButton) {
        let params = [
            "token":token,
            "device_id":"1234",
            "category_id":""
            ]
        
        ServerManager.sharedInstance().vendorDeletCategory(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
      {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryListIdentifier") as! VendorCategoryListTableViewCell
        
        if parentArray.count > 0 {
            let filterArr = parentArray[section]
            if filterArr.isglobel == "0" {
                 cell.globalEditbutton.userInteractionEnabled = true
                cell.globalEditbutton.addTarget(self, action: #selector(VendorCategoryListViewController.globalEditButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                 cell.deleteButton.addTarget(self, action: #selector(VendorCategoryListViewController.globalDeleteButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                cell.globalEditbutton.setImage(UIImage(named: "v_ic_edit_cat"), forState: .Normal)
                cell.productName.textColor = UIColor.blueColor()
            }else{
                 cell.globalEditbutton.userInteractionEnabled = false
                cell.globalEditbutton.setImage(UIImage(named: "v_ic_globe"), forState: .Normal)
                cell.productName.textColor = UIColor.redColor()
            }
            cell.productName.text = parentArray[section].name
            cell.productName.textColor = UIColor.blackColor()
        } else {
            print("No objects")
        }
        
        cell.cellClickedButton.tag = section
        cell.cellClickedButton.addTarget(self, action: #selector(VendorCategoryListViewController.cellClicked1(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func cellClicked(sender:UIButton) {
        
        let cell = sender.superview?.superview as! VendorCategorySubListTableViewCell
        let indexPath = vendorCategoryTableview.indexPathForCell(cell)
        
        subChildArray = childArray.filter({
            if (parentArray[indexPath!.section].category_id == $0.parent_id) {
                return true
            }
            return false
        })
        
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("categorySubID") as! VendorCategorySubViewController
        popOverVC.serviceLists = self.serviceLists
        popOverVC.categoryList = self.subChildArray[(indexPath?.row)!]
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
    }
    
    func cellClicked1(sender:UIButton) {
        let section = sender.tag
        let cell = sender.superview?.superview as! VendorCategoryListTableViewCell
        let indexPath = vendorCategoryTableview.indexPathForCell(cell)
        print(cell)
        print(indexPath)
        
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("categorySubID") as! VendorCategorySubViewController
        popOverVC.serviceLists = self.serviceLists
        popOverVC.categoryList = self.parentArray[section]
        self.addChildViewController(popOverVC)
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
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var sectionItems = self.sections[Int(indexPath.section)]
//        var sectionHeaders = self.sectionHeaders[Int(indexPath.section)]
//        var itemAndSubsectionIndex = self.computeItemAndSubsectionIndex(for: indexPath)
//        var subsectionIndex = Int(itemAndSubsectionIndex.section)
//        var itemIndex = itemAndSubsectionIndex.row
//        if itemIndex < 0 {
//            // Section header
//            var cell = tableView.dequeueReusableCell(withIdentifier: "SECTION_HEADER_CELL", forIndexPath: indexPath)
//            cell.textLabel!.text! = sectionHeaders[subsectionIndex]
//            return cell
//        }
//        else {
//            // Row Item
//            var cell = tableView.dequeueReusableCell(withIdentifier: "ROW_CONTENT_CELL", forIndexPath: indexPath)
//            cell.textLabel!.text! = sectionItems[subsectionIndex][itemIndex]
//            return cell
//        }
//    }
//    
//   
//        
//        func computeItemAndSubsectionIndex(for indexPath: NSIndexPath) -> NSIndexPath {
//            var sectionItems = self.subChildArray[Int(indexPath.section)]
//            var itemIndex = indexPath.row
//            var subsectionIndex = 0
//            for i in 0..<subChildArray.count {
//                // First row for each section item is header
//                itemIndex -= 1
//                // Check if the item index is within this subsection's items
//                var subsectionItems = subChildArray[i]
//                if itemIndex < Int(subsu.count) {
//                    subsectionIndex = i
//                }
//                else {
//                    itemIndex -= subsectionItems.count
//                }
//            }
//            return NSIndexPath(forRow: itemIndex, inSection: subsectionIndex)
//        }
    


}
