//
//  DataInputViewController.swift
//  EngageTester3
//
//  Created by Shubha Jagannatha on 11/8/18.
//  Copyright © 2018 Shubha Jagannatha. All rights reserved.
//

import UIKit

class DataInputViewController: UIViewController, UITextFieldDelegate {
    
    var sectionRefKey: String!
    var textField: UITextField!
    var loginButton : UIButton!
    var nextView : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sectionRefKey)
        
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width - 40, height: 50))
        textField.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        textField.delegate = self
        textField.keyboardType = .numberPad
        view.addSubview(textField)
        
        self.view.backgroundColor = .green
        loginButton = UIButton(frame: CGRect(x: 20, y: view.frame.height - 200, width: view.frame.width - 40, height: 60))
        loginButton.backgroundColor = .magenta
        loginButton.setTitle("LOG NUMBER", for: UIControl.State())
        loginButton.setTitleColor(UIColor.white, for: UIControl.State())
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        loginButton.addTarget(self, action: #selector(btnAddTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        
        self.view.backgroundColor = .green
        nextView = UIButton(frame: CGRect(x: 20, y: view.frame.height - 100, width: view.frame.width - 40, height: 60))
        nextView.backgroundColor = .magenta
        nextView.setTitle("NEXT VIEW", for: UIControl.State())
        nextView.setTitleColor(UIColor.white, for: UIControl.State())
        nextView.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        nextView.addTarget(self, action: #selector(histogram), for: .touchUpInside)
        view.addSubview(nextView)
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    // Firebase functions
    
    func findEngagementIndex() {
        
    }
    
    @IBAction func btnAddTapped(_ sender: AnyObject) {
        if let value = textField.text , value != "" {
            let visitorCount = Count()
            visitorCount.count = (NumberFormatter().number(from: value)?.intValue)!
            visitorCount.save()
            textField.text = ""
        }
        
    }
    
    
    @objc func histogram () {
        performSegue(withIdentifier: "toHistogram", sender: self)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
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
