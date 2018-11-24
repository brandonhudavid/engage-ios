//
//  MagicWordViewController.swift
//  Engage
//
//  Created by Brandon David on 11/6/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MagicWordViewController: UIViewController {

    var magicWordField: UITextField!
    var welcomeLabel: UILabel!
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    @objc func joinPressed() {
        if let magicWord = magicWordField.text {
            let number: Int! = Int(magicWord)
            magicWordToSection(number) { (sectionRefKey) in
                if sectionRefKey == "None" {
                    self.invalidMagicWord()
                }
                else if sectionRefKey != "" {
                    self.createUserSession(number, sectionRefKey)
                    self.performSegue(withIdentifier: "toSlider", sender: sectionRefKey)
                }
            }
        } else {
            invalidMagicWord()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sliderVC = segue.destination as? SliderViewController {
            sliderVC.sectionKey = sender as? String
            sliderVC.userName = name
            
        }
    }
    
    func createUserSession(_ magicKey: Int, _ sectionRefKey: String) {
//        let userID = Auth.auth().currentUser!.uid // Proper authentication of users, for later iterations.
        let userID = UIDevice.current.identifierForVendor!.uuidString
        let userSessionData: [String:AnyObject] = ["magic_key": magicKey as AnyObject,
                                                  "section_ref_key": sectionRefKey as AnyObject,
                                                  "slider_val": 50 as AnyObject,
                                                  "user_id": userID as AnyObject,
                                                  "username": self.name as AnyObject]
        let dbRef = Database.database().reference()
        dbRef.child("UserSessions").child(userID).setValue(userSessionData)
        
        updateSection(userID, sectionRefKey) { (userIDs) in
            guard var userIDs = userIDs, userIDs != [:] else {
                dbRef.child("Sections").child(sectionRefKey).child("user_ids").setValue([userID: self.name])
                return
            }
            if userIDs == ["None":"None"] {
                return // Ignore the first Firebase query without snapshot callback.
            }
            userIDs[userID] = self.name
            dbRef.child("Sections").child(sectionRefKey).child("user_ids").setValue(userIDs)
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
    
    
    
    func invalidMagicWord() {
        let alertController = UIAlertController(title: "Invalid Magic Word", message: "No classes found with the magic word.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func magicWordToSection(_ magicWord: Int, completionHandler: @escaping (String) -> ()) {
        let dbRef = Database.database().reference()
        dbRef.child("Sections").observeSingleEvent(of: .value) { (snapshot) in
            var magicKeyFound = false
            if snapshot.exists() {
                if let sections = snapshot.value as? [String : [String : Any]] {
                    for (key, value) in sections {
                        if magicWord == value["magic_key"] as? Int {
                            magicKeyFound = true
                            completionHandler(key)
                        } else {
                            print("missed key")
                        }
                    }
                    if !magicKeyFound {
                        completionHandler("None")
                    }
                }
            }
        }
        completionHandler("")
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
