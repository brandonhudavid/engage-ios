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
    var thumbs_up : UIImageView!
    var thumbs_down : UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var pieChartViewL: PieChartView!
    @IBOutlet var pieChartViewR: PieChartView!
    @IBOutlet weak var timelineView: UIView!
    var counts : [Int] = []
    var countValid : Int!
    var userIDs : [String] = []
    var timer = Timer()
    var first = true
    var customSC : UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  UIColor(red: 6/255, green: 38/255, blue: 51/255, alpha: 1)
        first = true
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
//        sectionRefKey = "2347E732-EE49-42ED-9463-F1BDF6B62700"
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
                        print("NO USER FOUND 1")
                        self.sectionName = "Invalid Section" ///generate new magic key and stuff here
                        self.magicWord = 000
                        self.userIDs = []
                        self.getStudentValues (completion: {})
                    }
            
                // ...
            }) { (error) in
                print("ERROR IN FINDING USER")
                print(error.localizedDescription)
                self.sectionName = "Invalid Section" ///generate new magic key and stuff here
                self.magicWord = 000
                self.userIDs = []
                self.getStudentValues (completion: {})
                completion()
            }
        } else {
            sectionName = "Invalid Section" ///generate new magic key and stuff here
            magicWord = 000
            userIDs = []
            self.getStudentValues (completion: {})
        }
    }
    
    
    func getStudentValues(completion: @escaping () -> ()) {
        let tempref = Database.database().reference()
        tempref.child("UserSessions").observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary {
                self.counts = []
                 for userID in self.userIDs {
                    if let user = value[userID] as? NSDictionary {
                        if let value = user.value(forKey: "slider_val") as? Int {
                            print(value)
                            self.counts.append(value)
                        }
                    }
                }
                print(self.counts)
                if self.first {
                    self.setupPage()
                    self.first = false
                } else {
                    self.updatePage()
                }
            } else {
                print("NO USER FOUND 2")
                if self.first {
                    self.setupPage()
                    self.first = false
                } else {
                    self.updatePage()
                }
            }
            
            // ...
        }) { (error) in
            print("ERROR IN FINDING USER")
            print(error.localizedDescription)
            if self.first {
                self.setupPage()
                self.first = false
            } else {
                self.updatePage()
            }
            completion()
            
        }
        //added for testing
//        self.counts = [1, 2, 14, 22, 33, 44, 44, 55, 55, 55, 55, 55, 55, 55, 55, 55, 55, 66, 66, 66, 77, 88, 99, 100]

        if self.first {
            self.setupPage()
            self.first = false
        } else {
            self.updatePage()
        }
    }

    
    




    func setColor(value: Double) -> UIColor{

        if((value <= Double(threshold) && value >= 0) && threshold != 0){
            return  UIColor(red: 221/255, green: 55/255, blue: 83/255, alpha: 1)
        }

        else if(value >= Double(threshold) && value <= 100 && threshold != 100 ){
            return UIColor(red: 47/255, green: 166/255, blue: 216/255, alpha: 1)
            
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
            getSectionData(completion: {})
            updatePage()
        }
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

