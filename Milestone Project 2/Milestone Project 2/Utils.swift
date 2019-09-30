//
//  Utils.swift
//  Milestone Project 2
//
//  Created by Maria Luiza Carvalho Sperotto on 27/09/19.
//  Copyright © 2019 Maria Luiza Carvalho Sperotto. All rights reserved.
//

import UIKit

class Utils {
    let key = "key"
    var items: [String] = []
    
    func save(item: String) {
        items = list()
        items.append(item)
        UserDefaults.standard.set(items, forKey: key)
        
    }
    
    func list() -> [String] {
        let data = UserDefaults.standard.object(forKey: key)
        if data != nil {
        return data as! [String]
        
        
        } else {
            return []
        }
    }
}
