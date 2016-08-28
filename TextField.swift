//
//  TextField.swift
//  Sahayyam
//
//  Created by Sanjeev Jikamade on 28/07/16.
//  Copyright © 2016 Sanjeev Jikamade. All rights reserved.
//

import UIKit

enum TextFieldStyle {
    case TextFieldUserName
    case TextFieldPassword
    case TextFieldDOB
    case MobileNumber
    case EmailID
    case Pincode
    case TextfieldNames
}


class TextField: UITextField , UITextFieldDelegate {
    
    var textFieldStyle = String()

    override func awakeFromNib() {

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func setTextFieldStyle(style: TextFieldStyle){
        self.autocorrectionType = .No
        switch style{
        case .TextFieldUserName:
            self.delegate = self
            textFieldStyle = "TextFieldUserName"
            self.keyboardType = .PhonePad
        case .TextFieldPassword:
            self.delegate = self
            self.secureTextEntry = true
            textFieldStyle = "TextFieldPassword"
            self.keyboardType = .Default
        case .TextFieldDOB:
            self.delegate = self
            textFieldStyle = "TextFieldDOB"
        case .MobileNumber:
            self.delegate = self
            textFieldStyle = "MobileNumber"
            self.keyboardType = .PhonePad
        case .EmailID:
            self.delegate = self
            textFieldStyle = "EmailID"
            self.keyboardType = .Default
        case .Pincode:
            self.delegate = self
            textFieldStyle = "Pincode"
            self.keyboardType = .PhonePad
        case .TextfieldNames:
            self.delegate = self
            textFieldStyle = "TextfieldNames"
            self.keyboardType = .Default
        }
    }

    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        switch textFieldStyle {
        case "TextFieldDOB":
            addDatePickerToTextField()
        default:
            print("Nothing")
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch textFieldStyle {
        case "TextFieldUserName":
            guard let text = textField.text else { return true }
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 10
        case "TextfieldNames":
            guard let text = textField.text else { return true }
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 20
        case "TextFieldPassword":
            guard let text = textField.text else { return true }
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 15
        case "TextFieldDOB":
            return false
        case "MobileNumber":
            guard let text = textField.text else { return true }
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 10
        case "Pincode":
            guard let text = textField.text else { return true }
            let newLength = text.utf16.count + string.utf16.count - range.length
            return newLength <= 6
        case "EmailID":
            return true
        default:
            return false
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.endEditing(true)
        if(textFieldStyle == "TextFieldDOB"){
            if self.text!.isEmpty{
                let date = NSDate()
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.text = dateFormatter.stringFromDate(date)
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        self.resignFirstResponder()
        return true
    }
    
  // Mark: - Adding Date picker to textfield
    
    private func addDatePickerToTextField(){
        
        let datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        datePickerView.maximumDate = NSDate()
        datePickerView.backgroundColor = UIColor.whiteColor()
        self.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(TextField.handleDatePicker(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if !self.text!.isEmpty {
            let currentDate = self.text
            let date = dateFormatter.dateFromString(currentDate!)
            datePickerView.setDate(date!, animated: false)
        }
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.text = dateFormatter.stringFromDate(sender.date)
    }
    
    
    func isValidEmail(emailString: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(emailString)
        
        if(result == true){
            return result
        }
        
        return result
    }
    
//    private func setupDOBtextField(){
//        let calendarImage = UIImage(named: kWhiteCalenderIcon)
//        let calenderImageView = UIImageView(image: calendarImage)
//        self.rightView = calenderImageView
//        self.rightViewMode = UITextFieldViewMode.Always
//        rightPadding = 50
//    }
    
}




