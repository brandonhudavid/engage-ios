//
//  ClassCell.swift
//  Engage
//
//  Created by Brandon David on 11/23/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import UIKit

class ClassCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        self.layer.cornerRadius = 5.0
        self.backgroundColor = UIColor.init(red: 47/255, green: 92/255, blue: 216/255, alpha: 1.0)
        self.textLabel?.textColor = UIColor.white
        self.textLabel?.font = UIFont(name: "Quicksand-Bold", size: 18)
        self.textLabel?.adjustsFontSizeToFitWidth = true
    }

}
