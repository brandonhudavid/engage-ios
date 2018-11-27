//
//  HistogramViewController - UISetup.swift
//  Engage
//
//  Created by Shubha Jagannatha on 11/25/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import UIKit

extension HistogramViewController {
    
    
    func setupPage() {
        self.threshold = 50
        self.view.backgroundColor =  UIColor(red: 6/255, green: 38/255, blue: 51/255, alpha: 1)
        self.updateChartWithData()
        self.setLeftPieChart()
        self.setRightPieChart()
        self.setupSlider()
        //self.setUpSegmentedControl()
    }
    
    
    func setLabel(counts : [Int]) {
        
        sectionNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        sectionNameLabel.center = CGPoint(x: view.frame.width / 2, y: 125)
        sectionNameLabel.textAlignment = .center
        sectionNameLabel.text  = "Section Name: " + sectionName
        sectionNameLabel.textColor = UIColor.white
        sectionNameLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        view.addSubview(sectionNameLabel)
        
        magicWordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        magicWordLabel.center = CGPoint(x: view.frame.width / 2, y: 150)
        magicWordLabel.textAlignment = .center
        magicWordLabel.text  = "Magic Word: " + String(magicWord!)
        magicWordLabel.textColor = UIColor.white
        magicWordLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        view.addSubview(magicWordLabel)
        
        
        numStudentsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        numStudentsLabel.center = CGPoint(x: view.frame.width / 2, y: view.frame.height - 250)
        numStudentsLabel.textAlignment = .center
        if (counts.count == 1) {
            numStudentsLabel.text  = String(counts.count) + " Student Total"
        } else {
            numStudentsLabel.text  = String(counts.count) + " Students Total"
        }
        numStudentsLabel.textColor = UIColor.white
        numStudentsLabel.font = UIFont(name: "Quicksand-Bold", size: 21)
        view.addSubview(numStudentsLabel)
    }
    
    
    func setupSlider() {
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: view.frame.width - 100, height: view.frame.height - 50))
        slider.center = CGPoint(x: view.frame.width / 2, y: view.frame.height - 75)
        slider.maximumTrackTintColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        slider.minimumTrackTintColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.addTarget(self, action: #selector(numberValueChanged), for: UIControl.Event.valueChanged)
        view.addSubview(slider)
    }
    
    func setUpSegmentedControl(){
        
        let items = ["Now", "Timeline"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        customSC.frame = CGRect(x: view.frame.width/2, y: 20, width: 264, height: 25)
        customSC.layer.cornerRadius = 3.0
        customSC.backgroundColor = self.view.backgroundColor
        customSC.tintColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .normal)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .selected)
        customSC.clipsToBounds = true
        
        customSC.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        
        self.view.addSubview(customSC)
    }
    
    @objc func changeColor(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            view.addSubview(sectionNameLabel)
            view.addSubview(slider)
            view.addSubview(magicWordLabel)
            view.addSubview(numStudentsLabel)
            self.timelineView.alpha = 0
        case 1:
            self.timelineView.alpha = 1
            slider.removeFromSuperview()
            numStudentsLabel.removeFromSuperview()
            magicWordLabel.removeFromSuperview()
            sectionNameLabel.removeFromSuperview()
        default:
            break
        }
    }
    
    
}
