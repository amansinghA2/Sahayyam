//
//  CustomerMenuItemsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

@objc
protocol CustomerMenuItemsViewControllerDelegate {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
}

class CustomerMenuItemsViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout ,UIPopoverPresentationControllerDelegate , UITextFieldDelegate , UISearchBarDelegate  , UITableViewDataSource , UITableViewDelegate , DefaultVendordelegate , SWRevealViewControllerDelegate{

    @IBOutlet weak var vendorSelectBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var vendorListTextfield: TextField!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var moreOptionButton: UIBarButtonItem!
    var fromMenuToProductPage = ""
    var delegate:CustomerMenuItemsViewControllerDelegate?
    var getProductCollectionList = [ProductCollectionList]()
    var getProductCollectionListAdd = [ProductCollectionList]()
    var getProductList:ProductCollectionList!
    var getSpecificProductList:ProductCollectionList!
    var selectedIndexPath:NSIndexPath = NSIndexPath()
    var menuArray = []
    var categoryLIsts = [CategoryList]()
    var categoryLIst = CategoryList()
    var dataSourceForSearchResult = [ProductCollectionList]()
    var searchBarActive:Bool = false
    var searchBarBoundsY:CGFloat?
    var searchBar:UISearchBar?
    var refreshControl:UIRefreshControl?
    var tableView = UITableView()
    var vendorList:VendorList!
    var favSetter = false
    var selectedCategoryLIst:CategoryList!
    var emptyLabel:UILabel!
    var page = 1
    var totalPages:Int?
    var limit = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
      }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        tableView.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    @IBAction func moreOptionAction(sender: AnyObject) {
        let view1: UIView = moreOptionButton.valueForKey("view") as! UIView
        var x : CGFloat = 0.0
        x = view1.frame.origin.x;
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.frame = CGRectMake(x-100, 24, 140, 350)
        self.tableView.layer.borderWidth = 1.0
        self.tableView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.tableView.scrollEnabled = false
        if tableView.hidden == true {
            let currentWindow = UIApplication.sharedApplication().keyWindow! as UIWindow
            currentWindow.addSubview(tableView)
            tableView.hidden = false
        }else {
          tableView.removeFromSuperview()
            tableView.hidden = true
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        getProductCollectionListAdd.removeAll()
        super.viewWillAppear(animated)
        self.showHud("Loading...")
        self.prepareUI()
        self.vendorListTextfield.text = defaultVendorName
          if Reachability.isConnectedToNetwork(){
        if fromMenuToProductPage == "goToProductsPage"{
            productFunction(selectedCategoryLIst.category_id , limit: "26" , page: "1" , filterName: "")
        }else{
            productFunction("" , limit: "26" , page: "1" , filterName: "")
        }
        
    }
    else {
            self.hideHud()
            AlertView.alertViewToGoToLogin("OK", message: "No internet connection", alertTitle: "OK", viewController: self)
       }
    }

    func productFunction(filterCategory:String , limit:String , page:String , filterName:String) {
        let customerProductsParams:[String:AnyObject]? = [
            "filter_category":filterCategory,
            "token":token,
            "device_id": "1234",
            "filter_name":"",
            "limit":limit,
            "page":page
        ]
        
        print(customerProductsParams)
        ServerManager.sharedInstance().customerProducts(customerProductsParams) { (isSuccessful, error, result , result1) in
            if isSuccessful{
                self.hideHud()
                if let totalPage = result1!["TotalPages"]{
                    self.totalPages = Int(totalPage as! String)!
                }
                self.getProductCollectionList = result!
                self.getProductCollectionListAdd += self.getProductCollectionList
                self.collectionView.dataSource = self
                self.collectionView.delegate = self
                self.collectionView.reloadData()
            }
            
//            }else{
//                AlertView.alertViewWithPopup("Alert", message: error!, alertTitle: "OK", viewController: self)
//                self.hideHud()
//            }
        }

    }

    deinit{
        self.removeObservers()
    }
    
    // MARK: actions
    func refreashControlAction(){
        self.cancelSearching()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            // stop refreshing after 2 seconds
            self.collectionView?.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    // Mark: - TableView Methods

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dropDownCell") as! CustomerDropDownTableViewCell
        cell.listLabel.text = menuArray[indexPath.row] as? String

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            self.performSegueWithIdentifier("wishListSegue", sender: nil)
        case 1:
            performSegueWithIdentifier("bestDealsSegue", sender: nil)
        case 2:
            performSegueWithIdentifier("switchProfileSegue", sender: nil)
        case 3:
            performSegueWithIdentifier("trackOrdersSegue", sender: nil)
        case 4:
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.performSegueWithIdentifier("customerUpdateSegue", sender: nil)
            }
        case 5:
            if tableView.hidden == false {
                tableView.removeFromSuperview()
                tableView.hidden = true
            }
            alertControllerToLogout()
        case 6:
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.performSegueWithIdentifier("aboutUsSegue", sender: nil)
            }
        default:
            print("Nothing")
        }

    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }

    // MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        if section == 0{
        if getProductCollectionListAdd.count == 0 {
            emptyLabel.text = "No Products"
            emptyLabel.textAlignment = NSTextAlignment.Center
            self.collectionView.backgroundView = emptyLabel
           // self.collectionView.separatorStyle = UITableViewCellSeparatorStyle.None
            return 0
        }else{
            if self.searchBarActive {
                emptyLabel.text = ""
                return self.dataSourceForSearchResult.count;
            }
            emptyLabel.text = ""
            return getProductCollectionListAdd.count
        }
        }else {
            if fromMenuToProductPage == "goToProductsPage"{
                return 0
            }else{
                return 1
            }
        }
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("menuItemIdentifier",forIndexPath: indexPath) as! CustomerMenuItemsCollectionViewCell
            cell.addToCart.tag = indexPath.row
            cell.addToCart.addTarget(self, action: #selector(CustomerMenuItemsViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            if (self.searchBarActive) {
                getProductList = self.dataSourceForSearchResult[indexPath.row]
                cell.getProductCollectionLists = getProductList
            }else{
                getProductList = self.getProductCollectionListAdd[indexPath.row]
                cell.getProductCollectionLists = getProductList
            }
            
            //        cell.contentView.frame = cell.bounds;
            //        cell.contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
            
            cell.addToWishlist.tag = indexPath.row
            cell.addToWishlist.addTarget(self, action: #selector(CustomerMenuItemsViewController.addToWishlistButtonClicked(_:)), forControlEvents:  UIControlEvents.TouchUpInside)
            return cell
        default:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("loadMoreIdentifier",forIndexPath: indexPath) as! LoadMoreCollectionViewCell
            cell.loadMoreButton.addTarget(self, action: #selector(CustomerMenuItemsViewController.loadButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        getSpecificProductList =
        getProductCollectionListAdd[indexPath.row]
       performSegueWithIdentifier("productDescSegue", sender: nil)
    }
    
    // MARK: <UICollectionViewDelegateFlowLayout>
    
    func collectionView( collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                                insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(self.searchBar!.frame.size.height, 0, 0, 0);
    }
    
    func collectionView (collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
       // let cellLeg = (collectionView.frame.size.width/2)
        if indexPath.section == 1 {
          return CGSizeMake(120,50)
        }
        return CGSizeMake(160,175)
    }

//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//    {
//        return CGSizeMake((UIScreen.mainScreen().bounds.width)/2,175); //use height whatever you wants.
//    }


    // MARK: Search Bar Delegates
    
    func filterContentForSearchText(searchText:String){
        self.dataSourceForSearchResult = self.getProductCollectionListAdd.filter({ (text:ProductCollectionList) -> Bool in
            
           // productFunction("", limit: "25", page: "1", filterName: searchText)
            
            return text.prodnName.containsString(searchText)
        })
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // user did type something, check our datasource for text that looks the same
        if searchText.characters.count > 0 {
            // search and reload data source
            self.searchBarActive    = true
            self.filterContentForSearchText(searchText)
            print(searchText)
            self.collectionView?.reloadData()
        }else{
            // if text lenght == 0
            // we will consider the searchbar is not active
            self.searchBarActive = false
            self.collectionView?.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.cancelSearching()
        self.collectionView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBarActive = true
        self.view.endEditing(true)
    }
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        if tableView.hidden == false {
            tableView.removeFromSuperview()
            tableView.hidden = true
        }
        // we used here to set self.searchBarActive = YES
        // but we'll not do that any more... it made problems
        // it's better to set self.searchBarActive = YES when user typed something
        self.searchBar!.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        // this method is being called when search btn in the keyboard tapped
        // we set searchBarActive = NO
        // but no need to reloadCollectionView
        self.searchBarActive = false
        self.searchBar!.setShowsCancelButton(false, animated: false)
    }
    
    func cancelSearching(){
        self.searchBarActive = false
        self.searchBar!.resignFirstResponder()
        self.searchBar!.text = ""
    }
    
    // MARk:-  RevealView Controler Delegate
    
    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition) {

        if position == FrontViewPosition.Left{
            self.view.userInteractionEnabled = true
            vendorSelectBarButtonItem.enabled = true
        }else{
            self.view.userInteractionEnabled = false
            vendorSelectBarButtonItem.enabled = false
        }
    }

    func revealController(revealController: SWRevealViewController!, didMoveToPosition position: FrontViewPosition) {

        if position == FrontViewPosition.Left{
            self.view.userInteractionEnabled = true
            vendorSelectBarButtonItem.enabled = true
        }else{
            self.view.userInteractionEnabled = false
            vendorSelectBarButtonItem.enabled = false
        }

    }

    // MARK: Custom Functions

    
    func loadButtonClicked(sender:UIButton) {
        
    if fromMenuToProductPage == "goToProductsPage"{
            page += 1
            if page <= totalPages{
                productFunction(selectedCategoryLIst.category_id , limit: "26" , page: "\(page)" , filterName: "")
            }else{
               
            }
    }else {
            page += 1
            if page <= totalPages{
                productFunction("", limit: "26", page: "\(page)" , filterName: "")
            }else{
               self.toastViewForTextfield("No More Products")
            }
        }
    }
    
    func setUpView(){
        tokenCheck()
        
        self.showHud("Loading...")
        slideMenuShow(menuButton, viewcontroller: self)
        self.revealViewController().delegate = self
        self.tableView.hidden = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CustomerMenuItemsViewController.PoppingController(_:)), name: "PopController", object: nil)
        let nib = UINib(nibName: "CustomerMenuItemsCollectionViewCell", bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: "menuItemIdentifier")
        self.dataSourceForSearchResult = [ProductCollectionList]()
        let nibName = UINib(nibName: "CustomerDropDownTableViewCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "dropDownCell")
        let nibName1 = UINib(nibName: "LoadMoreCollectionViewCell", bundle:nil)
        self.collectionView.registerNib(nibName1, forCellWithReuseIdentifier: "loadMoreIdentifier")
        self.changeNavigationBarColor()
        vendorListTextfield.delegate = self
        vendorListTextfield.layer.cornerRadius = 5
        vendorListTextfield.layer.masksToBounds = true
        vendorListTextfield.backgroundColor = UIColor.whiteColor()
        vendorListTextfield.rightViewMode = UITextFieldViewMode.Always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24 , height: 24))
        let image = UIImage(named:"Down Right-1")
        imageView.image = image
        vendorListTextfield.rightView = imageView
        
        menuArray = ["Wishlist" , "Promotion" , "Switch Profile" , "Track Order" , "Update Profile" , "Logout" , "About Us"]
    }
    
    func passDefaultVendorLIst (viewcontroller:VendorsListViewController , vendorList:VendorList){
           if Reachability.isConnectedToNetwork(){
        self.vendorList = vendorList

        let params = [
            "vendorRow":vendorList.vendorId,
            "token":token,
            "device_id":"1234"
        ]	
        
        print(params)
        ServerManager.sharedInstance().customerSetDefaultVendor(params) { (isSuccessful, error, result) in
            
            if isSuccessful{
            self.categoryLIsts = result!
            
            filteredArr = CustomClass.DataFilter(self.categoryLIsts)
            
            let data = NSKeyedArchiver.archivedDataWithRootObject(filteredArr)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "categoryLists")
            
            if let data = NSUserDefaults.standardUserDefaults().objectForKey("categoryLists") as? NSData {
                filteredArr = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [CategoryList]
            }

            if let vendorName = self.vendorList.nickname as? String {
                defaultVendorName = vendorName
                NSUserDefaults.standardUserDefaults().setObject(defaultVendorName, forKey: "defaultvendorName")
               }
            }
         }
      }
