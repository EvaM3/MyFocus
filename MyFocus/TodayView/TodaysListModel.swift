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
  
    
    
    
  func addGoal(goal: Goal) -> String {
        
        var newGoal = goalTitle
        newGoal.append(contentsOf: taskTitle)
        
    
        return newGoal
    }
    
    func addTask(task: Task) -> String {
        var newTask = taskTitle
        
        return taskTitle
    }
    
    
    func noGoalWithoutTask() {
        if goalTitle.isEmpty {
            
        }
    }
}
