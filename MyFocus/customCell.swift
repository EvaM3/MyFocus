//
//  customCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 21/07/2022.
//

import Foundation
import UIKit


class GoalCell: UITableViewCell {
    
    private let tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "goalCell")
    } ()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
