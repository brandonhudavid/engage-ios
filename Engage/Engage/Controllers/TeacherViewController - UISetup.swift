//
//  TeacherViewController - UISetup.swift
//  Engage
//
//  Created by Brandon David on 11/22/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import UIKit

extension TeacherViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        setUpHeaders()
        setUpButtons()
        
    }
    
    func setUpHeaders() {
        let welcomeLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50))
        welcomeLabel.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/3)
        welcomeLabel.text = "Hi, \(name!)."
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = UIColor.white
        welcomeLabel.font = UIFont(name: "Quicksand-Bold", size: 24)
        self.view.addSubview(welcomeLabel)
        
        let newLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50))
        newLabel.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/3 + 80)
        newLabel.text = "Teaching a new section?"
        newLabel.textAlignment = .center
        newLabel.textColor = UIColor.white
        newLabel.font = UIFont(name: "Quicksand-Bold", size: 18)
        self.view.addSubview(newLabel)
        
        let resumeLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width / 2, height: 50))
        resumeLabel.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/3 + 230)
        resumeLabel.text = "Or if you already created a section:"
        resumeLabel.numberOfLines = 2
        resumeLabel.textAlignment = .center
        resumeLabel.textColor = UIColor.white
        resumeLabel.font = UIFont(name: "Quicksand-Bold", size: 18)
        self.view.addSubview(resumeLabel)
        
        
    }
    
    func setUpButtons() {
        let newButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width/2 + 20, height: 50))
        newButton.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/3 + 130)
        newButton.backgroundColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        newButton.layer.cornerRadius = 5.0
        newButton.tintColor = UIColor.white
        newButton.setTitle("CREATE NEW SECTION", for: .normal)
        newButton.titleLabel?.font = UIFont(name: "Quicksand-Bold", size: 18)
        newButton.addTarget(nil, action: #selector(createNewSection), for: .touchUpInside)
        self.view.addSubview(newButton)
        
        let resumeButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width/2 + 20, height: 50))
        resumeButton.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/3 + 290)
        resumeButton.backgroundColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        resumeButton.layer.cornerRadius = 5.0
        resumeButton.tintColor = UIColor.white
        resumeButton.setTitle("RESUME SECTION", for: .normal)
        resumeButton.titleLabel?.font = UIFont(name: "Quicksand-Bold", size: 18)
        resumeButton.addTarget(nil, action: #selector(resumeSection), for: .touchUpInside)
        self.view.addSubview(resumeButton)
        
    }
}
