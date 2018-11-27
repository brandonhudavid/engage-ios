//
//  ContainerViewController.swift
//  Engage
//
//  Created by Kayli  Jiang on 11/26/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    let items = ["Me", "Class"]
    let customSC = UISegmentedControl(items: ["Me", "Class"])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        
        setUpSegmentedControl()
        updateView()
        
    }
    
    func setUpSegmentedControl(){
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        customSC.frame = CGRect(x: -103, y: view.frame.height/2 + 37, width: 264, height: 25)
        customSC.layer.cornerRadius = 3.0
        customSC.backgroundColor = self.view.backgroundColor
        customSC.tintColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .normal)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .selected)
        customSC.clipsToBounds = true
        customSC.transform = CGAffineTransform(rotationAngle: 3*CGFloat.pi/2)
        
        customSC.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        
        self.view.addSubview(customSC)
    }
    
    @objc func changeColor(sender: UISegmentedControl){
        updateView()
    }
    
    private lazy var SliderViewController: SliderViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SliderViewController") as! SliderViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var BothLineGraphViewController: BothLineGraphViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "BothLineGraphViewController") as! BothLineGraphViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        view.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func updateView() {
        if customSC.selectedSegmentIndex == 0 {
            remove()
            add(asChildViewController: BothLineGraphViewController)
        } else {
            remove()
            add(asChildViewController: SliderViewController)
        }
    }
    
    func add(_ child: UIViewController, frame: CGRect? = nil) {
        addChild(child)
        
        if let frame = frame {
            child.view.frame = frame
        }
        
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    /*func setUpSegmentedControl(){
        
        let items = ["Me", "Class"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        customSC.frame = CGRect(x: -103, y: view.frame.height/2 + 37, width: 264, height: 25)
        customSC.layer.cornerRadius = 3.0
        customSC.backgroundColor = self.view.backgroundColor
        customSC.tintColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .normal)
        customSC.setTitleTextAttributes(titleTextAttributes, for: .selected)
        customSC.clipsToBounds = true
        customSC.transform = CGAffineTransform(rotationAngle: 3*CGFloat.pi/2)
        
        customSC.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        
        self.view.addSubview(customSC)
    }
    
    @objc func changeColor(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "toMe", sender: self)
        case 1:
            performSegue(withIdentifier: "toBoth", sender: self)
        default:
            break
        }
    }*/

}
