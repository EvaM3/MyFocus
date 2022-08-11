//
//  HistoryListViewController.swift
//  MyFocus
//
//  Created by Eva Madarasz on 02/12/2021.
//

import UIKit



class HistoryListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let coreDataManager = CoreDataManager()
    var listEntityArray = [ListElement]()
    
    var dateArray = ["July 2022","Today","10-07-2022","11-07-2022","12-07-2022"]
    var listArray = [
        [ListElement(type: .summary, title: "One of 2 is done", isCompleted: true)],
        [ListElement.init(from: Goal(tasks: [], title: " Finish the essay", creationDate: Date())), ListElement.init(from: Task(id: UUID(), title: "Read the last pages over again", completed: true, creationDate: Date()))],
        [ListElement.init(from: Goal(tasks: [Task(id: UUID(), title: "Go grocery shopping for ingredients", completed: false, creationDate: Date())], title: "Bake the cake", creationDate: Date()))],
        [ListElement.init(from: Goal(tasks: [Task(id: UUID(), title: "Clean kitchen and bathroom", completed: false, creationDate: Date())], title: "Do the housekeeping chores", creationDate: Date()))],
        []
    ]
    
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "GoalCell", bundle: nil), forCellReuseIdentifier: "goalCell")
        tableView.register(UINib(nibName: "TaskCell",bundle: nil), forCellReuseIdentifier: "taskCell")
        tableView.register(UINib(nibName: "MonthlySummaryCell",bundle: nil), forCellReuseIdentifier: "summaryCell")
        super.viewDidLoad()
        loadData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
    }
    
    
    // MARK: Data loading functions
    
    func mapGoal(goal: Goal) -> [ListElement] {
        var elementArray = [ListElement]()
        let newGoalEntity = ListElement(from: goal)
        elementArray.append(newGoalEntity)
        for task in goal.tasks {
            let taskListElement = ListElement(from: task)
            elementArray.append(taskListElement)
        }
        return elementArray
    }
    
    
    func loadSortedData() {
        let todaysSortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        let sortDescriptors = [todaysSortDescriptor]
    }
    
    
    func loadData(pred: NSPredicate? = nil) {
        listEntityArray.removeAll()
        //coreDataManager.generateRandomData()
        let filteredGoals = coreDataManager.loadGoal(predicate: pred)
        for goal in filteredGoals {
            let elements = mapGoal(goal: goal)
            listEntityArray.append(contentsOf: elements)
        }
        tableView.reloadData()
    }
    
    
    func saveData() {
        coreDataManager.saveData()
        self.loadData()
    }
}

    // MARK: Tableview functions:
extension HistoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = listArray[indexPath.section][indexPath.row]
        switch element.type {
        
        case .goal:
            if let cell: GoalCell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell {
                cell.configureCheckMarkedCell(item: element)
              //  Calendar.current.isDateInToday(<#T##date: Date##Date#>)
                return cell
            }
            
        case .task:
            if let cell: TaskCell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskCell {
                cell.configureCheckMarkedCell(item: element)
                return cell
            }
        
        case .summary:
            if let cell: SummaryCell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as? SummaryCell {
                cell.configureCell(item: element)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let element = listArray[indexPath.section][indexPath.row]
        switch element.type {
        case .goal:
            return 60
            
        case .task:
            return 40
          
        case .summary:
            return 30
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dateArray.count
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.sectionHeaderTopPadding = 0
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let label = UILabel()
        label.frame = headerView.frame
        label.text = self.dateArray[section]
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .green
        headerView.addSubview(label)

        return headerView
       
    }

}
