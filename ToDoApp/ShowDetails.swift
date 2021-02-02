//
//  ShowDetails.swift
//  ToDoApp
//
//  Created by Saber on 02/02/2021.
//

import UIKit

class ShowDetailsViewController: UIViewController {
    @IBOutlet var nameText: UITextField!
    @IBOutlet var priortyText: UITextField!
    @IBOutlet var dateText: UITextField!
    
    var task: Task!{
        didSet{
            navigationItem.title = task.name
        }
    }
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .long
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameText.text = task.name
        priortyText.text = "\(task.priorty)"
        dateText.text = dateFormatter.string(from: task.dateCreated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let name = nameText.text{
            task.name = name
        }
    }
}
