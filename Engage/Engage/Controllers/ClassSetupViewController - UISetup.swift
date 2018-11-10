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
        setupClassName()
        setupClassDate()
        
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
        classNameLabel.text = "Class Name"
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
        let datePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 250))
        datePicker.center = CGPoint.init(x: view.frame.width/2, y: 500)
        datePicker.datePickerMode = .time
        datePicker.backgroundColor = UIColor.white
//        datePicker.layer.cornerRadius = 8.0
        self.view.addSubview(datePicker)
    }
    
}
