////
////  MyProductsViewController.swift
////  Sahayyam
////
////  Created by Aman Singh on 14/09/16.
////  Copyright © 2016 Sanjeev Jikamade. All rights reserved.

import UIKit

//@objc
//protocol CustomerMenuItemsViewControllerDelegate {
//    optional func toggleLeftPanel()
//    optional func toggleRightPanel()
//    optional func collapseSidePanels()
//}

class MyProductsViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout ,UIPopoverPresentationControllerDelegate , UITextFieldDelegate , UISearchBarDelegate , SWRevealViewControllerDelegate , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var myProductsTableView: UITableView!
        @IBOutlet weak var slidemenuButton: UIBarButtonItem!
        @IBOutlet weak var myproductsCollectionView: UICollectionView!
        var vendorServices = [VendorService]()
        var vendorService = VendorService()

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
    var page = 0
    var totalPages:Int?
    var limit = 25
    var isDataSOurceREsultEmpty = false
    var selectedIndexPath1 = NSIndexPath()
    var noImage = String()
    var serviceString = ""
    var isServicesSelected = false
    var editedSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyProductsViewController.showToastForRegister(_:)), name: "vendorRegisterStatus", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyProductsViewController.showToastForRegister(_:)), name: "vendorRegisterStatus", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyProductsViewController.navigationDisableAction(_:)), name: "disableCategoryNavigation1", object: nil)
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyProductsViewController.navigationEnableAction(_:)), name: "enableCategoryNavigation1", object: nil)
        
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        tableView.hidden = true
    }

    override func viewDidAppear(animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(animated: Bool) {
        
        isServicesSelected = false
        getProductCollectionListAdd.removeAll()
        super.viewWillAppear(animated)
        self.prepareUI()

        NSUserDefaults.standardUserDefaults().setObject(defaultVendorName, forKey:"defaultvendorName")
        if Reachability.isConnectedToNetwork(){
             if editedSuccess == false {
            productFunction("25", page: "1", filterName: "")
             }else{
                
            }
        }
        else {
            self.hideHud()
            AlertView.alertViewToGoToLogin("OK", message: "No internet connection", alertTitle: "OK", viewController: self)
        }
    }

    
    func serviceProductFunction(limit:String , page:String , filterName:String , service_id:String) {
        self.showHud("Loading...")
        let params = [
            "token":token,
            "product_name":filterName,
            "limit":limit,
            "filter_name":"",
            "page":page,
            "device_id":"1234",
            "global":"0",
            "service":service_id
        ]
        
        print(params)
        
        ServerManager.sharedInstance().vendorMyProductsList(params) { (isSuccessful, error, result , result1) in
            if isSuccessful {
                self.hideHud()
                if let totalPage = result1!["TotalPages"]{
                    self.totalPages = Int(totalPage as! String)!
                }
                
                if let noImage = result1!["no_image"] as? String{
                    self.noImage = noImage
                }
                
                self.dataSourceForSearchResult = result!
                self.getProductCollectionList = result!
                print(self.getProductCollectionList.count)
                self.getProductCollectionListAdd += self.getProductCollectionList
                
                if self.noImage == "1" {
                    self.myproductsCollectionView.hidden = true
                    self.myProductsTableView.hidden = false
                    self.myProductsTableView.dataSource = self
                    self.myProductsTableView.delegate = self
                    self.myProductsTableView.reloadData()
                }else{
                    self.myProductsTableView.hidden = true
                    self.myproductsCollectionView.hidden = false
                    self.myproductsCollectionView.dataSource = self
                    self.myproductsCollectionView.delegate = self
                    self.myproductsCollectionView.reloadData()
                }
            }else{
                if (error != nil) {
                    self.getProductCollectionListAdd.removeAll()
                    
                    if self.noImage == "1" {
                        self.myproductsCollectionView.hidden = true
                        self.myProductsTableView.hidden = false
                        self.myProductsTableView.dataSource = self
                        self.myProductsTableView.delegate = self
                        self.myProductsTableView.reloadData()
                    }else{
                        self.myProductsTableView.hidden = true
                        self.myproductsCollectionView.hidden = false
                        self.myproductsCollectionView.dataSource = self
                        self.myproductsCollectionView.delegate = self
                        self.myproductsCollectionView.reloadData()
                    }
                    self.tableViewCustomLabel("No Products", tableView: self.myProductsTableView)
                    self.collectionViewCustomLabel("No Products", collectionView: self.myproductsCollectionView)
                    self.hideHud()
                    
                }
                
                self.hideHud()
            }
        }
    }
    
    func productFunction(limit:String , page:String , filterName:String) {
        
        self.showHud("Loading...")
        let params = [
            "token":token,
            "product_name":filterName,
            "limit":limit,
            "filter_name":"",
            "page":page,
            "device_id":"1234",
            "global":"0",
        ]

        print(params)
        
        ServerManager.sharedInstance().vendorMyProductsList(params) { (isSuccessful, error, result , result1) in
            if isSuccessful {
                self.hideHud()
                if let totalPage = result1!["TotalPages"]{
                    self.totalPages = Int(totalPage as! String)!
                }
                
                if let noImage = result1!["no_image"] as? String{
                    self.noImage = noImage
                }
                
                self.dataSourceForSearchResult = result!
                self.getProductCollectionList = result!
                print(self.getProductCollectionList.count)
                self.getProductCollectionListAdd += self.getProductCollectionList
                
                if self.noImage == "1" {
                    self.myproductsCollectionView.hidden = true
                    self.myProductsTableView.hidden = false
                    self.myProductsTableView.dataSource = self
                    self.myProductsTableView.delegate = self
                    self.myProductsTableView.reloadData()
                }else{
                    self.myProductsTableView.hidden = true
                    self.myproductsCollectionView.hidden = false
                    self.myproductsCollectionView.dataSource = self
                    self.myproductsCollectionView.delegate = self
                    self.myproductsCollectionView.reloadData()
                }
            }else{
                self.hideHud()
            }
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
            self.myproductsCollectionView?.reloadData()
            self.myProductsTableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    // Mark: - TableView Methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if getProductCollectionListAdd.count == 0 {
                self.tableViewCustomLabel("No Products", tableView: myProductsTableView)
                return 0
            }else{
                self.tableViewCustomLabel("", tableView: myProductsTableView)
                if self.searchBarActive {
                    return self.dataSourceForSearchResult.count;
                }
                return getProductCollectionListAdd.count
            }
        }else {
            
            if getProductCollectionListAdd.count <= 25 && getProductCollectionListAdd.count > 0{
                return 1
            }
            
            if getProductCollectionListAdd.count == 0 {
                return 0
            }
            
            if isDataSOurceREsultEmpty == true {
                if dataSourceForSearchResult.count == 0 {
                return 1
              }
            }else{
                return 2
            }
            return 2
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("goToGlobalListCell",forIndexPath: indexPath) as! GlobalListTableViewCell
            cell.addButtonLabel.hidden = true
            if (self.searchBarActive) {
                getProductList = self.dataSourceForSearchResult[indexPath.row]
                cell.getProductCollectionLists1 = getProductList
            }else{
                if self.getProductCollectionListAdd.count > 0 {
                    getProductList = self.getProductCollectionListAdd[indexPath.row]
                    cell.getProductCollectionLists1 = self.getProductList
                }
            }
            return cell
        default:

            let cell = tableView.dequeueReusableCellWithIdentifier("loadMoreIdentifier", forIndexPath: indexPath) as! LoadMoreTableViewCell
            
            cell.loadMoreButton.addTarget(self, action: #selector(MyProductsViewController.loadButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            if indexPath.row == 0 {
                if noImage == "1" {
                    cell.loadMoreButton.setTitle("Unblock Images", forState: .Normal)
                    cell.loadMoreButton.tag = 0
                    //self.blockUnblockImages("")
                }else{
                    cell.loadMoreButton.setTitle("Block Images", forState: .Normal)
                    cell.loadMoreButton.tag = 0
                    //self.blockUnblockImages("1")
                }
            }else{
                    cell.loadMoreButton.setTitle("Load More", forState: .Normal)
                    cell.loadMoreButton.tag = 1
            }
            return cell
        }
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("goToGlobalListCell") as! GlobalListTableViewCell
//        cell.addButtonLabel.hidden = true
//        if (self.searchBarActive) {
//            getProductList = self.dataSourceForSearchResult[indexPath.row]
//            cell.getProductCollectionLists1 = getProductList
//        }else{
//            if self.getProductCollectionListAdd.count > 0 {
//                getProductList = self.getProductCollectionListAdd[indexPath.row]
//                cell.getProductCollectionLists1 = self.getProductList
//            }
//        }
//   return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        getSpecificProductList = getProductCollectionList[indexPath.row]
        performSegueWithIdentifier("vendorProductDetailsSegue", sender: nil)
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: - UICollectionViewDelegate

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        if section == 0{
            if getProductCollectionListAdd.count == 0 {
                self.collectionViewCustomLabel("No Products", collectionView: collectionView)
                return 0
            }else{
                self.collectionViewCustomLabel("", collectionView: collectionView)
                if self.searchBarActive {
                    return self.dataSourceForSearchResult.count;
                }
                return getProductCollectionListAdd.count
            }
        }else {
            if getProductCollectionListAdd.count < 25 && getProductCollectionListAdd.count > 0{
                return 1
            }
            
//            if getProductCollectionListAdd.count < 25 && getProductCollectionListAdd.count > 0{
//                return 1
//            }

            if  getProductCollectionListAdd.count == 0 {
                return 0
            }
            
            if isDataSOurceREsultEmpty == true {
                if dataSourceForSearchResult.count == 0 {
                    return 2
                }
            }else{
                return 2
            }
            return 2
        }
    }

    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("menuItemIdentifier1",forIndexPath: indexPath) as! MyProductDetailsTableViewCell

            if (self.searchBarActive) {
                getProductList = self.dataSourceForSearchResult[indexPath.row]
                cell.getProductCollectionLists1 = getProductList
            }else{
                if self.getProductCollectionListAdd.count > 0 {
                    getProductList = self.getProductCollectionListAdd[indexPath.row]
                    cell.getProductCollectionLists1 = self.getProductList
                }
            }
            return cell
        default:

            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("loadMoreIdentifier",forIndexPath: indexPath) as! LoadMoreCollectionViewCell
            cell.loadMoreButton.addTarget(self, action: #selector(MyProductsViewController.loadButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            if indexPath.row == 0 {
                if noImage == "1" {
                    cell.loadMoreButton.setTitle("Unblock Images", forState: .Normal)
                    cell.loadMoreButton.tag = 0
                    //self.blockUnblockImages("")
                }else{
                    cell.loadMoreButton.setTitle("Block Images", forState: .Normal)
                    cell.loadMoreButton.tag = 0
                    //self.blockUnblockImages("1")
                }
            }else{
                cell.loadMoreButton.setTitle("Load More", forState: .Normal)
                cell.loadMoreButton.tag = 1
            }
           
            return cell
        }

    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        getSpecificProductList = getProductCollectionList[indexPath.row]
        performSegueWithIdentifier("vendorProductDetailsSegue", sender: nil)
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

        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad)
        {
            if indexPath.section == 1 {
                return CGSizeMake(120,50)
            }
            return CGSize(width: UIScreen.mainScreen().bounds.size.width/3, height: 225)
        }else{
            if indexPath.section == 1 {
                return CGSizeMake(120,50)
            }
            return CGSize(width: UIScreen.mainScreen().bounds.size.width/2, height: 175)
        }

    }

    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    //    {
    //        return CGSizeMake((UIScreen.mainScreen().bounds.width)/2,175); //use height whatever you wants.
    //    }


    // MARK: Search Bar Delegates

    func filterContentForSearchText(searchText:String){

        //        self.dataSourceForSearchResult = self.getProductCollectionListAdd.filter({ (text:ProductCollectionList) -> Bool in
        //            return text.prodnName.containsString(searchText)
        //        })

    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // user did type something, check our datasource for text that looks the same
        searchBar.text = searchText.lowercaseString
        getProductCollectionListAdd.removeAll()
        if isServicesSelected == false {
            if searchText.characters.count > 0 {
                getProductCollectionListAdd.removeAll()
                productFunction("25", page: "1" , filterName: String(searchText))
                //             productFunction("25", page: "1" , filterName: String(searchText) , service_id: serviceString)
                
                self.searchBarActive = true
                self.filterContentForSearchText(searchText)
                self.myproductsCollectionView?.reloadData()
                self.myProductsTableView.reloadData()
            }else{
                getProductCollectionListAdd.removeAll()
                productFunction("25", page: "1", filterName: "")
//                productFunction("25", page: "1" , filterName: "" , service_id: serviceString)
                //          productFunction("25", page: "" , filterName:"" , service_id: serviceString)
                self.searchBarActive = false
                self.myproductsCollectionView?.reloadData()
                self.myProductsTableView.reloadData()
            }
        }else{
            if searchText.characters.count > 0 {
                getProductCollectionListAdd.removeAll()
                serviceProductFunction("25", page: "1" , filterName: String(searchText) , service_id: serviceString)
                //             productFunction("25", page: "1" , filterName: String(searchText) , service_id: serviceString)
                self.searchBarActive = true
                self.filterContentForSearchText(searchText)
                self.myproductsCollectionView?.reloadData()
                self.myProductsTableView.reloadData()
            }else{
                getProductCollectionListAdd.removeAll()
                serviceProductFunction("25", page: "1" , filterName: "" , service_id: serviceString)
                //          productFunction("25", page: "" , filterName:"" , service_id: serviceString)
                self.searchBarActive = false
                self.myproductsCollectionView?.reloadData()
                self.myProductsTableView.reloadData()
            }
        }
    }


    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.cancelSearching()
        isDataSOurceREsultEmpty = false
        self.myproductsCollectionView?.reloadData()
       // self.myProductsTableView.reloadData()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBarActive = true
        self.view.endEditing(true)
    }


    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        isDataSOurceREsultEmpty = true
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
        //        self.view.endEditing(true)
        isDataSOurceREsultEmpty = false
        self.searchBarActive = false
        self.searchBar!.setShowsCancelButton(false, animated: false)
    }

    func cancelSearching(){
        isDataSOurceREsultEmpty = false
        self.searchBarActive = false
        self.searchBar!.resignFirstResponder()
        self.searchBar!.text = ""
    }

    // MARK:-  RevealView Controler Delegate

