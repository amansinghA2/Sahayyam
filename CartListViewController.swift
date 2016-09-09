//
//  CartListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 08/08/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class CartListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate{

    @IBOutlet weak var cartListTableView: UITableView!
    var cartLists = [Products]()
    var cartList = Products()
    var totalsData = String()
    var refreshControl: UIRefreshControl!
    var getProductCollectionList = ProductCollectionList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(CartListViewController.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        cartListTableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }

    func refresh(sender:AnyObject) {
        
    
    }
    
    override func viewWillAppear(animated: Bool) {
      getCartLIst()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cartLists.count
        case 1:
            if cartLists.count == 0 {
                let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
                emptyLabel.text = "No Products Added to cart"
                emptyLabel.textAlignment = NSTextAlignment.Center
                self.cartListTableView.backgroundView = emptyLabel
                self.cartListTableView.separatorStyle = UITableViewCellSeparatorStyle.None
                return 0
            }else{
              return 1
            }
        default:
           return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if cartLists.count != 0 {
        cartList = cartLists[indexPath.row]
        }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("cartLIstCell") as! CartListTableViewCell
            cell.cartList = cartList
            cell.quantitytextField.delegate = self
            cell.removeButtonOutlet.tag = indexPath.row
            cell.removeButtonOutlet.addTarget(self, action: #selector(CartListViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("cartListStaticCell") as! CartListStaticTableViewCell
           cell.cartList = cartList
           cell.chekoutbuttonoutlet.tag = indexPath.row
           cell.chekoutbuttonoutlet.addTarget(self, action: #selector(CartListViewController.checkoutButtonClicked), forControlEvents: UIControlEvents.TouchUpInside)
           return cell
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func buttonClicked(sender:UIButton){
        let cell = sender.superview?.superview as! CartListTableViewCell
        let indexPath = cartListTableView.indexPathForCell(cell)
        
        if Reachability.isConnectedToNetwork(){
        let refreshAlert = UIAlertController(title: "Alert", message: "Do you want to remove data from cart", preferredStyle: UIAlertControllerStyle.Alert)
        cartList = self.cartLists[(indexPath?.row)!]
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            self.showHud("Loading...")
            let params:[String:AnyObject]? = [
                "token":token,
                "device_id":"1234",
                "key":self.cartList.key
            ]
            
            ServerManager.sharedInstance().customerRemoveFromCart(params) { (isSuccessful, error, result) in
                if isSuccessful {
                    self.getCartLIst()
                }else {
                    AlertView.alertViewWithPopup("Alert", message: error!, alertTitle: "OK", viewController: self)
                    self.hideHud()

                }
            }
            
            if self.cartLists.count == 1 {
                self.cartLists.removeAll()
                 self.cartListTableView.reloadData()
            }else{
                self.cartLists.removeAtIndex((indexPath?.row)!)
                self.cartListTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
                self.cartListTableView.reloadData()
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    else{
    self.hideHud()
    AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
    }

    }

    func checkoutButtonClicked(){
       self.performSegueWithIdentifier("checkoutSegue", sender: nil)
    }
    
    func setUp() {
        setBackButtonForNavigation()
        if Reachability.isConnectedToNetwork(){
        ServerManager.sharedInstance().checkTokenHealth(nil) { (isSuccessful, error, result) in
            if isSuccessful{
                checkTokenHealth = true
                self.hideHud()
            }else{
                AlertView.alertViewToGoToLogin("OK", message: error!, alertTitle: "OK", viewController: self)
                self.hideHud()
         
            }
        }
}
else{
             self.hideHud()
            AlertView.alertViewToGoToLogin("OK", message: "No internet connection", alertTitle: "OK", viewController: self)
           
}

        let nib = UINib(nibName: "CartListTableViewCell", bundle: nil)
        self.cartListTableView.registerNib(nib, forCellReuseIdentifier: "cartLIstCell")
        let nib1 = UINib(nibName: "CartListStaticTableViewCell", bundle: nil)
        self.cartListTableView.registerNib(nib1, forCellReuseIdentifier: "cartListStaticCell")
        }
    
    func getCartLIst() {
        
        if Reachability.isConnectedToNetwork(){
        self.showHud("Loading...")
        let params:[String:AnyObject]? = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().customerGetCartList(params) { (isSuccessful, error, result , dict) in
            if isSuccessful{
                self.hideHud()
                self.cartLists = result!
                self.cartListTableView.dataSource = self
                self.cartListTableView.delegate = self
                self.cartListTableView.reloadData()
            }else{
                self.hideHud()
                AlertView.alertViewToGoToLogin("OK", message: "No internet connection", alertTitle: "OK", viewController: self)

            }
        }
}
else{
            self.hideHud()
            AlertView.alertViewToGoToLogin("OK", message: "No internet connection", alertTitle: "OK", viewController: self)
}
    }



    func textFieldShouldReturn(textField: UITextField) -> Bool {
       if Reachability.isConnectedToNetwork(){
        let cell = textField.superview?.superview as! CartListTableViewCell
        let indexPath = cartListTableView.indexPathForCell(cell)
        
        let params1:[String:AnyObject]? = [
            "key":self.cartLists[(indexPath?.row)!].key,
            "device_id":"1234",
            "token":token,
            "quantity":Int(textField.text!)!
        ]
        
        ServerManager.sharedInstance().customerEditToCart(params1) { (isSuccessful, error, result) in
            if isSuccessful {
            self.getCartLIst()
            }else{
                    AlertView.alertViewWithPopup("Alert", message: error!, alertTitle: "OK", viewController: self)
                    self.hideHud()
            }
        }
}
else{
        self.hideHud()
        AlertView.alertViewToGoToLogin("OK", message: "No internet connection", alertTitle: "OK", viewController: self)
}

        return true
    }

    func textFieldDidEndEditing(textField: UITextField) {
        let cell = textField.superview?.superview as! CartListTableViewCell
        let indexPath = cartListTableView.indexPathForCell(cell)
           if Reachability.isConnectedToNetwork(){
        let params1:[String:AnyObject]? = [
            "key":self.cartLists[(indexPath?.row)!].key,
            "device_id":"1234",
            "token":token,
            "quantity":Int(textField.text!)!
        ]
        
        ServerManager.sharedInstance().customerEditToCart(params1) { (isSuccessful, error, result) in
            if isSuccessful {
                self.getCartLIst()
            }else{
                AlertView.alertViewWithPopup("Alert", message: error!, alertTitle: "OK", viewController: self)
                self.hideHud()
            }
        }
}
else{
            self.hideHud()
            AlertView.alertViewToGoToLogin("OK", message: "No internet connection", alertTitle: "OK", viewController: self)
}
    }


    // MARK: - Navigation

    //  In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "checkoutSegue" {
            let vc = segue.destinationViewController as! CheckoutViewController
            vc.cartList = cartList
        }
        
    }


}
