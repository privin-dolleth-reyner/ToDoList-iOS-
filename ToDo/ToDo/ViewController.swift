//
//  ViewController.swift
//  ToDo
//
//  Copyright © 2017 Privin. All rights reserved.
//

import UIKit
import RealmSwift
import TTGSnackbar

class ViewController: UITableViewController,TaskCellDelegate {
    
    var items = List<Tasks>()
    var index = 0
    let db = DataBase()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {action in
            let task = self.items[indexPath.row]
            let replicate = Tasks()
            replicate.text = task.text
            replicate.completed = task.completed
            self.db.delete(task: self.items[indexPath.row])
            self.updateView()
            self.undo(task: replicate)
           
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {action in
            //handle edit
            self.editTask(taskToEdit: self.items[indexPath.row])
            self.updateView()
            
        }
        editAction.backgroundColor = .gray
        return [deleteAction, editAction]
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        cell.delegate = self
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.text)
        if item.completed {
            attributeString.addAttribute(NSStrikethroughStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
             cell.checkbox.setImage(#imageLiteral(resourceName: "checkmark-outline"), for: .normal)
        }else{
             cell.checkbox.setImage(#imageLiteral(resourceName: "circle-outline"), for: .normal)
        }
        cell.label.attributedText = attributeString
        return cell
    }
    
    
    func stateChanged(cell: TaskCell) {
        let indexPath = self.tableView.indexPath(for: cell)!
        let item = items[indexPath.row]
        let newItem = Tasks()
        newItem.taskId = item.taskId
        newItem.text = item.text
        newItem.completed = !item.completed
        db.updateTask(task: newItem)
        updateView()
    }
    
    func setupView(){
        title = "My Tasks"
        tableView.register(TaskCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsSelection = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        
//        deleteAll()
        updateView()
    }
    
    
    func add(){
        let task = UIAlertController(title: "New Task", message: "", preferredStyle: .alert)
        var txtfield : UITextField!
        task.addTextField { textfield in
            txtfield = textfield
            textfield.placeholder = "Task Name"
        }
        task.addAction(UIAlertAction(title: "Cancel", style: .default){ _ in
            // do nothing
        })
        task.addAction(UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = txtfield.text , !text.isEmpty else {
                self.showMsg(msg: "Task is Empty")
                return
            }
            let newTask = Tasks()
            newTask.text = text
            newTask.completed = false
            newTask.taskId = self.incrementID()

            self.db.addTask(task: newTask)
            self.updateView()
        })
        
        present(task, animated: true, completion: nil)
    }
    
    func editTask(taskToEdit : Tasks){
        let task = UIAlertController(title: "Edit Task", message: "", preferredStyle: .alert)
        var txtfield : UITextField!
        task.addTextField { textfield in
            txtfield = textfield
            textfield.text = taskToEdit.text
        }
        task.addAction(UIAlertAction(title: "Cancel", style: .default){ _ in
            // do nothing
        })
        task.addAction(UIAlertAction(title: "Update", style: .default) { _ in
            guard let text = txtfield.text , !text.isEmpty else {
                self.showMsg(msg: "Task is Empty")
                return
            }
            let newTask = Tasks()
            newTask.text = text
            newTask.taskId = taskToEdit.taskId
            newTask.completed = taskToEdit.completed
            self.db.updateTask(task: newTask)
            self.updateView()
        })
        present(task, animated: true, completion: nil)
    }
    
    
    func updateView(){
        let result = db.getRealmInstance().objects(Tasks.self)
//        let filter = result.filter("text BEGINSWITH 'q'")
        let sort = result.sorted(byKeyPath: "text", ascending: true)
        items.removeAll()
        for item in sort{
            items.append(item)
        }
        self.tableView.reloadData()
    }
    
    func showMsg(msg : String){
        let snackbar = TTGSnackbar.init(message: msg, duration: .short)
        snackbar.show()
    }
    
    
    func incrementID() -> Int {
        return (db.getRealmInstance().objects(Tasks.self).max(ofProperty: "taskId") as Int? ?? 0) + 1
    }
   
    func undo(task : Tasks){
         task.taskId = incrementID()
        let snackbar = TTGSnackbar.init(message: "Task deleted !", duration: .middle, actionText: "Undo")
        { (snackbar) -> Void in
            self.db.addTask(task: task)
            self.updateView()
        }
        snackbar.show()
    }
    
    
        
}

