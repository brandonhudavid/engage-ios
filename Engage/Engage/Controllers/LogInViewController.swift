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
    
    
    
    /*Variable declarations*/
    var nameField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    
    /// Displays alert if invalid name entered
    func invalidName() {
        let alertController = UIAlertController(title: "Invalid Name", message: "Please enter a name.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
   
    
    /// Adds userID (user) into section based on sectionRefKey
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
    
    
    
    /// Checks if teacher already exists in database based on their device ID
    func teacherHasSections(completionHandler: @escaping (String) -> ()) {
        let dbRef = Database.database().reference()
        dbRef.child("Teachers").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                let userID = UIDevice.current.identifierForVendor!.uuidString
                let teachers = snapshot.value as! [String : [String : AnyObject]]
                if teachers.keys.contains(userID) {
                    completionHandler("true")
                } else {
                    completionHandler("false")
                }
            } else {
                completionHandler("false") // To bypass the first Firebase query without snapshot callback.
            }
        }
        completionHandler("") // To bypass the first Firebase query without snapshot callback.
    }
    

    /// Prepares for segue to either MagicWordViewController (student), TeacherViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMagicWordVC", let magicWordVC = segue.destination as? MagicWordViewController {
            magicWordVC.name = sender as? String
        } else if segue.identifier == "toTeacherVC", let teacherVC = segue.destination as? TeacherViewController {
            teacherVC.name = sender as? String
        } else if segue.identifier == "loginToClassSetupVC", let classSetupVC = segue.destination as? ClassSetupViewController {
            classSetupVC.name = sender as? String
        }
    }
    
    @objc func studentPressed() {
        if let name = nameField.text {
            let studentName = name.trimmingCharacters(in: .whitespaces)
            if studentName != "" {
                UserDefaults.standard.set(studentName, forKey: "name")
                performSegue(withIdentifier: "toMagicWordVC", sender: studentName)
            } else {
                invalidName()
            }
        }
    }
    
    @objc func teacherPressed() {
        guard let name = nameField.text, name.trimmingCharacters(in: .whitespaces) != "" else {
            invalidName()
            return
        }
        UserDefaults.standard.set(name, forKey: "name")
        teacherHasSections { (hasSections) in
            if hasSections == "true" {
                self.performSegue(withIdentifier: "toTeacherVC", sender: name.trimmingCharacters(in: .whitespaces))
            } else if hasSections == "false" {
                self.performSegue(withIdentifier: "loginToClassSetupVC", sender: name.trimmingCharacters(in: .whitespaces))
            }
        }
    }
}
