//
//  ClassLineGraphViewController.swift
//  Engage
//
//  Created by Kayli  Jiang on 11/25/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit
import Charts

class BothLineGraphViewController: UIViewController {
    
    var lineView: LineChartView!
    var counts : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    var sectionNameLabel : UILabel!
    var threshold : Float! = 70.0
    var numStudentsLabel : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBasics()
        updateChartWithData()
    }
    
    func updateChartWithData() {
        setLabel(counts: counts)
        lineView = LineChartView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: view.frame.height / 2 - 50))
        lineView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 - 50)
        lineView.drawGridBackgroundEnabled = false
        lineView.chartDescription = nil
        //lineView.xAxis.drawGridLinesEnabled = true
        lineView.xAxis.drawAxisLineEnabled = true
        
        var dataEntries: [ChartDataEntry] = []
        var colors : [UIColor] = []
        //        let visitorCounts = getVisitorCountsFromDatabase()
        var data : [Int] = [54, 34,65,23,64,76,48,97,67,44,96,46,56,87,92]
        for i in 0..<counts.count {
            let dataEntry = ChartDataEntry(x:Double(data[i]), y:  Double(i))
            dataEntries.append(dataEntry)
            colors.append(setColor(value: Double((counts[i]))))
        }
        
        let dataEntry_100 = ChartDataEntry(x:Double(100), y:  Double(0))
        dataEntries.append(dataEntry_100)
        let dataEntry_0 = ChartDataEntry(x:Double(0), y:  Double(0))
        dataEntries.append(dataEntry_0)
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "Student Input")
        let chartData = LineChartData(dataSet: chartDataSet)
        //chartData.lineWidth = Double(9)
        if counts.count != 0 {
            chartDataSet.colors = colors
        }
        chartData.setDrawValues(false)
        lineView.xAxis.labelTextColor = UIColor.white
        //lineView.leftAxis.labelTextColor = UIColor.white
        lineView.rightAxis.labelTextColor = UIColor.white
        lineView.xAxis.labelRotationAngle = -90.0
        //lineView.rightAxis.
        lineView.legend.enabled = false
        lineView.isUserInteractionEnabled = false
        lineView.data = chartData
        
        
        view.addSubview(lineView)
    }
    
    func setColor(value: Double) -> UIColor{
        
        if(value <= Double(threshold) && value >= 0){
            return UIColor(red: 47/255, green: 166/255, blue: 216/255, alpha: 1)
        }
            
        else if(value > Double(threshold) && value <= 100){
            return UIColor(red: 221/255, green: 55/255, blue: 83/255, alpha: 1)
        }
            
        else { //In case anything goes wrong
            return UIColor(red: 6/255, green: 38/255, blue: 51/255, alpha: 1)
        }
    }
    
    func setLabel(counts : [Int]) {
        
        sectionNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        sectionNameLabel.center = CGPoint(x: view.frame.width / 2, y: 125)
        sectionNameLabel.textAlignment = .center
        //sectionNameLabel.text  = "Section Name: " + sectionName
        sectionNameLabel.textColor = UIColor.white
        sectionNameLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        view.addSubview(sectionNameLabel)
        
        
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
    
    
}
