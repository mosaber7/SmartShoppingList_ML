//
//  TasksManger.swift
//  ToDoApp
//
//  Created by Saber on 02/02/2021.
//
import UIKit

class ItemsManger{
    var allTasks = [Item]()
    
    let itemArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    @discardableResult func createItem()->Item{
        let newTask = Item()
        allTasks.append(newTask)
        return newTask
    }
    
    func removeTask(_ task: Item){
        if let index = allTasks.firstIndex(of: task){
            allTasks.remove(at: index)
        }
    }
    
    func move(at index: Int, toIndex: Int)  {
        let task = allTasks[index]
        removeTask(task)
        allTasks.insert(task, at: toIndex)
    }
    @objc func saveChanges() throws{
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(allTasks)
            try data.write(to: itemArchiveURL, options: .atomic)
        } catch {
            throw error
        }
    }
    
    init() {
        
        do {
                let data = try Data(contentsOf: itemArchiveURL)
                let unarchiver = PropertyListDecoder()
                let tasks = try unarchiver.decode([Item].self, from: data)
                allTasks = tasks
        } catch{
            print("Error reading in saved items \(error)")
        }
        
        
        let notifactionCenter = NotificationCenter.default
        notifactionCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
    }
    
}
