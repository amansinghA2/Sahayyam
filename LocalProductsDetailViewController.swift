//
//  LocalProductsDetailViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 22/11/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

class LocalProductsDetailViewController: UIViewController , UITableViewDelegate , UITableViewDataSource , UISearchBarDelegate{

    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var localProductDetailsTableview: UITableView!
    var approvedPendingList = [ApprovePendingStatus]()
    var dataSourceForSearchResult = [ProductCollectionList]()
    var searchBarActive:Bool = false
    var searchBarBoundsY:CGFloat?
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
    var refreshControl:UIRefreshControl?
    var searchText1 = ""
    var isDataSOurceREsultEmpty = false
    var page = 1
    var totalPages:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.prepareUI()
        self.navigationItem.titleView = searchBar
        self.searchBar.searchBarStyle       = UISearchBarStyle.Minimal
        self.searchBar.delegate             = self;
        self.searchBar.placeholder          = "Search here";
        
        let nib1 = UINib(nibName: "VendorApprovedDetailTableViewCell", bundle: nil)
        self.localProductDetailsTableview.registerNib(nib1, forCellReuseIdentifier: "vendorApproveIdentifier")
        page = 1
        approveProductDetails("approved", page: "1", limit: "25", filterName: "")
        // Do any additional setup after loading the view.
    }
    
    func approveProductDetails(status:String , page:String , limit:String , filterName:String) {
        
        self.showHud("Loading...")
        
        let params = [
        "token":token,
        "device_id":"1234",
        "status":status,
        "page":page,
        "limit":limit,
        "filter_name":filterName
        ]
        
        print(params)
        
        ServerManager.sharedInstance().vendorApprovePendingRejected(params) { (isSuccessful, error, result , result1) in
            if isSuccessful {
                
                if let totalPage = result1!["page"]{
                    self.totalPages = Int(totalPage as! String)!
                }
                
                self.approvedPendingList = result!
                self.localProductDetailsTableview.delegate = self
                self.localProductDetailsTableview.dataSource = self
                self.localProductDetailsTableview.reloadData()
                self.hideHud()
            }else{
                self.hideHud()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
        
        if approvedPendingList.count >  0 {
            return approvedPendingList.count
        }else{
            tableViewCustomLabel("No Products", tableView: localProductDetailsTableview)
            return 0
        }
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch  indexPath.section {
        case 0:
            let cell:VendorApprovedDetailTableViewCell = tableView.dequeueReusableCellWithIdentifier("vendorApproveIdentifier") as! VendorApprovedDetailTableViewCell
            cell.approvedPendingList = self.approvedPendingList[indexPath.row]
            //cell.customerList = customreList
            cell.clickedIndexButton.tag = indexPath.row
            cell.clickedIndexButton.addTarget(self, action: #selector(LocalProductsDetailViewController.clickedButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("loadMoreIdentifier",forIndexPath: indexPath) as! LoadMoreTableViewCell
            cell.loadMoreButton.addTarget(self, action: #selector(LocalProductsDetailViewController.loadButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("loadMoreIdentifier",forIndexPath: indexPath) as! LoadMoreTableViewCell
            cell.loadMoreButton.addTarget(self, action: #selector(LocalProductsDetailViewController.loadButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        }
        
        
    }
    
    func loadButtonClicked(sender:UIButton) {
        page += 1
        if page <= totalPages{
            switch segmentControl.selectedSegmentIndex {
            case 0:
                approveProductDetails("approved", page: "\(page)", limit: "25", filterName: searchText1)
            case 1:
                approveProductDetails("pending", page: "\(page)", limit: "25", filterName: searchText1)
            case 2:
                approveProductDetails("rejected", page: "\(page)", limit: "25", filterName: searchText1)
            default:
                approveProductDetails("approved", page: "\(page)", limit: "25", filterName: searchText1)
            }
        }else{
            self.toastViewForTextfield("No More Products")
        }
        
    }
    
    func clickedButtonClicked(sender:UIButton) {
        let cell = sender.superview!.superview as! VendorApprovedDetailTableViewCell
        let indexPath = localProductDetailsTableview.indexPathForCell(cell)
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("vendorProductDetailID") as! VendorProductSubdetailViewController
        // popOverVC.getproductCollectionList = getProductCollectionList[(indexPath?.row)!]
        self.addChildViewController(popOverVC)
        popOverVC.approvedPendingList = self.approvedPendingList[(indexPath?.row)!]
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let popOverVC = UIStoryboard(name: "Vendor", bundle: nil).instantiateViewControllerWithIdentifier("vendorProductDetailID") as! VendorProductSubdetailViewController
        // popOverVC.getproductCollectionList = getProductCollectionList[(indexPath?.row)!]
        self.addChildViewController(popOverVC)
        popOverVC.approvedPendingList = self.approvedPendingList[indexPath.row]
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)
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
    @IBAction func segmentControlAction(sender: AnyObject) {
        page = 1
        switch segmentControl.selectedSegmentIndex {
        case 0:
          approveProductDetails("approved", page: "1", limit: "25", filterName: "")
        case 1:
          approveProductDetails("pending", page: "1", limit: "25", filterName: "")
        case 2:
          approveProductDetails("rejected", page: "1", limit: "25", filterName: "")
        default:
          approveProductDetails("approved", page: "1", limit: "25", filterName: "")
        }
        
    }
    
    // MARK: - Search Bar UI
    
//    func prepareUI(){
//        self.addSearchBar()
//        self.addRefreshControl()
//    }
    
//    func addSearchBar(){
//            self.searchBar.searchBarStyle       = UISearchBarStyle.Minimal
//            self.searchBar.delegate             = self;
//            self.searchBar.placeholder          = "Search here";
//           // self.addObservers()
//    }
    
    // MARK: - Refresh Control
    
//    func addRefreshControl(){
//        if (self.refreshControl == nil) {
//            self.refreshControl            = UIRefreshControl()
//            self.refreshControl?.tintColor = UIColor.whiteColor()
//            self.refreshControl?.addTarget(self, action: #selector(LocalProductsDetailViewController.refreashControlAction), forControlEvents: UIControlEvents.ValueChanged)
//        }
//        if !self.refreshControl!.isDescendantOfView(self.localProductDetailsTableview!) {
//            self.localProductDetailsTableview!.addSubview(self.refreshControl!)
//        }
// 
//    }
    
//    func startRefreshControl(){
//        if !self.refreshControl!.refreshing {
//            self.refreshControl!.beginRefreshing()
//        }
//    }
    
    // MARK: - Observers
    
//    func addObservers(){
//        let context = UnsafeMutablePointer<UInt8>(bitPattern: 1)
//        self.localProductDetailsTableview?.addObserver(self, forKeyPath: "contentOffset", options: [.New,.Old], context: context)
// 
//    }
//    
//    func removeObservers(){
//        self.localProductDetailsTableview?.removeObserver(self, forKeyPath: "contentOffset")
//
//    }
    
//    override func observeValueForKeyPath(keyPath: String?,
//                                         ofObject object: AnyObject?,
//                                                  change: [String : AnyObject]?,
//                                                  context: UnsafeMutablePointer<Void>){
//        if keyPath! == "contentOffset" {
//            if let collectionV:UITableView = object as? UITableView {
//                self.searchBar.frame = CGRectMake(
//                    self.searchBar.frame.origin.x,
//                    self.searchBarBoundsY! + ( (-1 * collectionV.contentOffset.y) - self.searchBarBoundsY!),
//                    self.searchBar.frame.size.width,
//                    self.searchBar.frame.size.height
//                )
//            }
//        }
//        
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
            if searchText.characters.count > 0 {
                switch segmentControl.selectedSegmentIndex {
                case 0:
                    approveProductDetails("approved", page: "1", limit: "25", filterName: String(searchText))
                    searchText1 = searchText
                case 1:
                    approveProductDetails("pending", page: "1", limit: "25", filterName: String(searchText))
                    searchText1 = searchText
                case 2:
                    approveProductDetails("rejected", page: "1", limit: "25", filterName: String(searchText))
                    searchText1 = searchText
                default:
                    approveProductDetails("approved", page: "1", limit: "25", filterName: String(searchText))
                    searchText1 = searchText
                }
            }else{
               
            }
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
      //  self.cancelSearching()
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // self.myProductsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBarActive = true
        self.view.endEditing(true)
    }
    
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        // we used here to set self.searchBarActive = YES
        // but we'll not do that any more... it made problems
        // it's better to set self.searchBarActive = YES when user typed something
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        // this method is being called when search btn in the keyboard tapped
        // we set searchBarActive = NO
        // but no need to reloadCollectionView
        //        self.view.endEditing(true)
        isDataSOurceREsultEmpty = false
        self.searchBarActive = false
        self.searchBar.setShowsCancelButton(false, animated: false)
    }
    
//    func cancelSearching(){
//        isDataSOurceREsultEmpty = false
//        self.searchBarActive = false
//        self.searchBar.resignFirstResponder()
//        self.searchBar.text = ""
//    }
//    
//    
//    
//    
//    deinit{
//     //   self.removeObservers()
//    }
//    
//    // MARK: actions
//    func refreashControlAction(){
//        self.cancelSearching()
//        
//        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
//        dispatch_after(delayTime, dispatch_get_main_queue()) {
//            // stop refreshing after 2 seconds
//            self.localProductDetailsTableview.reloadData()
//            self.refreshControl?.endRefreshing()
//        }
//    }
    
}

