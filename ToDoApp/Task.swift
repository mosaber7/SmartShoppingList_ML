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
class Task: Equatable{
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.name == rhs.name && lhs.priorty == rhs.priorty && lhs.dateCreated == rhs.dateCreated
    }
    
    var name : String
    var priorty: Priorty
    var dateCreated: Date
    
    init(name: String, weight: Priorty) {
        self.name = name
        self.priorty = weight
        dateCreated = Date()
    }
    convenience init() {
        self.init(name: "task", weight: .NotDefined)
    }
}
