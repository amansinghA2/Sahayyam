//
//  VendorCategoryListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorCategoryListViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var vendorCategoryTableview: UITableView!
    var categoryLists = [CategoryList]()
    var parentArray = [CategoryList]()
    var childArray = [CategoryList]()
    var subChildArray = [CategoryList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuShow(slideMenuButton, viewcontroller: self)
        tokenCheck()
        let nib1 = UINib(nibName: "VendorCategoryListTableViewCell", bundle: nil)
        self.vendorCategoryTableview.registerNib(nib1, forCellReuseIdentifier: "categoryListIdentifier")
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
        
        ServerManager.sharedInstance().vendorsCategoryList(params) { (isSuccessful, error, result) in
            self.hideHud()
            self.categoryLists = result!
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return parentArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        subChildArray = childArray.filter({
            if (parentArray[section].category_id == $0.parent_id) {
                return true
            }
            return false
        })
        
        return subChildArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryListIdentifier") as! VendorCategoryListTableViewCell
        
        subChildArray = childArray.filter({
            if (parentArray[indexPath.section].category_id == $0.parent_id) {
                return true
            }
            return false
        })
        
        if subChildArray.count > 0 {
            let filterArr = subChildArray[indexPath.row]
            cell.productName?.text = filterArr.name
            cell.productName.textColor = UIColor.blueColor()
            cell.imageLeftConstraint.constant = 20
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
      {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryListIdentifier") as! VendorCategoryListTableViewCell
        if parentArray.count > 0 {
            cell.productName.text = parentArray[section].name
            cell.productName.textColor = UIColor.blackColor()
            cell.imageLeftConstraint.constant = 8
        } else {
            print("No objects")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
