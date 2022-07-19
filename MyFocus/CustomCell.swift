//
//  CustomCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 19/07/2022.
//

import Foundation
import UIKit


class GoalCustomCell: UITableViewCell {
    
    let cellReuseIdentifier = "goalCell"
    
    @IBOutlet weak var goalView: UIView!
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.row).")
        }
}

class TaskCustomCell: UITableView {
    
  let cellReuseIdentifier = "taskCell"
    
    @IBOutlet weak var taskView: UIView!
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("You tapped cell number \(indexPath.row).")
        }
}


