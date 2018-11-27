//
//  ClassSetupViewController.swift
//  Engage
//
//  Created by Brandon David on 11/6/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ClassSetupViewController: UIViewController {
    
    var name: String!
    
    var classNameField: UITextField!
    var datePicker : UIDatePicker!
    var txtDatePicker : UITextField!
    var date : String!
    
    
    var startTimePicker : UIDatePicker!
    var startTxtTimePicker : UITextField!
    var startTime : String!
    
    var endTimePicker : UIDatePicker!
    var endTxtTimePicker : UITextField!
    var endTime : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationController?.isNavigationBarHidden = false
        setupUI()
        

        // Do any additional setup after loading the view.
    }
    
    @objc func addSectionToFirebase() {
        guard let sectionName = classNameField.text?.trimmingCharacters(in: .whitespaces),
            !sectionName.isEmpty else {
            noSectionName()
            return
        }
        guard let sectionDate = txtDatePicker.text?.trimmingCharacters(in: .whitespaces),
            !sectionDate.isEmpty else {
            noDate()
            return
        }
        guard let startTime = startTxtTimePicker.text?.trimmingCharacters(in: .whitespaces),
            !startTime.isEmpty else {
            noStartTime()
            return
        }
        guard let endTime = endTxtTimePicker.text?.trimmingCharacters(in: .whitespaces),
            !endTime.isEmpty else {
            noEndTime()
            return
        }
        let userID = UIDevice.current.identifierForVendor!.uuidString
        let sectionRefKey = UUID().uuidString
        
        generateMagicKey(sectionRefKey) { (magicKey) in
            guard magicKey != -1 else {
                return
            }
            let sectionData: [String:AnyObject] = [
                "a_start": sectionDate + "-" + startTime as AnyObject,
                "b_end": sectionDate + "-" + endTime as AnyObject,
                "magic_key": magicKey as AnyObject,
                "ref_key": sectionRefKey as AnyObject,
                "section_id": sectionName as AnyObject,
                "ta_key": userID as AnyObject
            ]
            let dbRef = Database.database().reference()
            dbRef.child("Sections").child(sectionRefKey).setValue(sectionData)
            
            self.updateTeacher(userID) { (teacherSections) in
                guard var teacherSections = teacherSections, teacherSections != [:] else {
                    dbRef.child("Teachers").child(userID).child("name").setValue(self.name!)
                    dbRef.child("Teachers").child(userID).child("existingSections").setValue([sectionRefKey: sectionName])
                    self.performSegue(withIdentifier: "toHistogram", sender: sectionRefKey)
                    var vcs: [UIViewController] = (self.navigationController?.viewControllers)!
                    let prev = vcs.count - 2
                    vcs.remove(at: prev)
                    return
                }
                if teacherSections == ["None":"None"] {
                    return // Ignore the first Firebase query without snapshot callback.
                }
                teacherSections[sectionRefKey] = sectionName
                dbRef.child("Teachers").child(userID).child("name").setValue(self.name!)
                dbRef.child("Teachers").child(userID).child("existingSections").setValue(teacherSections)
                self.performSegue(withIdentifier: "toHistogram", sender: sectionRefKey)
                var vcs: [UIViewController] = (self.navigationController?.viewControllers)!
                let prev = vcs.count - 2
                vcs.remove(at: prev)
            }
        }
    }
    
    func generateMagicKey(_ sectionRefKey: String, completionHandler: @escaping (Int) -> ()) {
        var magicKey = String(arc4random_uniform(1000))
        let dbRef = Database.database().reference()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm"
        
        dbRef.child("MagicKeys").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                var magicKeys = snapshot.value as! [String: String]
                while magicKeys.keys.contains(magicKey) {
                    let existingKey = magicKeys[magicKey]
                    
                    magicKey = String(arc4random_uniform(1000))
                }
                magicKeys[magicKey] = sectionRefKey
                dbRef.child("MagicKeys").setValue(magicKeys)
            } else {
                dbRef.child("MagicKeys").setValue([magicKey: sectionRefKey])
            }
            completionHandler(Int(magicKey)!)
        }
        completionHandler(-1)
    }
    
    func getSectionEndTime(_ existingKey: String, completionHandler: @escaping (String) -> ()) {
        let dbRef = Database.database().reference()
        
        dbRef.child("Sections").child(existingKey).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                let section = snapshot.value as! [String: AnyObject]
                completionHandler(section["b_end"] as! String)
            }
            
        completionHandler("")
    }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHistogram", let histogramVC = segue.destination as? HistogramViewController {
            histogramVC.sectionRefKey = (sender as! String)
        }
    }
    
    func updateTeacher(_ userID: String, completionHandler: @escaping ([String:String]?) -> ()) {
        let userID = UIDevice.current.identifierForVendor!.uuidString
        let dbRef = Database.database().reference()
        dbRef.child("Teachers").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                if let teachers = snapshot.value as? [String : [String : AnyObject]] {
                    guard teachers.keys.contains(userID) else {
                        completionHandler([:])
                        return
                    }
                    guard teachers[userID]!.keys.contains("existingSections") else {
                        completionHandler([:])
                        return
                    }
                    completionHandler((teachers[userID]!["existingSections"] as! [String : String]))
                }
            } else {
                completionHandler([:])
            }
        }
        completionHandler(["None":"None"]) // To bypass the first Firebase query without snapshot callback.
    }
    
    func noSectionName() {
        let alertController = UIAlertController(title: "No Section Name", message: "Enter a valid section name.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func noDate() {
        let alertController = UIAlertController(title: "No Section Date", message: "Enter a valid section date.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func noStartTime() {
        let alertController = UIAlertController(title: "No Start Time", message: "Enter a valid start time.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func noEndTime() {
        let alertController = UIAlertController(title: "No End Time", message: "Enter a valid end time.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    

}
