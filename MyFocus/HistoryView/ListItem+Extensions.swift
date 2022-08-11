//
//  ListItem+Extensions.swift
//  MyFocus
//
//  Created by Eva Madarasz on 10/08/2022.
//

import UIKit

struct ListElement {
    
    enum ListEntityType {
        case task
        case goal
        case summary
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
   
    init(goal: Goal) {
        self.type = .summary
        self.title = goal.title
        self.isCompleted = goal.completed
        self.achievedDate = goal.achievedDate
        self.creationDate = goal.creationDate
    }
    
}
