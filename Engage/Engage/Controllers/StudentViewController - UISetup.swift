//
//  StudentViewController - UISetup.swift
//  Engage
//
//  Created by Brandon David on 11/8/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import UIKit

extension StudentViewController {
    
    func setupUI() {
        view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        setUpLabel()
        
    }
    
    func setUpLabel() {
        testLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 50))
        testLabel.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2)
        testLabel.text = sectionKey
        testLabel.textColor = UIColor.white
        self.view.addSubview(testLabel)
        
    }
    
}
