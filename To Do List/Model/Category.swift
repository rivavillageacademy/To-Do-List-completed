//
//  Category.swift
//  To Do List
//
//  Created by Muhamed Alkhatib on 04/09/2020.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name: String=""
    let items = List<Item>()
}
