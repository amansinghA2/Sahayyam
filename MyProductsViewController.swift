//
//  MyProductsViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 14/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class MyProductsViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout ,UIPopoverPresentationControllerDelegate ,UISearchBarDelegate ,SWRevealViewControllerDelegate{
    
    @IBOutlet weak var myproductsCollectionView: UICollectionView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        let nib = UINib(nibName: "MyProductDetailsTableViewCell", bundle: nil)
        myproductsCollectionView.registerNib(nib, forCellWithReuseIdentifier: "menuItemIdentifier1")
       // slideMenuShow(menuButton, viewcontroller: self)
        self.revealViewController().delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let params = [
        "token":token,
        "product_name":"",
        "limit":"25",
        "page":"1",
        "device_id":"1234",
        "global":"0",
        "service_id":"51"
        ]
        
        ServerManager.sharedInstance().vendorMyProductsList(params) { (isSuccessful, error, result) in
            if isSuccessful {
                self.getProductCollectionList = result!
                self.myproductsCollectionView.delegate = self
                self.myproductsCollectionView.dataSource = self
                self.myproductsCollectionView.reloadData()
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
            return text.prodnName.containsString(searchText)
        })
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // user did type something, check our datasource for text that looks the same
        if searchText.characters.count > 0 {
            // search and reload data source
            self.searchBarActive    = true
            self.filterContentForSearchText(searchText)
            self.myproductsCollectionView?.reloadData()
        }else{
            // if text lenght == 0
            // we will consider the searchbar is not active
            self.searchBarActive = false
            self.myproductsCollectionView?.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.cancelSearching()
        self.myproductsCollectionView?.reloadData()
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
        if !self.refreshControl!.isDescendantOfView(self.myproductsCollectionView!) {
            self.myproductsCollectionView!.addSubview(self.refreshControl!)
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
    }
    
    func removeObservers(){
        self.myproductsCollectionView?.removeObserver(self, forKeyPath: "contentOffset")
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
            self.myproductsCollectionView?.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let emptyLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        
        if getProductCollectionList.count == 0 {
            emptyLabel.text = "No Products"
            emptyLabel.textAlignment = NSTextAlignment.Center
            self.myproductsCollectionView.backgroundView = emptyLabel
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
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("menuItemIdentifier1",forIndexPath: indexPath) as! MyProductDetailsTableViewCell
//        cell.addToCart.tag = indexPath.row
//        cell.addToCart.addTarget(self, action: #selector(CustomerMenuItemsViewController.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        if (self.searchBarActive) {
            getProductList = self.dataSourceForSearchResult[indexPath.row]
            cell.getProductCollectionLists1 = getProductList
        }else{
            getProductList = self.getProductCollectionList[indexPath.row]
            cell.getProductCollectionLists1 = getProductList
        }
        //index.php?route=api/vendor/getProducts";
//        String token = sm.getToken();
//        String imei = sm.getImei();
//        String cookie = sm.getCookie();
//        
//        url = url+"&token="+token+"&device_id="+imei+"&product_id="+mProductIdPassed+"&width=515&height=500";
        //        cell.contentView.frame = cell.bounds;
        //        cell.contentView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth , UIViewAutoresizing.FlexibleHeight]
        
//        cell.addToWishlist.tag = indexPath.row
//        cell.addToWishlist.addTarget(self, action: #selector(CustomerMenuItemsViewController.addToWishlistButtonClicked(_:)), forControlEvents:  UIControlEvents.TouchUpInside)
        
        return cell
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
        // let cellLeg = (collectionView.frame.size.width/2);
        return CGSizeMake(160,175);
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
    
    // MARK: - Custom Actions
    
    @IBAction func vendorServiceAction(sender: AnyObject) {
    
        let params = [
        "token":token,
        "device_id":"1234"
        ]
        
        ServerManager.sharedInstance().getVendorServices(params) { (isSuccessful, error, result) in
            if isSuccessful {
              self.vendorServices = result!
              self.myproductsCollectionView.delegate = self
              self.myproductsCollectionView.dataSource = self
              self.myproductsCollectionView.reloadData()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "vendorProductDetailsSegue" {
            let vc = segue.destinationViewController as? ProductDetailsViewController
            vc!.getProductList = self.getSpecificProductList
        }
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
