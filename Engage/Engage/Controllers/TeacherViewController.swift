//
//  TeacherViewController.swift
//  Engage
//
//  Created by Brandon David on 11/22/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TeacherViewController: UIViewController {
    
    var name: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setupUI()
    }
    
    @objc func createNewSection() {
        performSegue(withIdentifier: "toClassSetupVC", sender: name)
        
    }
    
    @objc func resumeSection() {
        teacherSections { (sections) in
            guard var sections = sections else {
                self.noExistingClasses()
                return
            }
            if sections != [] {
                sections.sort {
                    return $0[1] < $1[1]
                }
                self.performSegue(withIdentifier: "toClassListVC", sender: sections)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toClassListVC", let classListVC = segue.destination as? ClassListController {
            classListVC.sections = (sender as! [[String]])
        } else if segue.identifier == "toClassSetupVC", let classSetupVC = segue.destination as? ClassSetupViewController {
            classSetupVC.name = (sender as! String)
        }
    }
    
    
    func teacherSections(completionHandler: @escaping ([[String]]?) -> ()) {
        let userID = UIDevice.current.identifierForVendor!.uuidString
        let dbRef = Database.database().reference()
        dbRef.child("Teachers").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                if let teachers = snapshot.value as? [String : [String : AnyObject]] {
                    guard teachers.keys.contains(userID) else {
                        completionHandler([])
                        return
                    }
                    guard teachers[userID]!.keys.contains("existingSections") else {
                        completionHandler([])
                        return
                    }
                    var sections: [[String]]? = []
                    for (key, value) in (teachers[userID]!["existingSections"] as! [String : String]) {
                        sections?.append([key, value])
                    }
                    completionHandler(sections)
                }
            }
        }
        completionHandler([])
        
    }
    
    func noExistingClasses() {
        let alertController = UIAlertController(title: "No Existing Classes", message: "You do not have any existing classes.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    

}
