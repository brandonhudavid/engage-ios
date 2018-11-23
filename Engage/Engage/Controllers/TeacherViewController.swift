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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    @objc func createNewSection() {
        performSegue(withIdentifier: "toClassSetupVC", sender: nil)
        
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
        }
    }
    
    
    func teacherSections(completionHandler: @escaping ([[String]]?) -> ()) {
        let userID = UIDevice.current.identifierForVendor!.uuidString
        let dbRef = Database.database().reference()
        dbRef.child("Teachers").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                if let teachers = snapshot.value as? [String : [String : String]] {
                    if teachers.keys.contains(userID) {
                        var sections: [[String]]? = []
                        for (key, value) in teachers[userID]! {
                            sections?.append([key, value])
                        }
                        completionHandler(sections)
                    }
                }
            }
        }
        completionHandler([])
        
    }
    
    func noExistingClasses() {
        let alertController = UIAlertController(title: "No Existing Classes", message: "You do not have any existing classes.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
        
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
