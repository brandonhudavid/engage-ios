//
//  LogInViewController - UISetup.swift
//  Engage
//
//  Created by Brandon David on 11/6/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import UIKit

extension LogInViewController {
    
    func setupUI() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        setUpLabel()
        setUpTextField()
        setUpButtons()
        setupImage()
    }
    
    func setUpLabel() {
        let engageLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50))
        engageLabel.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2 - 50)
        
        engageLabel.text = "Engage"
        engageLabel.textColor = UIColor.white
        engageLabel.font = UIFont(name: "Quicksand-Bold", size: 32)
        engageLabel.textAlignment = .center
        self.view.addSubview(engageLabel)
    }
    
    func setUpTextField() {
        nameField = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: 3*view.frame.width/5, height: 50))
        nameField.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2 + 25)
        nameField.backgroundColor = UIColor.white
        if let savedName = UserDefaults.standard.string(forKey: "name"), savedName != "" {
            nameField.text = savedName
        } else {
            nameField.placeholder = "  Enter your name"
        }
        nameField.layer.cornerRadius = 5.0
        nameField.font = UIFont(name: "Quicksand-Bold", size: 18)
        nameField.textAlignment = .center

        self.view.addSubview(nameField)
    }
    
    func setUpButtons() {
        let studentButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width/2, height: 50))
        studentButton.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2 + 100)
        studentButton.backgroundColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        studentButton.layer.cornerRadius = 5.0
        studentButton.tintColor = UIColor.white
        studentButton.setTitle("JOIN AS STUDENT", for: .normal)
        studentButton.titleLabel?.font = UIFont(name: "Quicksand-Bold", size: 18)
        studentButton.addTarget(nil, action: #selector(studentPressed), for: .touchUpInside)
        self.view.addSubview(studentButton)
        
        let teacherButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width/2, height: 50))
        teacherButton.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2 + 150)
        teacherButton.layer.cornerRadius = 5.0
        teacherButton.tintColor = UIColor.white
        teacherButton.setTitle("JOIN AS TEACHER", for: .normal)
        teacherButton.titleLabel?.font = UIFont(name: "Quicksand-Bold", size: 14)
        teacherButton.addTarget(nil, action: #selector(teacherPressed), for: .touchUpInside)
        self.view.addSubview(teacherButton)
    }
    
    func setupImage() {
        let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        icon.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2 - 150)
        icon.image = UIImage(named: "EngageAppIconCircle")
        view.addSubview(icon)
    }
}
