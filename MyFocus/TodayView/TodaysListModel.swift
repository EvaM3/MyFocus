//
//  TodaysListModel.swift
//  MyFocus
//
//  Created by Eva Madarasz on 22/11/2022.
//

import Foundation


class TodaysListModel {

var goalTitle = String()
var taskTitle = String()
var sections = [String]()
var sectionRows =  [[ListElement]]()
  
    
    func addGoal(goal: Goal) -> ListElement {
        
        let newGoal = ListElement(from: goal)
    
        return newGoal
    }
    
    
}
