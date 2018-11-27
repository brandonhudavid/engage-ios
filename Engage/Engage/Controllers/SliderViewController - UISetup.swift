//
//  SliderViewController - UISetup.swift
//  Engage
//
//  Created by Brandon David on 11/20/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import UIKit

extension SliderViewController {
    
    func setupUI() {
        self.view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        setupLabel()
    }
    
    func setupLabel () {
        let welcomeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.height, height: 50))
        welcomeLabel.center = CGPoint(x: view.frame.width - 30, y: view.frame.height / 2 + 50)
        welcomeLabel.textAlignment = .center
        welcomeLabel.transform = CGAffineTransform(rotationAngle: CGFloat(3 * Double.pi / 2))
        welcomeLabel.text = "Welcome, Kayli."
        //welcomeLabel.text  = "Welcome, " + self.userName + "."
        welcomeLabel.textColor = UIColor.white
        welcomeLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        view.addSubview(welcomeLabel)
    }
    
    
    func setupSlider() {
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: view.frame.height - 250, height: view.frame.width - 120))
        slider.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 + 50)
        let thumbImage = UIImage(named: "slider_thumb")
        slider.setThumbImage(thumbImage, for: .normal)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(3 * Double.pi / 2))
        slider.maximumTrackTintColor = UIColor.clear
        slider.minimumTrackTintColor = UIColor.clear
        let slider_back = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.height - 250, height: view.frame.width - 120))
        slider_back.image = UIImage(named: "slider_track")
        slider_back.transform = CGAffineTransform(rotationAngle: CGFloat(3 * Double.pi / 2))
        slider_back.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 + 50)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.addTarget(self, action: #selector(numberValueChanged), for: UIControl.Event.valueChanged)
        view.addSubview(slider_back)
        view.addSubview(slider)
        
    }
    
}
