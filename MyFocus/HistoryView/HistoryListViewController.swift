//
//  HistoryListViewController.swift
//  MyFocus
//
//  Created by Eva Madarasz on 02/12/2021.
//

import UIKit



class HistoryListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var listModel: HistoryListModelProtocol = HistoryListModel(dataManager: CoreDataManager())
    
    
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "GoalCell", bundle: nil), forCellReuseIdentifier: "goalCell")
        tableView.register(UINib(nibName: "TaskCell",bundle: nil), forCellReuseIdentifier: "taskCell")
        tableView.register(UINib(nibName: "MonthlySummaryCell",bundle: nil), forCellReuseIdentifier: "summaryCell")
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.listModel.loadData()
            self.tableView.reloadData()
        }
       
    }
  
}

    // MARK: Tableview functions:
extension HistoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listModel.sectionRows[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let element = listModel.sectionRows[indexPath.section][indexPath.row]
        
        switch element.type {
        
        case .goal:
            if let cell: GoalCell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell {
                cell.configureCheckMarkedCell(item: element)
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
        let element = listModel.sectionRows[indexPath.section][indexPath.row]
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
        return self.listModel.sections.count
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.sectionHeaderTopPadding = 0
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let label = UILabel()
        label.frame = headerView.frame
        label.text = self.listModel.sections[section]
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .systemMint
        headerView.addSubview(label)

        return headerView
       
    }

}
