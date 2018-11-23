//
//  MagicWordViewController - UISetup.swift
//  Engage
//
//  Created by Brandon David on 11/6/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import UIKit

extension MagicWordViewController {
    
    
    func setupUI() {
        view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        setUpWelcomeLabel()
        setUpTextField()
        setUpButtons()
        
    }
    
    func setUpWelcomeLabel() {
        welcomeLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50))
        welcomeLabel.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2 - 60)
        welcomeLabel.text = "Hi, \(name!)."
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = UIColor.white
        welcomeLabel.font = UIFont(name: "Quicksand-Bold", size: 24)
        self.view.addSubview(welcomeLabel)
        
        let promptLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50))
        promptLabel.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2 - 30)
        promptLabel.text = "Enter magic word:"
        promptLabel.textAlignment = .center
        promptLabel.textColor = UIColor.white
        promptLabel.font = UIFont(name: "Quicksand-Bold", size: 18)
        self.view.addSubview(promptLabel)
    }
    
    func setUpTextField() {
        magicWordField = UITextField.init(frame: CGRect.init(x: 0, y: 0, width: 3*view.frame.width/5, height: 50))
        magicWordField.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2 + 25)
        magicWordField.keyboardType = .numberPad
        magicWordField.backgroundColor = UIColor.white
        magicWordField.placeholder = " Magic code"
        magicWordField.layer.cornerRadius = 5.0
        magicWordField.font = UIFont(name: "Quicksand-Bold", size: 18)
        self.view.addSubview(magicWordField)
    }
    
    func setUpButtons() {
        let joinButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width/2, height: 50))
        joinButton.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2 + 100)
        joinButton.backgroundColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        joinButton.layer.cornerRadius = 5.0
        joinButton.tintColor = UIColor.white
        joinButton.setTitle("JOIN CLASS", for: .normal)
        joinButton.titleLabel?.font = UIFont(name: "Quicksand-Bold", size: 18)
        joinButton.addTarget(nil, action: #selector(joinPressed), for: .touchUpInside)
        self.view.addSubview(joinButton)
        
    }
    
}


