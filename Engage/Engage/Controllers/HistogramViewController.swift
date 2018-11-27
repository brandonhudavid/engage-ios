//
//  HistogramViewController.swift
//  Engage
//
//  Created by Shubha Jagannatha on 11/10/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit
import Charts
import Firebase
import FirebaseCore
import FirebaseAuth


class HistogramViewController: UIViewController {

    
    var sectionName : String!
    var sectionNameLabel : UILabel!
    var magicWordLabel : UILabel!
    var magicWord : Int!
    var barView : BarChartView!
    var threshold : Float!
    var slider : UISlider!
    var numStudentsLabel : UILabel!
    var pieChartLabelR : UILabel!
    var pieChartLabelL : UILabel!
    var sectionRefKey : String!
    @IBOutlet var label: UILabel!
    @IBOutlet var pieChartViewL: PieChartView!
    @IBOutlet var pieChartViewR: PieChartView!
    @IBOutlet weak var timelineView: UIView!
    var counts : [Int] = []
    var countValid : Int!
    var userIDs : [String] = []
    var timer = Timer()
    var first = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSectionData(completion: {
        })
        scheduledTimerWithTimeInterval()
        
        // Do any additional setup after loading the view.
    }


    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.updateData), userInfo: nil, repeats: true)
    }
    
 
    
    func getSectionData(completion: @escaping () -> ()) {
        let tempref = Database.database().reference()
        if let sectionRefKey = sectionRefKey {
            tempref.child("Sections").child(sectionRefKey).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    if let value = snapshot.value as? NSDictionary {
                        self.sectionName = value["section_id"] as? String ?? ""
                        print(self.sectionName!)
                        self.magicWord = value["magic_key"] as? Int ?? 000
                        print(self.magicWord!)
                        let dict = value["user_ids"] as? NSDictionary
                        self.userIDs = dict?.allKeys as? [String] ?? []
                        print(self.userIDs)
                        self.getStudentValues (completion: {})
                    } else {
                        print("NO USER FOUND")
                    }
            
                // ...
            }) { (error) in
                print("ERROR IN FINDING USER")
                print(error.localizedDescription)
                completion()
            }
        } else {
            sectionName = "No name" ///generate new magic key and stuff here
            magicWord = 000
            userIDs = []
            
        }
    }
    
    
    func getStudentValues(completion: @escaping () -> ()) {
        let tempref = Database.database().reference()
        tempref.child("UserSessions").observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                 for userID in self.userIDs {
                    let user = value[userID] as? NSDictionary
                    self.counts = []
                    if let value = user?.value(forKey: "user_id") as? Int {
                        self.counts.append(value)
                    }
                    print(userID)
                    print(self.counts)
                    if self.first {
                        self.setupPage()
                        self.first = false
                    } else {
                        self.updatePage()
                    }
                }
            } else {
                print("NO USER FOUND")
            }
            
            // ...
        }) { (error) in
            print("ERROR IN FINDING USER")
            print(error.localizedDescription)
            completion()
        }
    }

    func setLeftPieChart() {
        pieChartViewL = PieChartView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        pieChartViewL.center = CGPoint(x: view.frame.width / 4, y: view.frame.height - 180)
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
        view.addSubview(pieChartViewL)
        
        
        
        pieChartLabelL = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        pieChartLabelL.center = CGPoint(x: view.frame.width / 4, y: view.frame.height - 180)
        pieChartLabelL.textAlignment = .center
        pieChartLabelL.text  = String(belowOrEqual)
        pieChartLabelL.textColor = UIColor.white
        pieChartLabelL.font = UIFont(name: "Quicksand-Bold", size: 25)
        view.addSubview(pieChartLabelL)
    }
    
    
    
    func setRightPieChart() {
        pieChartViewR = PieChartView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        pieChartViewR.center = CGPoint(x: 3 * view.frame.width / 4, y: view.frame.height - 180)
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
        view.addSubview(pieChartViewR)
        
        
        pieChartLabelR = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        pieChartLabelR.center = CGPoint(x: 3 * view.frame.width / 4, y: view.frame.height - 180)
        pieChartLabelR.textAlignment = .center
        pieChartLabelR.text  = String(above)
        pieChartLabelR.textColor = UIColor.white
        pieChartLabelR.font = UIFont(name: "Quicksand-Bold", size: 25)
        view.addSubview(pieChartLabelR)
    }
    



    func updateChartWithData() {
        setLabel(counts: counts)
        barView = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: view.frame.height / 2 - 50))
        barView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2 - 50)
        var dataEntries: [BarChartDataEntry] = []
        var colors : [UIColor] = []
//        let visitorCounts = getVisitorCountsFromDatabase()
        
        for i in 0..<counts.count {
            let dataEntry = BarChartDataEntry(x:Double((counts[i] / 10) * 10 + 5), y:  Double(i))
            dataEntries.append(dataEntry)
            colors.append(setColor(value: Double((counts[i] / 10) * 10 + 5)))
        }

        let dataEntry_100 = BarChartDataEntry(x:Double(100), y:  Double(0))
        dataEntries.append(dataEntry_100)
        let dataEntry_0 = BarChartDataEntry(x:Double(0), y:  Double(0))
        dataEntries.append(dataEntry_0)

        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Student Input")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = Double(9)
        if counts.count != 0 {
            chartDataSet.colors = colors
        }
        chartData.setDrawValues(false)
        barView.xAxis.labelTextColor = UIColor.white
        barView.leftAxis.labelTextColor = UIColor.white
        barView.rightAxis.labelTextColor = UIColor.white
        barView.legend.enabled = false
        barView.isUserInteractionEnabled = false
        barView.data = chartData
        

        view.addSubview(barView)
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
    
    
    
    func updatePage() {
        clearPage()
        self.updateChartWithData()
        self.setLeftPieChart()
        self.setRightPieChart()
    }
    


    func clearPage() {
         if let sectionNameLabel = sectionNameLabel, let magicWordLabel = magicWordLabel, let numStudentsLabel = numStudentsLabel, let barView = barView, let pieChartViewL = pieChartViewL, let pieChartViewR = pieChartViewR, let pieChartLabelL = pieChartLabelL, let pieChartLabelR = pieChartLabelR {
            numStudentsLabel.removeFromSuperview()
            barView.removeFromSuperview()
            pieChartViewL.removeFromSuperview()
            pieChartViewR.removeFromSuperview()
            pieChartLabelL.removeFromSuperview()
            pieChartLabelR.removeFromSuperview()
        }
    }
    
    @objc func updateData() {
        if let sectionNameLabel = sectionNameLabel, let magicWordLabel = magicWordLabel, let numStudentsLabel = numStudentsLabel {
            sectionNameLabel.removeFromSuperview()
            magicWordLabel.removeFromSuperview()
            numStudentsLabel.removeFromSuperview()
            getSectionData(completion: {})
        }
    }


    @objc func numberValueChanged() {
        threshold = Float(100) * slider.value / slider.maximumValue
        updatePage()
    }

}



// MARK: axisFormatDelegate
//extension HistogramViewController: IAxisValueFormatter {
//
//    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = “HH:mm.ss”
//        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
//    }
//}
