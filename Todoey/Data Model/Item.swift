//
//  Item.swift
//  Todoey
//
//  Created by Sona Mohan on 2018-12-21.
//  Copyright © 2018 Sona Mohan. All rights reserved.
//

import Foundation
import RealmSwift


class Item:Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}


