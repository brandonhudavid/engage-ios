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
        welcomeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.height, height: 50))
        welcomeLabel.center = CGPoint(x: view.frame.width - 30, y: view.frame.height / 2 + 50)
        welcomeLabel.textAlignment = .center
        welcomeLabel.transform = CGAffineTransform(rotationAngle: CGFloat(3 * Double.pi / 2))
        welcomeLabel.text  = "Welcome, " + self.userName + "."
        welcomeLabel.textColor = UIColor.white
        welcomeLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        view.addSubview(welcomeLabel)
    }
    
    
    func setupSlider() {
        let sliderWidth = view.frame.height * 0.8
        let sliderHeight = view.frame.width * 0.7
        let navBarHeight = CGFloat(self.navigationController?.navigationBar.frame.size.height ?? 50)
        
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: sliderWidth, height: sliderHeight))
        slider.center = CGPoint(x: view.frame.width / 2, y: (view.frame.height + navBarHeight) / 2)
        
        let thumbImage = UIImage(named: "slider_thumb")
        slider.setThumbImage(thumbImage, for: .normal)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(3 * Double.pi / 2))
        slider.maximumTrackTintColor = UIColor.clear
        slider.minimumTrackTintColor = UIColor.clear
        
        slider_back = UIImageView(frame: CGRect(x: 0, y: 0, width: sliderWidth, height: sliderHeight))
        slider_back.image = UIImage(named: "slider_track")
        slider_back.transform = CGAffineTransform(rotationAngle: CGFloat(3 * Double.pi / 2))
        slider_back.center = CGPoint(x: view.frame.width / 2, y: (view.frame.height  + navBarHeight) / 2 )
        slider.minimumValue = 0
        slider.maximumValue = 99
        slider.value = 50
        slider.addTarget(self, action: #selector(numberValueChanged), for: UIControl.Event.valueChanged)
        view.addSubview(slider_back)
        view.addSubview(slider)
        
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
            view.addSubview(slider_back)
            view.addSubview(slider)
            view.addSubview(welcomeLabel)
            self.bothView.alpha = 0
        case 1:
            self.bothView.alpha = 1
            slider.removeFromSuperview()
            slider_back.removeFromSuperview()
            welcomeLabel.removeFromSuperview()
            
            
            
            
            
        default:
            break
        }
    }
    
}
