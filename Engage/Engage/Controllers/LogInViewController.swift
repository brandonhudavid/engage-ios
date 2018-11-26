//
//  ViewController.swift
//  Engage
//
//  Created by Brandon David on 11/6/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LogInViewController: UIViewController {
    
    var nameField: UITextField!
    
//    let quicksandBold = UIFont(name: "Quicksand-Bold", size: UIFont.systemFontSize)



    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func studentPressed() {
        if let name = nameField.text {
            let studentName = name.trimmingCharacters(in: .whitespaces)
            if studentName != "" {
                performSegue(withIdentifier: "toMagicWordVC", sender: studentName)
            } else {
                let alertController = UIAlertController(title: "Invalid Name", message: "Please enter a name.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func updateSection(_ userID: String, _ sectionRefKey: String, completionHandler: @escaping ([String:String]?) -> ()) {
        let dbRef = Database.database().reference()
        dbRef.child("Sections").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                let sections = snapshot.value as! [String : [String : AnyObject]]
                let section: [String:AnyObject]! = sections[sectionRefKey]
                if (section.keys.contains("user_ids")) {
                    completionHandler((section["user_ids"] as! [String : String]))
                } else {
                    completionHandler([:])
                }
            }
        }
        completionHandler(["None":"None"]) // To bypass the first Firebase query without snapshot callback.
    }
    
    func teacherHasSections(completionHandler: @escaping (String) -> ()) {
        let dbRef = Database.database().reference()
        dbRef.child("Teachers").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                let userID = UIDevice.current.identifierForVendor!.uuidString
                let teachers = snapshot.value as! [String : [String : String]]
                if teachers.keys.contains(userID) {
                    let sections = teachers[userID]
                    guard sections != nil else {
                        completionHandler("false")
                        return
                    }
                    completionHandler("true")
                } else {
                    completionHandler("false")
                }
            }
        }
        completionHandler("") // To bypass the first Firebase query without snapshot callback.
    }
    
    @objc func teacherPressed() {
        teacherHasSections { (hasSections) in
            if hasSections == "true" {
                self.performSegue(withIdentifier: "toTeacherVC", sender: nil)
            } else if hasSections == "false" {
                self.performSegue(withIdentifier: "loginToClassSetupVC", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMagicWordVC", let magicWordVC = segue.destination as? MagicWordViewController {
            magicWordVC.name = sender as? String
        }
//        else if segue.identifier == "toClassSetupVC", let classSetupVC = segue.destination as? ClassSetupViewController {
//
//        }
    }


}

