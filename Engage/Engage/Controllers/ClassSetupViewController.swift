//
//  ClassSetupViewController.swift
//  Engage
//
//  Created by Brandon David on 11/6/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit

class ClassSetupViewController: UIViewController {
    
    var classNameField: UITextField!
    var datePicker : UIDatePicker!
    var txtDatePicker : UITextField!
    var date : String!
    
    
    var startTimePicker : UIDatePicker!
    var startTxtTimePicker : UITextField!
    var startTime : String!
    
    var endTimePicker : UIDatePicker!
    var endTxtTimePicker : UITextField!
    var endTime : String!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        // Do any additional setup after loading the view.
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
