//
//  HistoryListViewController.swift
//  MyFocus
//
//  Created by Eva Madarasz on 02/12/2021.
//

import UIKit


struct ListElement {
    
    enum ListEntityType {
        case task
        case goal
    }
    
    var type: ListEntityType
    var title: String
    var isCompleted: Bool
    var creationDate: Date
    var achievedDate: Date?
    
}

extension ListElement {
    init(from task : Task) {
        self.type = .task
        self.title = task.title
        self.isCompleted = task.completed
        self.achievedDate = task.achievedDate
        self.creationDate = task.creationDate
        
    }
    
    init(from goal : Goal) {
        self.type = .goal
        self.title = goal.title
        self.isCompleted = goal.completed
        self.achievedDate = goal.achievedDate
        self.creationDate = goal.creationDate
        
    }
}






class HistoryListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
  
    
    
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
    var listEntityArray = [ListElement]()
    
//    var dateArray: [ListElement] = []
//    var listArray : [ListElement] = []
    
var dateArray = ["09-07-2022","10-07-2022","11-07-2022","12-07-2022"]
 var listArray = [["Goal: Finish the essay","Tasks: Read the last pages over again","Write at least two mock pages","Correct the mistakes"],
    ["Goal: Bake the cake", "Tasks: Go grocery shopping for ingredients", "Prepare the cream","Bake the biscuit","Finish it with icing"],
    ["Goal: Do the housekeeping chores", "Tasks: Hoover everywhere","Clen kitchen and bathroom", "Dust off everywhere"]
 ]
    
    let calendar = Calendar.current

    struct SectionItem {
        let sectionCreationDate : Date
    }
    
    
    var sections = Dictionary<String, Array<SectionItem>>()
    var sortedSections = [String]()
    
    
    
    func saveDate() -> Date {
    let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateObject = dateFormatter.date(from: dateFormatter.dateFormat)!
        return dateObject
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEntityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dateArray[0]
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dateArray.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      //  let table = UITableView(frame: .zero, style: .grouped)
        self.tableView.sectionHeaderHeight = 50
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let label = UILabel()
               label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
               label.text = "Today,\(getTodaysDate())"
               label.font = .systemFont(ofSize: 20)
               label.textAlignment = .center
               label.textColor = .black
               label.backgroundColor = .lightGray
               headerView.addSubview(label)
               
               return headerView
    }
  
   
    
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
    
    func getYesterdayDate() -> Date {
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date() - 86400
        return yesterdayDate
    }
    
    func getTodaysDate() -> Date {
        let todayDate = Calendar.current.date(byAdding: .day, value: 0, to: Date()) ?? Date() - 86400
        return todayDate
    }
    
    
    func saveData() {
        coreDataManager.saveData()
        self.loadData()
    }
}
