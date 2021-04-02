//
//  Task.swift
//  ToDoApp
//
//  Created by Saber on 02/02/2021.
//

import Foundation

class Task: Equatable, Codable{
    static func == (lhs: Task, rhs: Task) -> Bool {
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
        self.init(name: "task")
    }
}
