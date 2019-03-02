//
//  ClassSetupViewController - UISetup.swift
//  Engage
//
//  Created by Brandon David on 11/6/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import UIKit


extension ClassSetupViewController {    
    
    func setupUI() {
        view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        
        setupHeader()
        setupButton()
        setupClassName()
        setupClassDate()
        setupTime()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        classNameField.resignFirstResponder()
    }
    
    func setupButton(){
        
        let createClassButton = UIButton.init(frame: CGRect.init(x:  view.frame.width / 2 - view.frame.width / 3, y: 10 * (view.frame.height - navBarHeight) / 12, width: 2*view.frame.width/3, height: 50))
        createClassButton.backgroundColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        createClassButton.layer.cornerRadius = 5.0
        createClassButton.tintColor = UIColor.white
        createClassButton.setTitle("CREATE CLASS", for: .normal)
        createClassButton.titleLabel?.font = UIFont(name: "Quicksand-Bold", size: 18)
        createClassButton.addTarget(nil, action: #selector(addSectionToFirebase), for: .touchUpInside)
        self.view.addSubview(createClassButton)
        
    }

    
    func setupHeader() {
        let headerLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50))
        headerLabel.center = CGPoint.init(x: view.frame.width / 2, y: 2.25 * (view.frame.height - navBarHeight) / 12)
        headerLabel.text = "Set up a class"
        headerLabel.textAlignment = .center
        headerLabel.textColor = UIColor.white
        headerLabel.font = UIFont(name: "Quicksand-Bold", size: 36)
        self.view.addSubview(headerLabel)
    }
    
    func setupClassName() {
        let classNameLabel = UILabel.init(frame: CGRect.init(x: view.frame.width / 2 - view.frame.width / 3 , y: 3 * (view.frame.height - navBarHeight) / 12, width: view.frame.width, height: 50))
        classNameLabel.text = "Class Name"
        classNameLabel.textColor = UIColor.white
        classNameLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        self.view.addSubview(classNameLabel)
        
        classNameField = UITextField.init(frame: CGRect.init(x:  view.frame.width / 2 - view.frame.width / 3, y: 4 * (view.frame.height - navBarHeight) / 12, width: 2 * view.frame.width / 3, height: 50))
        classNameField.placeholder = "Enter your class name"
        classNameField.font = UIFont(name: "Quicksand-Bold", size: 18)
        classNameField.backgroundColor = UIColor.white
        classNameField.layer.cornerRadius = 5.0
        classNameField.textAlignment = .center
        self.view.addSubview(classNameField)
    }
    
    func setupClassDate() {
        
        let dateLabel = UILabel.init(frame: CGRect.init(x: view.frame.width / 2 - view.frame.width / 3, y: 5 * (view.frame.height - navBarHeight) / 12, width: view.frame.width, height: 50))
        dateLabel.text = "Date"
        dateLabel.textColor = UIColor.white
        dateLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        self.view.addSubview(dateLabel)
        
        
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        txtDatePicker = UITextField(frame: CGRect.init(x:  view.frame.width / 2 - view.frame.width / 3, y: 6 * (view.frame.height - navBarHeight) / 12 , width: 2 * view.frame.width / 3, height: 50));
        txtDatePicker.placeholder = "mm/dd/yyyy"
        txtDatePicker.font = UIFont(name: "Quicksand-Bold", size: 18)
        txtDatePicker.backgroundColor = UIColor.white
        txtDatePicker.layer.cornerRadius = 5.0
        txtDatePicker.textAlignment = .center
        view.addSubview(txtDatePicker)
        
        showDatePicker()
    
    }
    
    func setupTime() {
        
        
        let startLabel = UILabel.init(frame: CGRect.init(x: view.frame.width / 2 - view.frame.width / 3, y:  7 * (view.frame.height - navBarHeight) / 12, width: view.frame.width, height: 50))
       
        startLabel.text = "Start Time"
        startLabel.textColor = UIColor.white
        startLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        self.view.addSubview(startLabel)
        
        
        startTimePicker = UIDatePicker()
        startTimePicker.datePickerMode = .time
        startTxtTimePicker = UITextField(frame: CGRect.init(x:  view.frame.width / 2 - view.frame.width / 3, y: 8 * (view.frame.height - navBarHeight) / 12, width: view.frame.width / 3 - 5, height: 50));
        startTxtTimePicker.placeholder = "hh:mm"
        startTxtTimePicker.font = UIFont(name: "Quicksand-Bold", size: 18)
        startTxtTimePicker.backgroundColor = UIColor.white
        startTxtTimePicker.layer.cornerRadius = 5.0
        startTxtTimePicker.textAlignment = .center
        view.addSubview(startTxtTimePicker)
        
        
        let endLabel = UILabel.init(frame: CGRect.init(x: view.frame.width / 2, y: 7 * (view.frame.height - navBarHeight) / 12, width: view.frame.width, height: 50))
        endLabel.text = "End Time"
        endLabel.textColor = UIColor.white
        endLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        self.view.addSubview(endLabel)
        
        endTimePicker = UIDatePicker()
        endTimePicker.datePickerMode = .time
        endTxtTimePicker = UITextField(frame: CGRect.init(x: view.frame.width / 2 + 5, y: 8 * (view.frame.height - navBarHeight) / 12, width: view.frame.width / 3 - 5, height: 50));
        endTxtTimePicker.placeholder = "hh:mm"
        endTxtTimePicker.font = UIFont(name: "Quicksand-Bold", size: 18)
        endTxtTimePicker.backgroundColor = UIColor.white
        endTxtTimePicker.layer.cornerRadius = 5.0
        endTxtTimePicker.textAlignment = .center

        view.addSubview(endTxtTimePicker)
        
        showStartTimePicker()
        showEndTimePicker()
        
        
    }
    
    


    func showDatePicker() {

        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
        
    }
    
    func showStartTimePicker() {
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneStartTimePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelStartTimePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        startTxtTimePicker.inputAccessoryView = toolbar
        startTxtTimePicker.inputView = startTimePicker
        
    }
    
    
    func showEndTimePicker() {
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEndTimePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelEndTimePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        endTxtTimePicker.inputAccessoryView = toolbar
        endTxtTimePicker.inputView = endTimePicker
        
        
    }
    
    @objc func donedatePicker() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        txtDatePicker.text = formatter.string(from: datePicker.date)
        date = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    
    @objc func doneStartTimePicker() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        startTxtTimePicker.text = formatter.string(from: startTimePicker.date)
        date = formatter.string(from: startTimePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelStartTimePicker(){
        self.view.endEditing(true)
    }
    
    @objc func doneEndTimePicker() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        endTxtTimePicker.text = formatter.string(from: endTimePicker.date)
        date = formatter.string(from: endTimePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelEndTimePicker(){
        self.view.endEditing(true)
    }
    
}
