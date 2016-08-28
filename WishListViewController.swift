//
//  WishListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 05/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class WishListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var wishListTableView: UITableView!
    var getProductList:ProductCollectionList!
    var selectedIndexPath:NSIndexPath = NSIndexPath()
    var wislistList = [WishlistProductList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
        ServerManager.sharedInstance().checkTokenHealth(nil) { (isSuccessful, error, result) in
            if isSuccessful{
                
            }else{
                AlertView.alertViewToGoToLogin("Alert", message: error!, alertTitle: "OK", viewController: self)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    
    func setUp() {
     self.showHud("Loading...")
        setBackButtonForNavigation()
     
        
        let nib = UINib(nibName: "WishLIstTableViewCell", bundle: nil)
        self.wishListTableView.registerNib(nib, forCellReuseIdentifier: "wishListCell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        let params:[String:AnyObject]? = [
            "token":token,
            "device_id":"1234"
        ]
        
        
        ServerManager.sharedInstance().customerGetWishlistList(params) { (isSuccessful, error, result) in
            self.hideHud()
            if isSuccessful {
                self.wislistList = result!
                self.wishListTableView.dataSource = self
                self.wishListTableView.delegate = self
                self.wishListTableView.reloadData()
            }
        }
    }
    
   // Table View Delegates
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.wislistList.count == 0 {
            let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            emptyLabel.text = "No Products Added to wishlist"
            emptyLabel.textAlignment = NSTextAlignment.Center
            self.wishListTableView.backgroundView = emptyLabel
            self.wishListTableView.separatorStyle = UITableViewCellSeparatorStyle.None
            return 0
        }else{
        return self.wislistList.count
        }
        }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCellWithIdentifier("wishListCell") as! WishLIstTableViewCell
        
        cell.wishList = self.wislistList[indexPath.row]
        
        cell.addToCartOutlet.tag = indexPath.row
        cell.addToCartOutlet.addTarget(self, action: #selector(WishListViewController.addButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.removeButtonOutlet.tag = indexPath.row
        cell.removeButtonOutlet.addTarget(self, action: #selector(WishListViewController.removeButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)

        cell.layer.borderColor = UIColor.orangeColor().CGColor
        cell.layer.borderWidth = 1
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func addButtonClicked(sender:UIButton){
        
        
        let cell = sender.superview?.superview as! WishLIstTableViewCell
        let indexPath = wishListTableView.indexPathForCell(cell)
        
        let alertController = UIAlertController(title: "Items", message: "Quanitty to be added to cart", preferredStyle: .Alert)

        let confirmAction = UIAlertAction(title: "OK", style: .Default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                    let params:[String:AnyObject]? = [
                        "product_id": self.wislistList[indexPath!.row].product_id,
                        "device_id":"1234",
                        "token":token,
                        "quantity":Int(field.text!)!
                    ]
                
                
                    ServerManager.sharedInstance().customerAddtoWishlist(params) { (isSuccessful, error, result) in
                        print("Successfull")
            
                
            }
            }else {
                // user did not fill field
            }
    }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Number Of Items"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func removeButtonClicked(sender:UIButton){
        
        let cell = sender.superview?.superview as! WishLIstTableViewCell
        let indexPath = wishListTableView.indexPathForCell(cell)
        
        let refreshAlert = UIAlertController(title: "Alert", message: "Do you want to remove data from wislist", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            let params:[String:AnyObject]? = [
                "token":token,
                "device_id":"1234",
                "remove":self.wislistList[(indexPath?.row)!].product_id
            ]
            
            print(params)
            
            ServerManager.sharedInstance().customerRemovefromWishlist(params) { (isSuccessful, error, result) in
                if isSuccessful{
                 
                }
            }
            
           self.wislistList.removeAtIndex((indexPath?.row)!)
            self.wishListTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            
            self.wishListTableView.reloadData()
            if self.wislistList.count == 0 {
              
                self.wishListTableView.reloadData()

            }
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
        
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
