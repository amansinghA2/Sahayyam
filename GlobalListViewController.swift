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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slideMenuShow(slideMenuButton, viewcontroller: self)
        prepareUI()
        tokenCheck()
                let nib1 = UINib(nibName: "GlobalListTableViewCell", bundle: nil)
                self.globalListTableView.registerNib(nib1, forCellReuseIdentifier: "goToGlobalListCell")
       self.globalListTableView.contentInset = UIEdgeInsetsMake(self.searchBar!.frame.size.height, 0, 0, 0)
        // slideMenuShow(menuButton, viewcontroller: self)
        self.revealViewController().delegate = self
        // Do any additional setup after loading the view.
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
    
    
    override func viewWillAppear(animated: Bool) {
        
        let params = [
            "token":token,
            "product_name":"",
            "limit":"25",
            "page":"1",
            "device_id":"1234",
            "global":"1",
            "service_id":"51"
        ]
        
        ServerManager.sharedInstance().vendorMyProductsList(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.getProductCollectionList = result!
                self.globalListTableView.delegate = self
                self.globalListTableView.dataSource = self
                self.globalListTableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Search Bar Delegates
    
    func filterContentForSearchText(searchText:String){
        self.dataSourceForSearchResult = self.getProductCollectionList.filter({ (text:ProductCollectionList) -> Bool in
            return text.name.containsString(searchText)
        })
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // user did type something, check our datasource for text that looks the same
        if searchText.characters.count > 0 {
            // search and reload data source
            self.searchBarActive    = true
            self.filterContentForSearchText(searchText)
            self.globalListTableView?.reloadData()
        }else{
            // if text lenght == 0
            // we will consider the searchbar is not active
            self.searchBarActive = false
            self.globalListTableView?.reloadData()
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
            self.searchBarBoundsY = (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.sharedApplication().statusBarFrame.size.height
            
            self.searchBar = UISearchBar(frame: CGRectMake(0,self.searchBarBoundsY!, UIScreen.mainScreen().bounds.size.width, 50))
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
    
    
    
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            
            if getProductCollectionList.count == 0 {
                emptyLabel.text = "No Products"
                emptyLabel.textAlignment = NSTextAlignment.Center
                self.globalListTableView.backgroundView = emptyLabel
                // self.collectionView.separatorStyle = UITableViewCellSeparatorStyle.None
                return 0
            }else{
                if self.searchBarActive {
                    emptyLabel.text = ""
                    return self.dataSourceForSearchResult.count;
                }
                emptyLabel.text = ""
                return getProductCollectionList.count
            }
        }
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("goToGlobalListCell") as! GlobalListTableViewCell
    
            if (self.searchBarActive) {
                getProductList = self.dataSourceForSearchResult[indexPath.row]
                cell.getProductCollectionLists1 = getProductList
            }else{
                getProductList = self.getProductCollectionList[indexPath.row]
                cell.getProductCollectionLists1 = getProductList
            }
            
            cell.addButtonLabel.addTarget(self, action: #selector(GlobalListViewController.addProductAction), forControlEvents: UIControlEvents.TouchUpInside)
    
            return cell
    
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
            
            getSpecificProductList = getProductCollectionList[(indexPath?.row)!]
            
            let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("addProductID") as! AddProductViewController
            popOverVC.getproductCollectionList = getProductCollectionList[(indexPath?.row)!]
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMoveToParentViewController(self)
            
    }

    
    @IBAction func vendorServiceAction(sender: AnyObject) {
//      self.performSegueWithIdentifier("globalListServices", sender: nil)
        
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
    
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
