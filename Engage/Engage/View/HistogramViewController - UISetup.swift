//
//  HistogramViewController - UISetup.swift
//  Engage
//
//  Created by Shubha Jagannatha on 11/25/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import UIKit
import Charts

extension HistogramViewController {
    
    
    func setupPage() {
        self.threshold = 50
        self.view.backgroundColor =  UIColor(red: 6/255, green: 38/255, blue: 51/255, alpha: 1)
        self.updateChartWithData()
        self.setLeftPieChart()
        self.setRightPieChart()
        self.setupSlider()
//<<<<<<< Updated upstream
//        //self.setUpSegmentedControl()
//=======
////        self.setUpSegmentedControl()
//>>>>>>> Stashed changes
        //self.navigationItem.titleView = customSC
    }
    
    
    func setLabel(counts : [Int]) {
        
        sectionNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        sectionNameLabel.center = CGPoint(x: view.frame.width / 2, y: 100)
        sectionNameLabel.textAlignment = .center
        sectionNameLabel.text  = "Section Name: " + sectionName
        sectionNameLabel.textColor = UIColor.white
        sectionNameLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        view.addSubview(sectionNameLabel)
        
        magicWordLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        magicWordLabel.center = CGPoint(x: view.frame.width / 2, y: 125)
        magicWordLabel.textAlignment = .center
        magicWordLabel.text  = "Magic Word: " + String(magicWord!)
        magicWordLabel.textColor = UIColor.white
        magicWordLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        view.addSubview(magicWordLabel)
        
        
        numStudentsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        numStudentsLabel.center = CGPoint(x: view.frame.width / 2, y: view.frame.height - 200)
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
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: view.frame.width - 160, height: view.frame.height - 50))
        slider.center = CGPoint(x: view.frame.width / 2, y:  3 * view.frame.height / 4 - 85 )
        slider.maximumTrackTintColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        slider.minimumTrackTintColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.addTarget(self, action: #selector(numberValueChanged), for: UIControl.Event.valueChanged)
        view.addSubview(slider)
        slider.layer.zPosition = 1;
    }
    
    
    
    func updateChartWithData() {
        setLabel(counts: counts)
        barView = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 120, height: view.frame.height / 2 - 50))
        barView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 - 50)
        var dataEntries: [BarChartDataEntry] = []
        var colors : [UIColor] = []
        var totals = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        for i in 0..<counts.count {
            if counts[i] >= 100 {
                totals[9] += 1
            } else {
                totals[counts[i] / 10] += 1
            }
        
        }
        for i in 0..<totals.count {
            let dataEntry = BarChartDataEntry(x:Double(i * 10), y:  Double(totals[i]))
            dataEntries.append(dataEntry)
            colors.append(setColor(value: Double(i * 10)))
            
        }
        
        let dataEntry_100 = BarChartDataEntry(x:Double(95), y:  Double(0))
        dataEntries.append(dataEntry_100)
        let dataEntry_0 = BarChartDataEntry(x:Double(-5), y:  Double(0))
        dataEntries.append(dataEntry_0)
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Student Input")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = Double(9)
        if counts.count != 0 {
            chartDataSet.colors = colors
        }
        chartData.setDrawValues(false)
        barView.xAxis.labelTextColor = UIColor.clear
        barView.leftAxis.labelTextColor = UIColor.clear
        barView.rightAxis.labelTextColor = UIColor.clear
        barView.legend.enabled = false
        barView.leftAxis.drawAxisLineEnabled = false
        barView.leftAxis.drawGridLinesEnabled = false
        barView.leftAxis.gridColor = NSUIColor.clear
        barView.rightAxis.drawAxisLineEnabled = false
        barView.rightAxis.drawGridLinesEnabled = false
        barView.xAxis.enabled = false
        barView.rightAxis.gridColor = NSUIColor.clear
        barView.xAxis.drawGridLinesEnabled = false
        barView.isUserInteractionEnabled = false
        barView.data = chartData
        view.addSubview(barView)
        
        thumbs_up = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        thumbs_up.center = CGPoint.init(x: view.frame.width - 50, y: 3 * view.frame.height/4 - 100 + 5)
        thumbs_up.image = UIImage(named: "thumbs")
        view.addSubview(thumbs_up)
        
        thumbs_down = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        thumbs_down.center = CGPoint.init(x: 50, y: 3 * view.frame.height/4 - 100 + 15 )
        thumbs_down.image = UIImage(named: "thumbs")
        thumbs_down.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))

        view.addSubview(thumbs_down)
        
    }

    
    func setLeftPieChart() {
        pieChartViewL = PieChartView(frame: CGRect(x: 0, y: 0, width: 170, height: 170))
        pieChartViewL.center = CGPoint(x: view.frame.width / 4, y: view.frame.height - 100)
        var dataEntries: [PieChartDataEntry] = []
        //        let visitorCounts = getVisitorCountsFromDatabase()
        var colors: [UIColor] = []
        var belowOrEqual = 0
        for i in 0..<counts.count {
            if counts[i] <= Int(threshold) && counts[i] >= 0{
                belowOrEqual += 1
            }
        }
        if counts.count != 0 {
            let dataEntryNone = PieChartDataEntry(value: Double(100 * (counts.count - belowOrEqual) / counts.count ))
            dataEntries.append(dataEntryNone)
            colors.append(setColor(value: -1))
        }
        
        if counts.count != 0 {
            let dataEntryBelow = PieChartDataEntry(value: Double(100 * belowOrEqual / counts.count ))
            dataEntries.append(dataEntryBelow)
            colors.append(setColor(value: 1))
        }
        
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Student Input")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
        pieChartViewL.data = pieChartData
        if counts.count != 0 {
            pieChartDataSet.colors = colors
        }
        pieChartViewL.legend.enabled = false
        pieChartViewL.isUserInteractionEnabled = false
        pieChartViewL.holeColor = nil
        pieChartViewL.transparentCircleColor = nil
        pieChartViewL.holeRadiusPercent = 0.75

        view.addSubview(pieChartViewL)
        
        
        
        pieChartLabelL = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        pieChartLabelL.center = CGPoint(x: view.frame.width / 4, y: view.frame.height - 120)
        pieChartLabelL.textAlignment = .center
        pieChartLabelL.text  = String(belowOrEqual)
        pieChartLabelL.textColor = UIColor.white
        pieChartLabelL.font = UIFont(name: "Quicksand-Bold", size: 30)
        view.addSubview(pieChartLabelL)
        
        
        let studentsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        studentsLabel.center = CGPoint(x: view.frame.width / 4, y: view.frame.height - 90)
        studentsLabel.textAlignment = .center
        studentsLabel.text  = "students"
        studentsLabel.textColor = UIColor.white
        studentsLabel.font = UIFont(name: "Quicksand-Bold", size: 17)
        view.addSubview(studentsLabel)
    }
    
    
    
    func setRightPieChart() {
        pieChartViewR = PieChartView(frame: CGRect(x: 0, y: 0, width: 170, height: 170))
        pieChartViewR.center = CGPoint(x: 3 * view.frame.width / 4, y: view.frame.height - 100)
        var dataEntries: [PieChartDataEntry] = []
        //        let visitorCounts = getVisitorCountsFromDatabase()
        var colors: [UIColor] = []
        var above = 0
        for i in 0..<counts.count {
            if counts[i] > Int(threshold) && counts[i] <= 100 {
                above += 1
            }
        }
        if counts.count != 0 {
            let dataEntryAbove = PieChartDataEntry(value: Double(100 * above / counts.count ))
            dataEntries.append(dataEntryAbove)
            colors.append(setColor(value: 99))
        }
        if counts.count != 0 {
            let dataEntryNone = PieChartDataEntry(value: Double(100 * (counts.count - above) / counts.count ))
            dataEntries.append(dataEntryNone)
            colors.append(setColor(value: -1))
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Student Input")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
        pieChartViewR.data = pieChartData
        if counts.count != 0 {
            pieChartDataSet.colors = colors
        }
        pieChartViewR.legend.enabled = false
        pieChartViewR.isUserInteractionEnabled = false
        pieChartViewR.holeColor = nil
        pieChartViewR.transparentCircleColor = nil
        pieChartViewR.holeRadiusPercent = 0.75
        view.addSubview(pieChartViewR)

        
        pieChartLabelR = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        pieChartLabelR.center = CGPoint(x: 3 * view.frame.width / 4, y: view.frame.height - 120)
        pieChartLabelR.textAlignment = .center
        pieChartLabelR.text  = String(above)
        pieChartLabelR.textColor = UIColor.white
        pieChartLabelR.font = UIFont(name: "Quicksand-Bold", size: 30)
        view.addSubview(pieChartLabelR)
        
        let studentsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        studentsLabel.center = CGPoint(x: 3 * view.frame.width / 4, y: view.frame.height - 90)
        studentsLabel.textAlignment = .center
        studentsLabel.text  = "students"
        studentsLabel.textColor = UIColor.white
        studentsLabel.font = UIFont(name: "Quicksand-Bold", size: 17)
        view.addSubview(studentsLabel)
    }
    
    /*func setUpSegmentedControl(){
        
        let items = ["Now", "Timeline"]
        customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        customSC.frame = CGRect(x: 75, y: 100, width: 264, height: 25)
        customSC.layer.cornerRadius = 3.0
        customSC.backgroundColor = self.view.backgroundColor
        customSC.tintColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .normal)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .selected)
        customSC.transform = CGAffineTransform(rotationAngle: 0)
        customSC.clipsToBounds = true
        
        
        customSC.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        
        self.view.addSubview(customSC)
    }
    
    @objc func changeColor(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            shouldUpdate = true
            view.addSubview(sectionNameLabel)
            view.addSubview(magicWordLabel)
            view.addSubview(numStudentsLabel)
            view.addSubview(barView)
            view.addSubview(thumbs_up)
            view.addSubview(thumbs_down)
            view.addSubview(slider)
            scheduledTimerWithTimeInterval()
            self.timelineView.alpha = 0
        case 1:
            timer.invalidate()
            shouldUpdate = false
            sectionNameLabel.removeFromSuperview()
            magicWordLabel.removeFromSuperview()
            numStudentsLabel.removeFromSuperview()
            barView.removeFromSuperview()
            thumbs_up.removeFromSuperview()
            thumbs_down.removeFromSuperview()
            slider.removeFromSuperview()
            self.timelineView.alpha = 1
        default:
            break
        }
    }*/
}

/* func setUpSegmentedControl(){
 
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
 
 }*/
