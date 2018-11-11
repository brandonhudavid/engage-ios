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
    
    
//    
//    func timesUpdated(_ clock:TenClock, startDate:Date,  endDate:Date  ) -> (){
//        //...
//    }
//    
//    func timesChanged(clock:TenClock, startDate:NSDate,  endDate:NSDate  ) -> (){
//        print("start at: \(startDate), end at: \(endDate)")
//        self.beginTimeLabel.text = dateFormatter.stringFromDate(startDate)
//        self.endTimeLabel.text = dateFormatter.stringFromDate(endDate)
//    }
//    
    
    
    func setupUI() {
        view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        
        setupHeader()
        setupClassName()
        setupClassDate()
        setupTime()
        
    }
    
    func setupHeader() {
        let headerLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50))
        headerLabel.center = CGPoint.init(x: view.frame.width/2, y: 200)
        headerLabel.text = "Set up a class"
        headerLabel.textAlignment = .center
        headerLabel.textColor = UIColor.white
        headerLabel.font = UIFont(name: "Quicksand-Bold", size: 36)
        self.view.addSubview(headerLabel)
    }
    
    func setupClassName() {
        let classNameLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50))
        classNameLabel.center = CGPoint.init(x: view.frame.width/2 + 70, y: 265)
        classNameLabel.text = " Class Name"
        classNameLabel.textColor = UIColor.white
        classNameLabel.font = UIFont(name: "Quicksand-Bold", size: 24)
        self.view.addSubview(classNameLabel)
        
        classNameField = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: 2*view.frame.width/3, height: 50))
        classNameField.center = CGPoint.init(x: view.frame.width/2, y: 315)
        classNameField.placeholder = " Enter your class name"
        classNameField.font = UIFont(name: "Quicksand-Bold", size: 18)
        classNameField.backgroundColor = UIColor.white
        classNameField.layer.cornerRadius = 5.0
        self.view.addSubview(classNameField)
    }
    
    func setupClassDate() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        txtDatePicker = UITextField(frame: CGRect.init(x: 0, y: 0, width: view.frame.width / 3, height: 50));
        txtDatePicker.center =  CGPoint.init(x: view.frame.width/2, y: 315 + 100)
        txtDatePicker.placeholder = " mm/dd/yyyy"
        txtDatePicker.font = UIFont(name: "Quicksand-Bold", size: 18)
        txtDatePicker.backgroundColor = UIColor.white
        txtDatePicker.layer.cornerRadius = 5.0
        view.addSubview(txtDatePicker)
        
        showDatePicker()
    }
    
    
    func setupTime() {
        startTimePicker = UIDatePicker()
        startTimePicker.datePickerMode = .time
        startTxtTimePicker = UITextField(frame: CGRect.init(x: 0, y: 0, width: view.frame.width / 6 - 4, height: 50));
        startTxtTimePicker.center =  CGPoint.init(x: view.frame.width/4, y: 315 + 100)
        startTxtTimePicker.placeholder = " hh:mm"
        startTxtTimePicker.font = UIFont(name: "Quicksand-Bold", size: 18)
        startTxtTimePicker.backgroundColor = UIColor.white
        startTxtTimePicker.layer.cornerRadius = 5.0
//        startTxtTimePicker.addTarget(self, action: #selector(startTimeDiveChanged), for: UIControlEvents.valueChanged)
        view.addSubview(startTxtTimePicker)
        
        endTimePicker = UIDatePicker()
        endTimePicker.datePickerMode = .time
        endTxtTimePicker = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width / 6 - 4, height: 50))
        endTxtTimePicker.center =  CGPoint(x: 3 * view.frame.width/4 , y: 315 + 80)
        endTxtTimePicker.placeholder = " hh:mm"
        endTxtTimePicker.font = UIFont(name: "Quicksand-Bold", size: 100)
        endTxtTimePicker.backgroundColor = UIColor.white
        endTxtTimePicker.layer.cornerRadius = 5.0
        view.addSubview(endTxtTimePicker)
        
        showDatePicker()
        
        
    }
    
    
    
//    @IBAction func datePickerChanged(sender: AnyObject) {
//        setDateAndTime()
//    }
//    @IBAction func timePickerChanged(sender: AnyObject) {
//        setDateAndTime()
//    }

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

    
//    func startTimeDiveChanged(sender: UIDatePicker) {
//        let formatter = DateFormatter()
//        formatter.timeStyle = .short
//        youtTextFieldName.text = formatter.string(from: sender.date)
//        timePicker.removeFromSuperview() // if you want to remove time picker
//    }
//
    
    
    
}
