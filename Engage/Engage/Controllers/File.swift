//
//  RealmSwift.swift
//  Engage
//
//  Created by Shubha Jagannatha on 11/6/18.
//  Copyright © 2018 Brandon David. All rights reserved.
//

import Foundation
import RealmSwift


class Count: Object {
    
    
    @objc dynamic var date: Date = Date()
    @objc dynamic var count: Int = Int(0)
    
    
    
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
}
