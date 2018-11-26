//
//  BothLineGraphViewController-UISetup.swift
//  Engage
//
//  Created by Kayli  Jiang on 11/26/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import UIKit

extension BothLineGraphViewController{
    
    func setUpBasics(){
        self.view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUpSegmentedControl(){
        
        let items = ["Me", "Class"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        customSC.frame = CGRect(x: -103, y: view.frame.height/2 + 37, width: 264, height: 25)
        customSC.layer.cornerRadius = 3.0  
        customSC.backgroundColor = self.view.backgroundColor
        customSC.tintColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .normal)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .selected)
        customSC.clipsToBounds = true
        customSC.transform = CGAffineTransform(rotationAngle: 3*CGFloat.pi/2)
        
        customSC.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        
        self.view.addSubview(customSC)
    }
    
    @objc func changeColor(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            break
        case 1:
            performSegue(withIdentifier: "toMe", sender: self)
        default:
            break
        }
    }
}
