//
//  MenuViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

extension UIView {
    func rotate(toValue: CGFloat, duration: CFTimeInterval = 0.2, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = toValue
        rotateAnimation.duration = duration
        rotateAnimation.removedOnCompletion = false
        rotateAnimation.fillMode = kCAFillModeForwards
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.layer.addAnimation(rotateAnimation, forKey: nil)
    }
}

class MenuViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var menuTableView: UITableView!
    var isSelected = false
    var num = 3
    var array:NSArray?
    var parentArray = [CategoryList]()
    var childArray = [CategoryList]()
    var subChildArray = [CategoryList]()
    var selectedCategoryLIst = CategoryList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenCheck()
        let nib = UINib(nibName: "MenuTableViewCell", bundle: nil)
        menuTableView.registerNib(nib, forCellReuseIdentifier: "menuCell")
        let nib1 = UINib(nibName: "MenuDetailsHeaderTableViewCell", bundle: nil)
        menuTableView.registerNib(nib1, forCellReuseIdentifier: "menuDetailsHeaderIdentifier")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {

        parentArray = filteredArr.filter({
            if $0.level == "0" {
                return true
            }
            return false
        })
        
        childArray = filteredArr.filter({
            if $0.level == "1" {
                return true
            }
            return false
        })
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.reloadData()
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


        return (parentArray[section].collapsed) ? 0 : subChildArray.count
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCellWithIdentifier("menuCell") as! MenuTableViewCell
        subChildArray.removeAll()
        if parentArray.count > 0 {
            header.menuLabel.text = parentArray[section].name
        } else {
            print("No objects")
        }
        header.dropDownButton.tag = section
        header.arrowSelectionButton.rotate(parentArray[section].collapsed ? 0.0 : CGFloat(M_PI_2))
        header.dropDownButton.addTarget(self, action: #selector(MenuViewController.toggleCollapse), forControlEvents: .TouchUpInside)
        
        return header.contentView
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MenuDetailsHeaderTableViewCell = tableView.dequeueReusableCellWithIdentifier("menuDetailsHeaderIdentifier") as! MenuDetailsHeaderTableViewCell

        subChildArray = childArray.filter({
            if (parentArray[indexPath.section].category_id == $0.parent_id) {
                return true
            }
            return false
        })

        if subChildArray.count > 0 {
            let filterArr = subChildArray[indexPath.row]
            cell.headerlabel?.text = filterArr.name
        }
        
        cell.headerLabelButton.tag = indexPath.row
        cell.headerLabelButton.addTarget(self, action: #selector(MenuViewController.subChildClicked(_:)), forControlEvents: .TouchUpInside)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    }
    
    func subChildClicked(sender: UIButton) {
        let cell = sender.superview!.superview as! MenuDetailsHeaderTableViewCell
        let indexPath = menuTableView.indexPathForCell(cell)
        
        subChildArray = childArray.filter({
            if (parentArray[(indexPath?.section)!].category_id == $0.parent_id) {
                return true
            }
            return false
        })
        
        selectedCategoryLIst = subChildArray[(indexPath?.row)!]
        
        let sb = UIStoryboard(name: "Customer", bundle: nil)
        let vc1 = sb.instantiateViewControllerWithIdentifier("CustomerMenuItems") as! CustomerMenuItemsViewController

        vc1.fromMenuToProductPage = "goToProductsPage"
        vc1.selectedCategoryLIst = subChildArray[(indexPath?.row)!]
     
        let nc = UINavigationController(rootViewController: vc1)
        nc.setViewControllers([vc1], animated: true)
        self.revealViewController().setFrontViewController(nc, animated: false)
        self.revealViewController().setFrontViewPosition(FrontViewPosition.Right, animated: false)
          self.revealViewController().revealToggleAnimated(true)
    }
    
    //let vc = CustomerMenuItemsViewController()
    
    func toggleCollapse(sender: UIButton) {
        let section = sender.tag
        let collapsed = parentArray[section].collapsed
        
        // Toggle collapse
      parentArray[section].collapsed = !collapsed
        
        subChildArray = childArray.filter({
            if (parentArray[section].category_id == $0.parent_id) {
                return true
            }
            return false
        })
        
        selectedCategoryLIst = parentArray[section]


        // Reload section
        self.menuTableView.reloadSections(NSIndexSet(index: section), withRowAnimation: .Automatic)
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navVC = segue.destinationViewController as! UINavigationController
        
        let vc = navVC.viewControllers.first as! CustomerMenuItemsViewController
        
            vc.fromMenuToProductPage = "goToProductsPage"
            vc.selectedCategoryLIst = selectedCategoryLIst
    }
 

}
