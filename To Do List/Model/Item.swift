//
//  Item.swift
//  To Do List
//
//  Created by Muhamed Alkhatib on 04/09/2020.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var name: String=""
    @objc dynamic var checked: Bool=false
    let parent = LinkingObjects(fromType: Category.self, property: "items")
}
