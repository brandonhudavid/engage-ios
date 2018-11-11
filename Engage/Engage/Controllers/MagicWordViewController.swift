//
//  MagicWordViewController.swift
//  Engage
//
//  Created by Brandon David on 11/6/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
                    self.performSegue(withIdentifier: "toSlider", sender: sectionRefKey)
                }
            }
        } else {
            invalidMagicWord()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let studentVC = segue.destination as? StudentViewController {
            studentVC.sectionKey = sender as? String
            
        }
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
