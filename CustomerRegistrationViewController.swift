//
//  CustomerRegistrationViewController.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 16/09/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class CustomerRegistrationViewController: UIViewController  , CNContactPickerDelegate{

    @IBOutlet weak var contactTextField: UITextField!
    private var store: CNContactStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.3)
        showAnimate()
        store = CNContactStore()
        checkContactsAccess()
        // Do any additional setup after loading the view.
    }

    
    private func checkContactsAccess() {
        switch CNContactStore.authorizationStatusForEntityType(.Contacts) {
        // Update our UI if the user has granted access to their Contacts
        case .Authorized:
            self.accessGrantedForContacts()
            
        // Prompt the user for access to Contacts if there is no definitive answer
        case .NotDetermined :
            self.requestContactsAccess()
            
        // Display a message if the user has denied or restricted access to Contacts
        case .Denied,
             .Restricted:
            let alert = UIAlertController(title: "Privacy Warning!",
                                          message: "Permission was not granted for Contacts.",
                                          preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func requestContactsAccess() {
        
        store.requestAccessForEntityType(.Contacts) {granted, error in
            if granted {
                dispatch_async(dispatch_get_main_queue()) {
                    self.accessGrantedForContacts()
                    return
                }
            }
        }
    }
    
    // This method is called when the user has granted access to their address book data.
    private func accessGrantedForContacts() {
        // Load data from the plist file
//        let plistPath = NSBundle.mainBundle().pathForResource("Menu", ofType:"plist")
//        self.menuArray = NSMutableArray(contentsOfFile: plistPath!)
//        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func contactsPageOpen(sender: AnyObject) {
        
        showContactPickerController()
        
    }
    
    private func showContactPickerController() {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        
        // Display only a person's phone, email, and birthdate
        let displayedItems = [CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactBirthdayKey]
        picker.displayedPropertyKeys = displayedItems
        
        // Show the picker
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func saveRegistration(sender: AnyObject) {
        removeAnimate()
    }
    
    @IBOutlet weak var cancelRegistration: UIButton!
    
    
    @IBAction func cancelRegistrationAction(sender: AnyObject) {
        removeAnimate()
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    
    //MARK: CNContactPickerDelegate methods
    // The selected person and property from the people picker.
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        
        let contact = contactProperty.contact
        let _ = CNContactFormatter.stringFromContact(contact, style: .FullName) ?? ""
        let _ = CNContact.localizedStringForKey(contactProperty.key)
        
        contactTextField.text = String(contact.phoneNumbers)
        
        for phoneNo in contact.phoneNumbers {
            
//            if phoneNo.label == CNLabelPhoneNumberMobile {
                contactTextField.text = (phoneNo.value as! CNPhoneNumber).valueForKey("digits") as? String
                
//            }
        }
       // contactTextField.text = String(contact)
        
//        dispatch_async(dispatch_get_main_queue()) {
//            let alert = UIAlertController(title: "Picker Result",
//                                          message: message,
//                                          preferredStyle: .Alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//        }
    }
    
    // Implement this if you want to do additional work when the picker is cancelled by the user.
    func contactPickerDidCancel(picker: CNContactPickerViewController) {
        picker.dismissViewControllerAnimated(true, completion: {})
    }
    
    
    //MARK: CNContactViewControllerDelegate methods
    // Dismisses the new-person view controller.
    func contactViewController(viewController: CNContactViewController, didCompleteWithContact contact: CNContact?) {
        //
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func contactViewController(viewController: CNContactViewController, shouldPerformDefaultActionForContactProperty property: CNContactProperty) -> Bool {
        return true
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
