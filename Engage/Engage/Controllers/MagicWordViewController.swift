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

    /*Variable declarations*/
    var magicWordField: UITextField!
    var welcomeLabel: UILabel!
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setupUI()
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sliderVC = segue.destination as? SliderViewController {
            sliderVC.sectionKey = sender as? String
            sliderVC.userName = name
        }
    }
    
    func createUserSession(_ magicKey: Int, _ sectionRefKey: String) {
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
    
    func magicWordToSection(_ magicWord: String, completionHandler: @escaping (String) -> ()) {
        let dbRef = Database.database().reference()
        dbRef.child("MagicKeys").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                let magicKeys: [String: String] = snapshot.value as! [String: String]
                let magicWordInt = String(Int(magicWord) ?? 0)
                if magicKeys.keys.contains(magicWordInt) {
                    completionHandler(magicKeys[magicWordInt]!)
                } else {
                    completionHandler("None")
                }
                
            }
        }
        completionHandler("")
    }
    
    @objc func joinPressed() {
              print("here 5")
        if let magicWord = magicWordField.text, magicWord.trimmingCharacters(in: .whitespaces) != "" {
            magicWordToSection(magicWord) { (sectionRefKey) in
                if sectionRefKey == "None" {
                    self.invalidMagicWord()
                }
                else if sectionRefKey != "" {
                    self.createUserSession(Int(magicWord)!, sectionRefKey)
                    self.performSegue(withIdentifier: "toSlider", sender: sectionRefKey)
                }
            }
        } else {
            invalidMagicWord()
        }
    }
    
}
