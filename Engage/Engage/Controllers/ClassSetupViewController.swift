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
    
    var classNameField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    @objc func createClass() {
        
        performSegue(withIdentifier: "toTeacherVC", sender: nil)
    }
    
    func addSectionToFirebase(_ className: String) {
        let dbRef = Database.database().reference()
        let uuid = UUID.init(uuidString: className)
        let uuidString = uuid?.description
        dbRef.child("Sections").child(uuidString).setValue("hi")
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
