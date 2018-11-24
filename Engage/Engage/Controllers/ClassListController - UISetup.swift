//
//  ClassListController - UISetup.swift
//  Engage
//
//  Created by Brandon David on 11/23/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import UIKit

extension ClassListController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as? ClassCell {
            cell.awakeFromNib()
            cell.textLabel?.text = sections[indexPath.section][1]
            return cell
        }
        return ClassCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView.init()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toHistogram", sender: sections[indexPath.section][0])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHistogram", let histogramVC = segue.destination as? HistogramViewController {
            histogramVC.sectionRefKey = (sender as! String)
        }
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.init(red: 6/255, green: 38/255, blue: 51/255, alpha: 1.0)
        
        classList = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width - 100, height: view.frame.height / 2 - 130))
        classList.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/2 + 65)
        classList.register(ClassCell.self, forCellReuseIdentifier: "classCell")
        classList.backgroundColor = UIColor.clear
        classList.separatorColor = UIColor.clear
        classList.delegate = self
        classList.dataSource = self
        self.view.addSubview(classList)
        
        setupHeaders()
    }
    
    func setupHeaders() {
        let welcomeLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.width/2 + 50, height: 80))
        welcomeLabel.center = CGPoint.init(x: view.frame.width/2, y: view.frame.height/3)
        welcomeLabel.text = "Choose from your existing sections:"
        welcomeLabel.numberOfLines = 2
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = UIColor.white
        welcomeLabel.font = UIFont(name: "Quicksand-Bold", size: 24)
        self.view.addSubview(welcomeLabel)
    }
    
    
}
