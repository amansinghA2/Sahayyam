//
//  MenuViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit



class MenuViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var menuTableView: UITableView!
    var isSelected = false
    var num = 3
    var array:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tokenCheck()
        let nib = UINib(nibName: "MenuTableViewCell", bundle: nil)
        menuTableView.registerNib(nib, forCellReuseIdentifier: "menuCell")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSelected) {
            return num + 1
        } else {
            return num
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:MenuTableViewCell = tableView.dequeueReusableCellWithIdentifier("menuCell") as! MenuTableViewCell
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.orangeColor().CGColor
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //  numbers.removeAtIndex(indexPath.row)
        //  tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        menuSelected()
    }
    
    func menuSelected() {
        let indexPath = menuTableView.indexPathForSelectedRow
        let currentCell = menuTableView.cellForRowAtIndexPath(indexPath!)! as! MenuTableViewCell
        isSelected = !isSelected
        if isSelected {
            currentCell.dropDownImage.image = UIImage(named: "arw_lt")
        }else{
            currentCell.dropDownImage.image = UIImage(named: "arw_down")
           self.menuTableView.reloadSections(NSIndexSet(index:(indexPath?.section)!), withRowAnimation: .Fade)
        }
        self.menuTableView.reloadData()
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
