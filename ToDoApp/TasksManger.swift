//
//  TasksManger.swift
//  ToDoApp
//
//  Created by Saber on 02/02/2021.
//


class TasksManger{
    var allTasks = [Task]()
    
    @discardableResult func createItem()->Task{
        let newTask = Task()
        allTasks.append(newTask)
        return newTask
    }
    
    func removeTask(_ task: Task){
        if let index = allTasks.firstIndex(of: task){
            allTasks.remove(at: index)
        }
    }
    
    func move(at index: Int, toIndex: Int)  {
        let task = allTasks[index]
        removeTask(task)
        allTasks.insert(task, at: toIndex)
    }
    
    
}
