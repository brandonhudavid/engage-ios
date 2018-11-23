//
//  ViewController.swift
//  Engage
//
//  Created by Brandon David on 11/6/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit

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
    
    @objc func teacherPressed() {
        performSegue(withIdentifier: "toTeacherVC", sender: nil)
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