else{
            self.hideHud()
            AlertView.alertViewToGoToLogin("OK", message: "No internet connection", alertTitle: "OK", viewController: self)
           }

       }

    func PoppingController(notification:NSNotification){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func buttonClicked(sender:UIButton) {
        if tableView.hidden == false {
            tableView.removeFromSuperview()
            tableView.hidden = true
        }
           if Reachability.isConnectedToNetwork(){
        let alertController = UIAlertController(title: "Items", message: "Quantity to be added to cart", preferredStyle: .Alert)
        let confirmAction = UIAlertAction(title: "OK", style: .Default) { (_) in
            self.view.endEditing(true)
        if let field = alertController.textFields![0] as? UITextField {
            if field.text?.isBlank == false{
                if field.text?.isPhoneNumber == true {
                let cell = sender.superview!.superview!.superview as! CustomerMenuItemsCollectionViewCell
               let indexPath = self.collectionView.indexPathForCell(cell)!
            self.getProductList = self.getProductCollectionListAdd[indexPath.row]
                    let params:[String:AnyObject]? = [
                        "product_id":self.getProductList.product_id,
                        "device_id":"1234",
                        "token":token,
                        "quantity":Int(field.text!)!
                    ]
            
                    print(params)
                    
                    ServerManager.sharedInstance().customerAddToCart(params) { (isSuccessful, error, result) in
                        
                        if isSuccessful{
                   self.toastViewForTextfield("Successfully added to cart")
                        }
//                        }else{
//                            AlertView.alertViewWithPopup("Alert", message: error!, alertTitle: "OK", viewController: self)
//                            self.hideHud()
//                        }
                        }
            }else{
                self.toastViewForTextfield("Not a valid number to enter")
            }
            }else{
                self.toastViewForTextfield("Cannot be left blank")
            }
          }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Number Of Items"
            textField.text = "1"
            textField.keyboardType = .PhonePad
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
}
else{
    self.hideHud()
    AlertView.alertView("Alert", message: "No internet connection", alertTitle: "OK" , viewController: self)
}
    }

    func addToWishlistButtonClicked(sender:UIButton) {
        if tableView.hidden == false {
            tableView.removeFromSuperview()
            tableView.hidden = true
        }
    
        let cell = sender.superview!.superview!.superview as! CustomerMenuItemsCollectionViewCell
        let indexPath = self.collectionView.indexPathForCell(cell)!
        
            let params:[String:AnyObject]? = [
                "product_id":self.getProductCollectionListAdd[indexPath.row].product_id,
                "device_id":"1234",
                "token":token,
            ]
            
            print(params)
            ServerManager.sharedInstance().customerAddtoWishlist(params, completionClosure: { (isSuccessful, error, result) in

                self.toastViewForTextfield("Product is added to wishlist")

//                let alert = UIAlertController(title: "Alert", message: "Product is added to Wishlist", preferredStyle: UIAlertControllerStyle.Alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//                self.presentViewController(alert, animated: true, completion: nil)
            })
    }
    
   // MARK: - Search Bar UI
    
    func prepareUI(){
        self.addSearchBar()
        self.addRefreshControl()
    }
    
    func addSearchBar(){
        if self.searchBar == nil{
            self.searchBarBoundsY = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.sharedApplication().statusBarFrame.size.height
            
            self.searchBar = UISearchBar(frame: CGRectMake(0,self.searchBarBoundsY!, UIScreen.mainScreen().bounds.size.width, 50))
            self.searchBar!.searchBarStyle       = UISearchBarStyle.Minimal
//            self.searchBar!.tintColor            = UIColor.whiteColor()
//            self.searchBar!.barTintColor         = UIColor.whiteColor()
            self.searchBar!.delegate             = self;
            self.searchBar!.placeholder          = "Search here";
            self.addObservers()
        }
        
        if !self.searchBar!.isDescendantOfView(self.view){
            self.view.addSubview(self.searchBar!)
        }
    }
    
    // MARK: - Refresh Control
    
    func addRefreshControl(){
        if (self.refreshControl == nil) {
            self.refreshControl            = UIRefreshControl()
            self.refreshControl?.tintColor = UIColor.whiteColor()
            self.refreshControl?.addTarget(self, action: #selector(CustomerMenuItemsViewController.refreashControlAction), forControlEvents: UIControlEvents.ValueChanged)
        }
        if !self.refreshControl!.isDescendantOfView(self.collectionView!) {
            self.collectionView!.addSubview(self.refreshControl!)
        }
    }
    
    func startRefreshControl(){
        if !self.refreshControl!.refreshing {
            self.refreshControl!.beginRefreshing()
        }
    }
    
    
    // MARK: - Observers
    
    func addObservers(){
        let context = UnsafeMutablePointer<UInt8>(bitPattern: 1)
        self.collectionView?.addObserver(self, forKeyPath: "contentOffset", options: [.New,.Old], context: context)
    }
    
    func removeObservers(){
        self.collectionView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override func observeValueForKeyPath(keyPath: String?,
                                         ofObject object: AnyObject?,
                                                  change: [String : AnyObject]?,
                                                  context: UnsafeMutablePointer<Void>){
        if keyPath! == "contentOffset" {
            if let collectionV:UICollectionView = object as? UICollectionView {
                self.searchBar?.frame = CGRectMake(
                    self.searchBar!.frame.origin.x,
                    self.searchBarBoundsY! + ( (-1 * collectionV.contentOffset.y) - self.searchBarBoundsY!),
                    self.searchBar!.frame.size.width,
                    self.searchBar!.frame.size.height
                )
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if tableView.hidden == false {
            tableView.removeFromSuperview()
            tableView.hidden = true
        }
        
    if segue.identifier == "popoverSegue" {
       let popoverViewController = segue.destinationViewController
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
            let screen = UIScreen.mainScreen().bounds
            popoverViewController.preferredContentSize = CGSize(width: screen.width * 0.5 - 25, height: screen.height * 0.5 - 50)
            popoverViewController.popoverPresentationController!.delegate = self
     } else if segue.identifier == "productDescSegue" {
            let vc = segue.destinationViewController as? CustomerMenuDescriptionViewController
            vc!.getProductList = self.getSpecificProductList
     } else if segue.identifier == "customerUpdateSegue" {
            let vc = segue.destinationViewController as? CustomerUpdateProfileViewController
            vc!.isLogin = "customerDropDown"
     } else if segue.identifier == "vendorListIdentifier" {
            let vc = segue.destinationViewController as! VendorsListViewController
            vc.delegate = self
     }else if segue.identifier == "cartListSegue" {
            let vc = segue.destinationViewController as! CartListViewController
            vc.getProductCollectionList = self.getProductList
     }
   }
    
    // MARK: - Actions
    
    @IBAction func CartListAction(sender: AnyObject) {
             performSegueWithIdentifier("cartListSegue", sender: nil)
    }
    
    @IBAction func openDefaultVendorLIst(sender: AnyObject) {
        
    }
    
    
  
    
    func alertControllerToLogout() {
        
        let alertController = UIAlertController(title: "Alert", message: "Do You wish to logout", preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
            let params = [
                "token":token,
                "device_id":"1234"
            ]
            
            ServerManager.sharedInstance().loginLogout(params) { (isSuccessful, error, result) in
                if isSuccessful {
                    self.hideHud()
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("defaultvendorName")
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("defaultvendorID")
                    self.performSegueWithIdentifier("loginSegue", sender: nil)
                }
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - TextField Delegates
    
    func textFieldDidBeginEditing(textField: UITextField) {
        fromMenuToProductPage = ""
        self.view.endEditing(true)
  
        self.performSegueWithIdentifier("vendorListIdentifier", sender: nil)
        textField.resignFirstResponder()
    }
    
    
    
    
}