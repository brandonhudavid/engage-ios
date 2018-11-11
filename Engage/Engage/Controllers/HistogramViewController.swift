//
//  HistogramViewController.swift
//  Engage
//
//  Created by Shubha Jagannatha on 11/10/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit
import Charts
import RealmSwift



class HistogramViewController: UIViewController {



    var barView : BarChartView!
    var threshold = 50

    @IBOutlet var label: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor =  UIColor(red: 6/255, green: 38/255, blue: 51/255, alpha: 1)

        updateChartWithData()


        // Do any additional setup after loading the view.
    }


    func updateChartWithData() {
        barView = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: view.frame.height / 2))
        barView.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        var dataEntries: [BarChartDataEntry] = []
        var colors : [UIColor] = []
        let visitorCounts = getVisitorCountsFromDatabase()
        for i in 0..<visitorCounts.count {
            let dataEntry = BarChartDataEntry(x:Double((visitorCounts[i].count / 10) * 10 + 5), y:  Double(i))
            dataEntries.append(dataEntry)
            colors.append(setColor(value: Double((visitorCounts[i].count / 10) * 10 + 5)))
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
        barView.data = chartData

        view.addSubview(barView)
    }



    func setColor(value: Double) -> UIColor{

        if(value <= Double(threshold)){
            return UIColor(red: 47/255, green: 166/255, blue: 216/255, alpha: 1)
        }

        else if(value > Double(threshold)){
            return UIColor(red: 221/255, green: 55/255, blue: 83/255, alpha: 1)
        }

        else { //In case anything goes wrong
            return UIColor.black
        }
    }




    func getVisitorCountsFromDatabase() -> Results<Count> {
        do {
            let realm = try Realm()
            return realm.objects(Count.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
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
