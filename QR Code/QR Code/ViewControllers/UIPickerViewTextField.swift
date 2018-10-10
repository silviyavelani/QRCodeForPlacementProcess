//
//  UIPickerViewTextField.swift
//  multiplepickerView
//
//  Created by Silviya Velani on 17/07/18.
//  Copyright © 2018 Silviya Velani. All rights reserved.
//

import UIKit

protocol UIPickerViewTextFieldDelegate {
    func doneButtonOnTaped(selectedTextfield:UITextField, name:String?, row:Int)
}

class UIPickerViewTextField: UITextField , UIPickerViewDataSource, UIPickerViewDelegate{
    
    private let picker = UIPickerView()
    private let toolBar = UIToolbar()
    
    var pickerData = [String?]() {
        didSet {
            picker.reloadAllComponents()
        }
    }
    
    var pickerDelegate : UIPickerViewTextFieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picker.dataSource = self
        picker.delegate = self
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 53/255, green: 142/255, blue: 163/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneButtonOnClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelButtonOnClicked))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.inputView = picker
        self.inputAccessoryView = toolBar
        self.tintColor = .clear
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker.tag = row
    }
    
    @objc private func doneButtonOnClicked()
    {
        if picker.tag < pickerData.count
        {
            self.text = pickerData[picker.tag]
            pickerDelegate?.doneButtonOnTaped(selectedTextfield: self, name: pickerData[picker.tag], row: picker.tag)
        }
        resignFirstResponder()
    }
    @objc private func cancelButtonOnClicked()
    {
        resignFirstResponder()
    }
    
//    copyPaste
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:))
        {
            return false
        }
        if action == #selector(UIResponderStandardEditActions.select(_:))
        {
            return false
        }
        if action == #selector(UIResponderStandardEditActions.selectAll(_:))
        {
            return false
        }
        return true
    }
    
}
