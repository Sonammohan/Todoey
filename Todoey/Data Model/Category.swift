//
//  Category.swift
//  Todoey
//
//  Created by Sona Mohan on 2018-12-21.
//  Copyright © 2018 Sona Mohan. All rights reserved.
//

import Foundation
import RealmSwift

class Category:Object{
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
