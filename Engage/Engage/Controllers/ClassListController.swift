//
//  ClassListController.swift
//  Engage
//
//  Created by Brandon David on 11/23/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit

class ClassListController: UIViewController {
    
    /*Variable declarations*/
    var sections: [[String]]!
    var classList: UITableView!
    var selected : Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = classList.indexPathForSelectedRow{
            self.classList.deselectRow(at: index, animated: true)
        }
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
