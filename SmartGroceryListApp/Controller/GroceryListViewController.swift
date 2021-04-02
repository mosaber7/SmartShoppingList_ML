//
//  ToDoTableViewController.swift
//  ToDoApp
//
//  Created by Saber on 02/02/2021.
//

import UIKit

class GroceryListViewController: UITableViewController{
    
    var tasksManger: ItemsManger!
    var imageStore: ImageStore!
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let task = tasksManger.allTasks[indexPath.row]
            tasksManger.removeTask(task)
            imageStore.delelteImage(forKey: task.taskKey)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasksManger.allTasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! ItemCell
        
        cell.nameLabel.text = task.name
        cell.dateLabel.text = dateFormatter.string(from: task.dateCreated)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksManger.allTasks.count
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tasksManger.move(at: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    override func viewDidLoad() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let newTask = tasksManger.createItem()
        if let index = tasksManger.allTasks.firstIndex(of: newTask){
            let indexpath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexpath], with: .automatic)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowTask":
            if let row = tableView.indexPathForSelectedRow?.row{
                let task = tasksManger.allTasks[row]
                let showDetailsVC = segue.destination as! ShowDetailsViewController
                showDetailsVC.task = task
                showDetailsVC.imageStore = imageStore
            }
        case "AddTask":
            
            let showDetailsVC = segue.destination as! ShowDetailsViewController
            showDetailsVC.task = tasksManger.createItem()
            
            
        default:
            preconditionFailure("undifened Seague")
        }
    }
    
    
}
