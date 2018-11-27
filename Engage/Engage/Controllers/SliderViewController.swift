//
//  SliderViewController.swift
//  Engage
//
//  Created by Shubha Jagannatha on 11/10/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit
import Firebase

class SliderViewController: UIViewController {
    
    var sectionKey: String!
    var slider : UISlider!
    var userName : String!
    var welcomeLabel : UILabel!
    var slider_back : UIImageView!
    @IBOutlet weak var bothView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("sectionKey: " + sectionKey)
        setupUI()
        setupSlider()

    }

    @objc func numberValueChanged() {
        updateSlider()
    }
    
    func updateSlider() {
        let userID = UIDevice.current.identifierForVendor!.uuidString
        let tempref = Database.database().reference()
        tempref.child("UserSessions").child(userID).setValue(["slider_val" : Int(slider.value)])
    }

}
