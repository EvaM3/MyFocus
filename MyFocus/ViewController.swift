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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        
}

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
       // self.present(changeCancelAndEditTasks(indexPath: indexPath), animated: true)
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
    }
}
