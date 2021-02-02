//
//  Task.swift
//  ToDoApp
//
//  Created by Saber on 02/02/2021.
//

import Foundation
enum Priorty {
    case VIMP
    case IMB
    case NotIMP
    case NotDefined
    
}
class Task: Equatable, Codable{
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.name == rhs.name && lhs.priorty == rhs.priorty && lhs.dateCreated == rhs.dateCreated
    }
    
    var name : String
    var priorty: String
    var dateCreated: Date
    
    init(name: String, priorty: String) {
        self.name = name
        self.priorty = priorty
        dateCreated = Date()
    }
    convenience init() {
        self.init(name: "task", priorty: "Not Defined")
    }
}
