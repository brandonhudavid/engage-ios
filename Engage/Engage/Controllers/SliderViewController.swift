//
//  SliderViewController.swift
//  Engage
//
//  Created by Shubha Jagannatha on 11/10/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {
    
    var slider : UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSlider()

        // Do any additional setup after loading the view.
    }
    
    
    func setupUI() {
         view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
       
    }
    
    
    
    
    func setupSlider() {
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: view.frame.height, height: view.frame.width))
        slider.backgroundColor = UIColor(white: 1, alpha: 0)
        slider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        view.addSubview(slider)
        
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
