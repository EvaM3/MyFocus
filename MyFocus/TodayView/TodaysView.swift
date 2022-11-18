//
//  TodaysView.swift
//  MyFocus
//
//  Created by Eva Madarasz on 14/11/2022.
//

import Foundation
import UIKit



class TodaysViewController: UIViewController {
  

//    @IBOutlet weak var tableView: UITableView!
//
//
//
//    var listModel: HistoryListModelProtocol = HistoryListModel(dataManager: CoreDataManager())
//
//    var todaysItems: [ListElement] = [ListElement]()
//
//
//
//    override func viewDidLoad() {
//
//
//            tableView.dataSource = self
//            tableView.delegate = self
//            tableView.register(UINib(nibName: "GoalCell", bundle: nil), forCellReuseIdentifier: "goalCell")
//            tableView.register(UINib(nibName: "TaskCell",bundle: nil), forCellReuseIdentifier: "taskCell")
//            super.viewDidLoad()
//            DispatchQueue.main.async {
//                self.listModel.loadData()
//                self.tableView.reloadData()
//            }
//
//        }
//
//    }
//
//    // MARK: Tableview functions:
//
//extension TodaysViewController: UITableViewDataSource, UITableViewDelegate {
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todaysItems.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let todaysItem = todaysItems[indexPath.row]
//
//        switch todaysItem.type {
//
//        case .goal:
//            if let cell: GoalCell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell {
//                cell.configureCheckMarkedCell(item: todaysItem)
//                return cell
//            }
//
//        case .task:
//            if let cell: TaskCell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskCell {
//                cell.configureCheckMarkedCell(item: todaysItem)
//                return cell
//            }
//
//        case .summary: break
//
//        }
//
//
//
//
//
//
//}
}
