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
    var counts : [Int] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSectionData(completion: {
            
        })
        
        // Do any additional setup after loading the view.
    }

    
    func setupPage() {
        self.counts = [22, 32, 43, 55, 6, 55, 66, 77, 99, 1, 2, 3, 4, 4, 15, 15, 16, 17, 28, 29, 44, 44]
        self.magicWord = 799 //currently hardcoded
        self.threshold = 50
        self.view.backgroundColor =  UIColor(red: 6/255, green: 38/255, blue: 51/255, alpha: 1)
        self.updateChartWithData()
        self.setLeftPieChart()
        self.setRightPieChart()
        self.setupSlider()
    }
    
    func getSectionData(completion: @escaping () -> ()) {
        let tempref = Database.database().reference()
        tempref.child("Sections").child(sectionRefKey!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                if let value = snapshot.value as? NSDictionary {
                    self.sectionName = value["section_id"] as? String ?? ""
                    print(self.sectionName!)
                    self.setupPage()
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
        
        let dataEntryNone = PieChartDataEntry(value: Double(100 * (counts.count - belowOrEqual) / counts.count ))
        dataEntries.append(dataEntryNone)
        colors.append(setColor(value: -1))
        
        let dataEntryBelow = PieChartDataEntry(value: Double(100 * belowOrEqual / counts.count ))
        dataEntries.append(dataEntryBelow)
        colors.append(setColor(value: 1))
        
       
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Student Input")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
        pieChartViewL.data = pieChartData
        pieChartDataSet.colors = colors
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
        
        let dataEntryAbove = PieChartDataEntry(value: Double(100 * above / counts.count ))
        dataEntries.append(dataEntryAbove)
        colors.append(setColor(value: 99))
        
        let dataEntryNone = PieChartDataEntry(value: Double(100 * (counts.count - above) / counts.count ))
        dataEntries.append(dataEntryNone)
        colors.append(setColor(value: -1))
        
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Student Input")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartData.setDrawValues(false)
        pieChartViewR.data = pieChartData
        pieChartDataSet.colors = colors
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
        chartDataSet.colors = colors
        chartData.setDrawValues(false)
        barView.xAxis.labelTextColor = UIColor.white
        barView.leftAxis.labelTextColor = UIColor.white
        barView.rightAxis.labelTextColor = UIColor.white
        barView.legend.enabled = false
        barView.isUserInteractionEnabled = false
        barView.data = chartData
        

        view.addSubview(barView)
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
        magicWordLabel.text  = "Magic Word: " + String(magicWord)
        magicWordLabel.textColor = UIColor.white
        magicWordLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        view.addSubview(magicWordLabel)
        
        
        numStudentsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        numStudentsLabel.center = CGPoint(x: view.frame.width / 2, y: view.frame.height - 250)
        numStudentsLabel.textAlignment = .center
        numStudentsLabel.text  = String(counts.count) + " Students Total"
        numStudentsLabel.textColor = UIColor.white
        numStudentsLabel.font = UIFont(name: "Quicksand-Bold", size: 21)
        view.addSubview(numStudentsLabel)
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
    
    
    
    func updatePage() {
        clearPage()
        updateChartWithData()
        setLeftPieChart()
        setRightPieChart()
    }

    func clearPage() {
        numStudentsLabel.removeFromSuperview()
        barView.removeFromSuperview()
        pieChartViewL.removeFromSuperview()
        pieChartViewR.removeFromSuperview()
        pieChartLabelL.removeFromSuperview()
        pieChartLabelR.removeFromSuperview()
    }



    @objc func numberValueChanged() {
        threshold = Float(100) * slider.value / slider.maximumValue
        updatePage()
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

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
