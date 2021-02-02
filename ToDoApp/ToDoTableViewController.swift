//
//  ToDoTableViewController.swift
//  ToDoApp
//
//  Created by Saber on 02/02/2021.
//

import UIKit

class ToDoTableViewController: UITableViewController{
    
    var tasksManger: TasksManger!
    
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
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasksManger.allTasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        cell.nameLabel.text = task.name
        cell.dateLabel.text = dateFormatter.string(from: task.dateCreated)
        cell.weightLabel.text = "\(task.priorty)"
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
            }
        case "AddTask":
            
            let showDetailsVC = segue.destination as! ShowDetailsViewController
            showDetailsVC.task = tasksManger.createItem()
            
            
        default:
            preconditionFailure("undifened Seague")
        }
    }
    
}
