//
//  customCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 21/07/2022.
//

import Foundation
import UIKit


class GoalCell: UITableViewCell {
    override func prepareForReuse() {
        let bgview = UIView.init(frame: self.frame)
        bgview.backgroundColor = .orange
        self.addSubview(bgview)
    }
 
}

class TaskCell: UITableViewCell {
    
 
}