//    func revealController(revealController: SWRevealViewController!, willMoveToPosition position: FrontViewPosition) {
//        if position == FrontViewPosition.Left{
//            self.view.userInteractionEnabled = true
//            vendorSelectBarButtonItem.enabled = true
//        }else{
//            self.view.userInteractionEnabled = false
//            vendorSelectBarButtonItem.enabled = false
//
//        }
//    }
//
//    func revealController(revealController: SWRevealViewController!, didMoveToPosition position: FrontViewPosition) {
//
//        if position == FrontViewPosition.Left{
//            self.view.userInteractionEnabled = true
//            vendorSelectBarButtonItem.enabled = true
//
//        }else{
//            self.view.userInteractionEnabled = false
//            vendorSelectBarButtonItem.enabled = false
//        }
//    }

    // MARK: Custom Functions

    func loadButtonClicked(sender:UIButton) {
        self.prepareUI()
        if sender.tag == 0 {
            if self.noImage == "1" {
                getProductCollectionListAdd.removeAll()
                sender.setTitle("Unblock Images", forState: .Normal)
                blockUnblockImages("")
                
            }else{
                getProductCollectionListAdd.removeAll()
                sender.setTitle("Block Images", forState: .Normal)
                blockUnblockImages("1")
                
            }
        }else{
            page += 1
            if page < totalPages{
                productFunction("25", page: "\(page)" , filterName: "")
            }else{
                self.toastViewForTextfield("No More Products")
                sender.hidden = true
            }
          }
       }
    
    func blockUnblockImages(postData:String) {
        self.showHud("Loading...")
        let params = [
            "token":token,
            "device_id":"1234",
            "postData":postData
        ]
        
        print(params)
        
        ServerManager.sharedInstance().blockMyProductsImage(params, completionClosure: { (isSuccessful, error, result) in
            if isSuccessful {
                self.productFunction("25", page: "\(self.page)" , filterName: "")
                self.hideHud()
            }else{
                self.hideHud()
            }
        })
    }

    func refreshList(notification: NSNotification) {
        navigationController?.navigationBar.userInteractionEnabled = true
        if let myString = notification.object as? String {
            serviceString = myString
            self.showHud("Loading...")
            self.getProductCollectionListAdd.removeAll()
            
            serviceProductFunction("25", page: "1", filterName: "", service_id: serviceString)
        }
    }
    
    func setUpView(){
        tokenCheck()
        prepareUI()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyProductsViewController.showToastView), name: "showtoast", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyProductsViewController.refreshList(_:)), name: "refresh", object: nil)
        
        slideMenuShow(slidemenuButton, viewcontroller: self)
        self.revealViewController().delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CustomerMenuItemsViewController.PoppingController(_:)), name: "PopController", object: nil)
        let nib2 = UINib(nibName: "GlobalListTableViewCell", bundle: nil)
        self.myProductsTableView.registerNib(nib2, forCellReuseIdentifier: "goToGlobalListCell")
        let nib = UINib(nibName: "MyProductDetailsTableViewCell", bundle: nil)
        myproductsCollectionView.registerNib(nib, forCellWithReuseIdentifier: "menuItemIdentifier1")
        self.dataSourceForSearchResult = [ProductCollectionList]()
        let nibName = UINib(nibName: "CustomerDropDownTableViewCell", bundle:nil)
        self.tableView.registerNib(nibName, forCellReuseIdentifier: "dropDownCell")
        let nibName1 = UINib(nibName: "LoadMoreCollectionViewCell", bundle:nil)
        self.myproductsCollectionView.registerNib(nibName1, forCellWithReuseIdentifier: "loadMoreIdentifier")
        let nib3 = UINib(nibName: "LoadMoreTableViewCell", bundle: nil)
        self.myProductsTableView.registerNib(nib3, forCellReuseIdentifier: "loadMoreIdentifier")
        self.myProductsTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        self.changeNavigationBarColor()
    }

    
    func showToastView() {
        editedSuccess = true
        self.toastViewForTextfield("Product edited successfully")
        serviceProductFunction("25", page: "1" , filterName: "" , service_id: serviceString)
    }
    
    // MARK: - Search Bar UI

    func prepareUI(){
        self.addSearchBar()
        self.addRefreshControl()
    }

    func addSearchBar(){
        if self.searchBar == nil{
            self.searchBarBoundsY = (self.navigationController?.navigationBar.frame.size.height)!
            self.searchBar = UISearchBar(frame: CGRectMake(0,64, UIScreen.mainScreen().bounds.size.width, 50))
            self.searchBar!.searchBarStyle       = UISearchBarStyle.Minimal
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
            self.refreshControl?.addTarget(self, action: #selector(MyProductsViewController.refreashControlAction), forControlEvents: UIControlEvents.ValueChanged)
        }
        if !self.refreshControl!.isDescendantOfView(self.myproductsCollectionView!) {
            self.myproductsCollectionView!.addSubview(self.refreshControl!)
        }
        if !self.refreshControl!.isDescendantOfView(self.myProductsTableView!) {
            self.myProductsTableView!.addSubview(self.refreshControl!)
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
        self.myproductsCollectionView?.addObserver(self, forKeyPath: "contentOffset", options: [.New,.Old], context: context)
        self.myProductsTableView?.addObserver(self, forKeyPath: "contentOffset", options: [.New,.Old], context: context)
    }

    func removeObservers(){
        self.myproductsCollectionView?.removeObserver(self, forKeyPath: "contentOffset")
        self.myProductsTableView?.removeObserver(self, forKeyPath: "contentOffset")
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
        
        if keyPath! == "contentOffset" {
            if let collectionV:UITableView = object as? UITableView {
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

    @IBAction func vendorServiceAction(sender: AnyObject) {
        isServicesSelected = true
        // self.performSegueWithIdentifier("myproductSelectServices", sender: nil)
        
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("SelectServicesID") as! SelectSevicesViewController
        // popOverVC.getproductCollectionList = getProductCollectionList[(indexPath?.row)!]
        self.addChildViewController(popOverVC)
        popOverVC.str = "0"
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
        
        let params = [
            "token":token,
            "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().getVendorServices(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.vendorServices = result!
                //                productFunction("25", page: "1", filterName: "", service_id: )
                self.myproductsCollectionView.delegate = self
                self.myproductsCollectionView.dataSource = self
                self.myproductsCollectionView.reloadData()
            }
        }
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
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "vendorProductDetailsSegue" {
            let vc = segue.destinationViewController as? ProductDetailsViewController
            vc!.getProductList = self.getSpecificProductList
            print(vc!.getProductList)
        }else if segue.identifier == "myproductSelectServices" {
            
        }
    }

}


