//
//  TodaysView.swift
//  MyFocus
//
//  Created by Eva Sira Madarasz on 14/11/2022.
//

import Foundation
import UIKit



class TodaysViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var listModel: HistoryListModelProtocol = HistoryListModel(dataManager: CoreDataManager())
 
    
    
    
    
    override func viewDidLoad() {
        
        
           // tableView.dataSource = self
           // tableView.delegate = self
           // tableView.register(UINib(nibName: "GoalCell", bundle: nil), forCellReuseIdentifier: "goalCell")
           // tableView.register(UINib(nibName: "TaskCell",bundle: nil), forCellReuseIdentifier: "taskCell")
            super.viewDidLoad()
            DispatchQueue.main.async {
                self.listModel.loadData()
                self.tableView.reloadData()
            }
           
        }
        
    }
    
    // MARK: Tableview functions:
//extension TodaysViewController: UITableViewDelegate, UITableViewDataSource {
    
// }
    


