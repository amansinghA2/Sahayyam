//
//  VendorCategoryListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class VendorCategoryListViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var vendorCategoryTableview: UITableView!
    var categoryLists = [CategoryList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib1 = UINib(nibName: "VendorCategoryListTableViewCell", bundle: nil)
        self.vendorCategoryTableview.registerNib(nib1, forCellReuseIdentifier: "categoryListIdentifier")
        
      
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
        
        ServerManager.sharedInstance().vendorsCategoryList(params) { (isSuccessful, error, result) in
            self.categoryLists = result!
            print(self.categoryLists)
//            let arr = CustomClass.DataFilter(self.categoryLists)
//            print(arr)
        }
  
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryListIdentifier") as! VendorCategoryListTableViewCell
        
        return cell
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
