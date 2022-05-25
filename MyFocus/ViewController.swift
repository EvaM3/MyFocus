//
//  ViewController.swift
//  MyFocus
//
//  Created by Eva Madarasz on 02/12/2021.
//

import UIKit
struct ListEntityUI {
    var title: String
    var isCompleted: Bool?
    var creationDate: Date?
    var achievedDate: Date?
    
}

extension ListEntityUI {
    init(mapListEntityUI : TaskEntity) {
        self.title = mapListEntityUI.name ?? ""
        self.isCompleted = mapListEntityUI.completed
        self.achievedDate = mapListEntityUI.achievedDate
        self.creationDate = mapListEntityUI.creationDate
    }
}

struct GoalEntityUI {
    var achievedDate: Date?
    var completed: Bool
    var creationDate: Date?
    var title: String?
    var tasks: NSOrderedSet?
}

extension GoalEntityUI {
    init (mapGoalEntityUI : GoalEntity) {
        self.title = mapGoalEntityUI.title ?? ""
        self.completed = mapGoalEntityUI.completed
        self.achievedDate = mapGoalEntityUI.achievedDate
        self.creationDate = mapGoalEntityUI.creationDate
        self.tasks =  mapGoalEntityUI.tasks
    }
}

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        loadData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    let coreDataManager = CoreDataManager()
    var listEntityArray = [ListEntityUI]()
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEntityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        let item = listEntityArray[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.present(changeCancelAndEditTasks(indexPath: indexPath), animated: true)
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add task", style: .default) { (action) in
            let newTask = ListEntityUI(title: textField.text ?? "", isCompleted: false, creationDate: Date() + 86400, achievedDate: nil)
            self.coreDataManager.addItem(item: newTask)
            self.loadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "New task here"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    func updateTasks(indexPath: IndexPath) -> UIAlertController {
        let item = listEntityArray[indexPath.row]
        var textField = UITextField()
        let alert = UIAlertController(title: "Update task", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Update your task", style: .default, handler: { _ in
            self.coreDataManager.updateData(at: indexPath.row , title: textField.text ?? "")
            self.loadData()
        }))
        
        
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "New task here"
            textField = alertTextField
        }
        alert.textFields?.first?.text = item.title
        return alert
    }
    
    func changeCancelAndEditTasks(indexPath: IndexPath) -> UIAlertController {
        let sheet = UIAlertController(title: "Change task", message: nil, preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            self.present(self.updateTasks(indexPath: indexPath), animated: true)
        } ))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.coreDataManager.deleteData(at: indexPath.row)
            self.loadData()
        }))
        
        return sheet
    }
    
    
    func map(item: TaskEntity) -> ListEntityUI {
        
        let newListEntity = ListEntityUI(mapListEntityUI: item)
        return newListEntity
    }
    
    func loadSortedData() {
        let todaysSortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        let sortDescriptors = [todaysSortDescriptor]
        
    }
    
    func loadData(pred: NSPredicate? = nil) {
        let filteredFetchResult = coreDataManager.loadData(predicate: pred)
        
        listEntityArray = []
        for item in filteredFetchResult {
            let newMap = map(item: item)
            listEntityArray.append(newMap)
            
        }
        tableView.reloadData()
    }
    
    func saveData() {
        coreDataManager.saveData()
        self.loadData()
    }
}
