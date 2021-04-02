//
//  Task.swift
//  ToDoApp
//
//  Created by Saber on 02/02/2021.
//

import Foundation

class Item: Equatable, Codable{
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name &&  lhs.dateCreated == rhs.dateCreated
    }
    
    var name : String
    var dateCreated: Date
    var taskKey: String
    
    init(name: String) {
        self.name = name
        self.dateCreated = Date()
        self.taskKey = UUID().uuidString
    }
    convenience init() {
        self.init(name: "item")
    }
}
