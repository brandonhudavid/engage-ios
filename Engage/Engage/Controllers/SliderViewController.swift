//
//  SliderViewController.swift
//  Engage
//
//  Created by Shubha Jagannatha on 11/10/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {
    
    var sectionKey: String!
    var slider : UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("sectionKey: " + sectionKey)
        setupUI()
        setupSlider()

        // Do any additional setup after loading the view.
    }

    
//
//    override func viewDidLayoutSubviews() {
//        let margin: CGFloat = 20.0
//        let width = view.bounds.width - 2.0 * margin
//        slider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length,
//                                   width: width, height: 31.0)
//    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
