//
//  GlobalListViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 13/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class GlobalListViewController: UIViewController , UITableViewDataSource , UITableViewDelegate,UIPopoverPresentationControllerDelegate ,UISearchBarDelegate ,SWRevealViewControllerDelegate{

    @IBOutlet weak var slideMenuButton: UIBarButtonItem!
    @IBOutlet weak var globalListTableView: UITableView!
    var searchBar:UISearchBar?
    var refreshControl:UIRefreshControl?
    var searchBarActive:Bool = false
    var searchBarBoundsY:CGFloat?
    var dataSourceForSearchResult = [ProductCollectionList]()
    var getProductCollectionList = [ProductCollectionList]()
    var getProductList:ProductCollectionList!
    var getSpecificProductList:ProductCollectionList!
    var vendorServices = [VendorService]()
    var vendorService = VendorService()
    var tableView = UITableView()
    var getProductCollectionListAdd = [ProductCollectionList]()
    var page = 1
    var totalPages:Int?
    var limit = 25
    var isDataSOurceREsultEmpty = false
    var fromMenuToProductPage = ""
    var serviceString = ""
    var servicesShown = false
    var isServicesSelected = false
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuShow(slideMenuButton, viewcontroller: self)
        prepareUI()
        tokenCheck()
        
        productMainFunction("25", page: "1", filterName: "")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GlobalListViewController.showToastForRegister(_:)), name: "vendorRegisterStatus", object: nil)
        
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GlobalListViewController.refreshList1(_:)), name: "refresh1", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GlobalListViewController.showToastForRegister(_:)), name: "vendorRegisterStatus", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GlobalListViewController.navigationDisableAction(_:)), name: "disableCategoryNavigation1", object: nil)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(GlobalListViewController.navigationEnableAction(_:)), name: "enableCategoryNavigation1", object: nil)
        
                let nib1 = UINib(nibName: "GlobalListTableViewCell", bundle: nil)
                self.globalListTableView.registerNib(nib1, forCellReuseIdentifier: "goToGlobalListCell")
        let nib2 = UINib(nibName: "LoadMoreTableViewCell", bundle: nil)
        self.globalListTableView.registerNib(nib2, forCellReuseIdentifier: "loadMoreIdentifier")
       self.globalListTableView.contentInset = UIEdgeInsetsMake(self.searchBar!.frame.size.height, 0, 0, 0)
        // slideMenuShow(menuButton, viewcontroller: self)
        self.revealViewController().delegate = self
        // Do any additional setup after loading the view.
    }
    
    func showToastForRegister(notification:NSNotification) {
        if let object = notification.object as? String {
            if object == "cancel" {
                navigationController?.navigationBar.userInteractionEnabled = true
//                self.navigationItem.leftBarButtonItem!.enabled = true
//                self.navigationItem.rightBarButtonItem!.enabled = true
            }else{
                navigationController?.navigationBar.userInteractionEnabled = true
//                self.navigationItem.leftBarButtonItem!.enabled = true
//                self.navigationItem.rightBarButtonItem!.enabled = true
               // getCustomerListFunction()
                self.toastViewForTextfield(object)
            }
        }
    }
    
    func navigationDisableAction(notification:NSNotification) {
        
        navigationController?.navigationBar.userInteractionEnabled = false
        navigationController?.navigationBar.tintColor = UIColor.lightGrayColor()
        
    }
    
    func tableViewSetup() {
    
//        let view1: UIView = moreOptionButton.valueForKey("view") as! UIView
//        var x : CGFloat = 0.0
//        x = view1.frame.origin.x;
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.reloadData()
//        tableView.frame = CGRectMake(view.frame.origin.x , 24, 140, 350)
//        self.tableView.layer.borderWidth = 1.0
//        self.tableView.layer.borderColor = UIColor.lightGrayColor().CGColor
//        self.tableView.scrollEnabled = false
//        if tableView.hidden == true {
//            let currentWindow = UIApplication.sharedApplication().keyWindow! as UIWindow
//            currentWindow.addSubview(tableView)
//            tableView.hidden = false
//        }else {
//            tableView.removeFromSuperview()
//            tableView.hidden = true
//        }
        
    }
    
    
    func productFunction(limit:String , page:String , filterName:String , serviceName:String) {
        self.showHud("Loading...")
        let params = [
            "token":token,
            "product_name":filterName,
            "filter_name":"",
            "limit":limit,
            "page":page,
            "device_id":"1234",
            "global":"1",
            "service":serviceName
        ]
        
        print(params)
        
        ServerManager.sharedInstance().vendorMyProductsList(params) { (isSuccessful, error, result , result1) in
            if isSuccessful {
                
                if let totalPage = result1!["TotalPages"]{
                    self.totalPages = Int(totalPage as! String)!
                }
                self.dataSourceForSearchResult = result!
                self.getProductCollectionList = result!
                
                for service in self.getProductCollectionList {
                    self.serviceString = service.service_id
                }
                
                print(self.getProductCollectionList.count)
                self.getProductCollectionListAdd += self.getProductCollectionList
                self.globalListTableView.delegate = self
                self.globalListTableView.dataSource = self
                self.globalListTableView.reloadData()
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }
    
    func productMainFunction(limit:String , page:String , filterName:String ) {
         self.showHud("Loading...")
        if Reachability.isConnectedToNetwork(){
            let params = [
                "token":token,
                "product_name":filterName,
                "filter_name":"",
                "limit":limit,
                "page":page,
                "device_id":"1234",
                "global":"1"
            ]
            
            print(params)
            
            ServerManager.sharedInstance().vendorMyProductsList(params) { (isSuccessful, error, result , result1) in
                if isSuccessful {

                    if let totalPage = result1!["TotalPages"]{
                        self.totalPages = Int(totalPage as! String)!
                    }
                    
                    self.dataSourceForSearchResult = result!
                    self.getProductCollectionList = result!
                    
                    for service in self.getProductCollectionList {
                        self.serviceString = service.service_id
                    }
                    
                    print(self.getProductCollectionList.count)
                    self.getProductCollectionListAdd += self.getProductCollectionList
                    self.globalListTableView.delegate = self
                    self.globalListTableView.dataSource = self
                    self.globalListTableView.reloadData()
                    self.hideHud()
                }else{
                    self.hideHud()
                }
            }
            
            
        }
        else {
            self.hideHud()
            AlertView.alertViewToGoToLogin("OK", message: "No internet connection", alertTitle: "OK", viewController: self)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        getProductCollectionListAdd.removeAll()
        //productMainFunction("25", page: "1", filterName: "")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Search Bar Delegates
    
    func filterContentForSearchText(searchText:String){
//        self.dataSourceForSearchResult = self.getProductCollectionList.filter({ (text:ProductCollectionList) -> Bool in
//            return text.name.containsString(searchText)
//        })
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // user did type something, check our datasource for text that looks the same
//        if searchText.characters.count > 0 {
//            getProductCollectionListAdd.removeAll()
//            productFunction("25", page: "1" , filterName: String(searchText) , serviceName: serviceString)
//            // search and reload data source
//            self.searchBarActive    = true
//            self.globalListTableView?.reloadData()
//        }else{
//            getProductCollectionListAdd.removeAll()
//            productFunction("25", page: "0" , filterName: "" , serviceName: serviceString)
//            // if text lenght == 0
//            // we will consider the searchbar is not active
//            self.searchBarActive = false
//            self.globalListTableView?.reloadData()
//        }
        
        getProductCollectionListAdd.removeAll()
        if isServicesSelected == false {
            if searchText.characters.count > 0 {
                getProductCollectionListAdd.removeAll()
                productMainFunction("25", page: "1" , filterName: String(searchText))
                //             productFunction("25", page: "1" , filterName: String(searchText) , service_id: serviceString)
                
                self.searchBarActive = true
                self.filterContentForSearchText(searchText)
                self.globalListTableView?.reloadData()
            }else{
                getProductCollectionListAdd.removeAll()
                productMainFunction("25", page: "1", filterName: "")
                //                productFunction("25", page: "1" , filterName: "" , service_id: serviceString)
                //          productFunction("25", page: "" , filterName:"" , service_id: serviceString)
                self.searchBarActive = false
                self.globalListTableView?.reloadData()
            }
        }else{
            if searchText.characters.count > 0 {
                getProductCollectionListAdd.removeAll()
                productFunction("25", page: "1" , filterName: String(searchText) , serviceName: serviceString)
                //             productFunction("25", page: "1" , filterName: String(searchText) , service_id: serviceString)
                self.searchBarActive = true
                self.filterContentForSearchText(searchText)
                self.globalListTableView?.reloadData()
            }else{
                getProductCollectionListAdd.removeAll()
                productFunction("25", page: "1" , filterName: "" , serviceName: serviceString)
                //          productFunction("25", page: "" , filterName:"" , service_id: serviceString)
                self.searchBarActive = false
                self.globalListTableView?.reloadData()
            }
        }

        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.cancelSearching()
        self.globalListTableView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBarActive = true
        self.view.endEditing(true)
    }
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        // we used here to set self.searchBarActive = YES
        // but we'll not do that any more... it made problems
        // it's better to set self.searchBarActive = YES when user typed something
        self.searchBar!.setShowsCancelButton(true, animated: true)
    }
    
    // MARK: - Search Bar UI
    
    func prepareUI(){
        self.addSearchBar()
        self.addRefreshControl()
    }
    
    func addSearchBar(){
        if self.searchBar == nil{
            self.searchBarBoundsY = (self.navigationController?.navigationBar.frame.size.height)!
            
            self.searchBar = UISearchBar(frame: CGRectMake(0,0, UIScreen.mainScreen().bounds.size.width, 50))
            self.searchBar!.searchBarStyle       = UISearchBarStyle.Minimal
            self.searchBar!.delegate             = self;
            self.searchBar!.placeholder          = "Search here"
            searchBar!.sizeToFit()
            self.addObservers()
        }
        
        if !self.searchBar!.isDescendantOfView(self.view){
            self.view.addSubview(self.searchBar!)
        }
    }
    
    
    func refreshList1(notification: NSNotification) {
        navigationController?.navigationBar.userInteractionEnabled = true
        if let myString = notification.object as? String {
            serviceString = myString
            print(serviceString)
            self.showHud("Loading...")
            self.getProductCollectionListAdd.removeAll()
            
            productFunction("25", page: "1", filterName: "", serviceName: serviceString)
            
//            ServerManager.sharedInstance().vendorMyProductsList(myDict) { (isSuccessful, error, result , result1) in
//                if isSuccessful {
//                    
//                    self.hideHud()
//                    if let totalPage = result1!["TotalPages"]{
//                        self.totalPages = Int(totalPage as! String)!
//                    }
//                    
//                    self.dataSourceForSearchResult = result!
//                    self.getProductCollectionList = result!
//                    print(self.getProductCollectionList.count)
//                    self.getProductCollectionListAdd += self.getProductCollectionList
//                    
//                        self.globalListTableView.dataSource = self
//                        self.globalListTableView.delegate = self
//                        self.globalListTableView.reloadData()
//                }else{
//                        self.hideHud()
//                    self.globalListTableView.dataSource = self
//                    self.globalListTableView.delegate = self
//                    self.globalListTableView.reloadData()
//                }
//            }
        }
    }
    
    // MARK: - Refresh Control
    
    func addRefreshControl(){
        if (self.refreshControl == nil) {
            self.refreshControl            = UIRefreshControl()
            self.refreshControl?.tintColor = UIColor.whiteColor()
            self.refreshControl?.addTarget(self, action: #selector(CustomerMenuItemsViewController.refreashControlAction), forControlEvents: UIControlEvents.ValueChanged)
        }
        if !self.refreshControl!.isDescendantOfView(self.globalListTableView!) {
            self.globalListTableView!.addSubview(self.refreshControl!)
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
        self.globalListTableView?.addObserver(self, forKeyPath: "contentOffset", options: [.New,.Old], context: context)
    }
    
    func removeObservers(){
        self.globalListTableView?.removeObserver(self, forKeyPath: "contentOffset")
    }
    
    override func observeValueForKeyPath(keyPath: String?,
                                         ofObject object: AnyObject?,
                                                  change: [String : AnyObject]?,
                                                  context: UnsafeMutablePointer<Void>){
        if keyPath! == "contentOffset" {
            if let _:UITableView = object as? UITableView {
                self.searchBar?.frame = CGRectMake(
                    self.searchBar!.frame.origin.x,
                    64,
                    self.searchBar!.frame.size.width,
                    self.searchBar!.frame.size.height
                )
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
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
    
    deinit{
        self.removeObservers()
    }
    
    // MARK: actions
    func refreashControlAction(){
        self.cancelSearching()
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            // stop refreshing after 2 seconds
            self.globalListTableView?.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if section == 0{
                if getProductCollectionListAdd.count == 0 {
                    tableViewCustomLabel("No More products", tableView: globalListTableView)
                    return 0
                }else{
                    tableViewCustomLabel("", tableView: globalListTableView)
                    if self.searchBarActive {
                        return self.dataSourceForSearchResult.count;
                    }
                    return getProductCollectionListAdd.count
                }
            }else {
                if getProductCollectionListAdd.count < 25 || getProductCollectionListAdd.count == 0{
                    return 0
                }
                
                if isDataSOurceREsultEmpty == true {
                    if dataSourceForSearchResult.count == 0 {
                        return 0
                    }
                }else{
                    return 1
                }
                
                if fromMenuToProductPage == "goToProductsPage"{
                    return 0
                }else{
                    return 1
                }
                
            }
    }

//
//            let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
//            
//            if getProductCollectionList.count == 0 {
//                emptyLabel.text = "No Products"
//                emptyLabel.textAlignment = NSTextAlignment.Center
//                self.globalListTableView.backgroundView = emptyLabel
//                // self.collectionView.separatorStyle = UITableViewCellSeparatorStyle.None
//                return 0
//            }else{
//                if self.searchBarActive {
//                    emptyLabel.text = ""
//                    return self.dataSourceForSearchResult.count;
//                }
//                emptyLabel.text = ""
//                return getProductCollectionList.count
//            }
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("goToGlobalListCell",forIndexPath: indexPath) as! GlobalListTableViewCell
                
                if (self.searchBarActive) {
                    getProductList = self.dataSourceForSearchResult[indexPath.row]
                    cell.getProductCollectionLists1 = getProductList
                }else{
                    if self.getProductCollectionListAdd.count > 0 {
                        getProductList = self.getProductCollectionListAdd[indexPath.row]
                        cell.getProductCollectionLists1 = self.getProductList
                    }
                }
                cell.addButtonLabel.addTarget(self, action: #selector(GlobalListViewController.addProductAction), forControlEvents: UIControlEvents.TouchUpInside)
                
                //        cell.contentView.frame = cell.bounds;
                //        cell.contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("loadMoreIdentifier",forIndexPath: indexPath) as! LoadMoreTableViewCell
                cell.loadMoreButton.addTarget(self, action: #selector(GlobalListViewController.loadButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("loadMoreIdentifier",forIndexPath: indexPath) as! LoadMoreTableViewCell
                cell.loadMoreButton.addTarget(self, action: #selector(GlobalListViewController.loadButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                return cell
            }

    }

        func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return UITableViewAutomaticDimension
        }
    
    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition) {
        
        if position == FrontViewPosition.Left{
            self.view.userInteractionEnabled = true
        }else{
            self.view.userInteractionEnabled = false
        }
    }
    
    func revealController(revealController: SWRevealViewController!, didMoveToPosition position: FrontViewPosition) {
        
        if position == FrontViewPosition.Left{
            self.view.userInteractionEnabled = true
        }else{
            self.view.userInteractionEnabled = false
        }
        
    }

        //MARK: - Custom Actions
    
    func addProductAction(sender:UIButton) {
            let cell = sender.superview?.superview as! GlobalListTableViewCell
            let indexPath = globalListTableView.indexPathForCell(cell)
            
            getSpecificProductList = getProductCollectionListAdd[(indexPath?.row)!]
            
            let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("addProductID") as! AddProductViewController
            popOverVC.getproductCollectionList = getProductCollectionListAdd[(indexPath?.row)!]
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMoveToParentViewController(self)
            
    }

    func loadButtonClicked(sender:UIButton) {
            page += 1
            if page <= totalPages{
                productFunction("25", page: "\(page)", filterName: "", serviceName: serviceString)
            }else{
                self.toastViewForTextfield("No More Products")
            }

    }
    
    @IBAction func vendorServiceAction(sender: AnyObject) {
//      self.performSegueWithIdentifier("globalListServices", sender: nil)
        isServicesSelected = true
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("SelectServicesID") as! SelectSevicesViewController
        self.addChildViewController(popOverVC)
        popOverVC.str = "1"
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        
//        let params = [
//            "token":token,
//            "device_id":"1234"
//        ]
//        
//        ServerManager.sharedInstance().getVendorServices(params) { (isSuccessful, error, result) in
//            if isSuccessful {
//                self.vendorServices = result!
//                self.globalListTableView.delegate = self
//                self.globalListTableView.dataSource = self
//                self.globalListTableView.reloadData()
//            }
//        }
        
    }
   
    @IBAction func addContacts(sender: AnyObject) {
        
        //        let cell = sender.superview?.superview as! VendorCategorySubListTableViewCell
        //        let indexPath = vendorCategoryTableview.indexPathForCell(cell)
        //
        //        subChildArray = childArray.filter({
        //            if (parentArray[indexPath!.section].category_id == $0.parent_id) {
        //                return true
        //            }
        //            return false
        //        })
        
        //            if self.balanceCredit == 0 {
        //                toastViewForTextfield("You do not have any running subscription")
        //            }else{
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("customerRegistrationID") as! CustomerRegistrationViewController
        //popOverVC.serviceLists = self.serviceLists
        //popOverVC.categoryList = self.subChildArray[(indexPath?.row)!]
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        //            }
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
