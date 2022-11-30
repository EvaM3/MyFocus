//
//  TodaysListModel.swift
//  MyFocus
//
//  Created by Eva Madarasz on 22/11/2022.
//

import Foundation

protocol TodayListModel {
    func createGoal(with title: String)
    func addTask(with title: String)
    func loadData()
    func updateGoal(with title: String, completed: Bool)
    func update(taskID: UUID, with title: String, completed: Bool)
    func deleteGoal()
    func deleteTask(taskID: UUID)
}

class TodaysListModel {

   private var goal: Goal? = nil
    
    
    
    
    func createGoal(with title: String) {
        guard goal == nil else {
            return
        }
        goal = Goal(tasks: [], title: title, creationDate: Date())
    
    }
    
    
    func addTask(with title: String) {
        guard goal == nil else {
            return
        }
        goal = Goal(tasks: [], title: title, creationDate: Date())
        
        if goal?.tasks.count ?? 1 <= 3 {
            return
        }
        var newTask = Task(id: UUID(), title: title, completed: false, creationDate: Date())
    
      
    // check if there is a goal else return
    // check if the goal has 3 max. tasks, if yes, return
    // create a new task with the title(parameter)
    // append new task to the goal
        
    }
   
    func loadData() {
        
    }
    
    func updateGoal(with title: String, completed: Bool) {
        guard goal == nil else {
            return
        }
        goal = Goal(tasks: [], title: title, creationDate: Date())
        updateGoal(with: title, completed: false)
    
      // check if there is a goal else return
      // update goal title, complete status
        
    }
    
    func update(taskID: UUID, with title: String, completed: Bool) {
        guard goal == nil else {
            return
        }
        goal = Goal(tasks: [], title: title, creationDate: Date())
        update(taskID: UUID(), with: title, completed: false)
        
        // check if there is a goal else return
        // update task title, complete status update
        
    }
    
    
    func deleteGoal(title: String) {
        guard goal == nil else {
            return
        }
        goal = Goal(tasks: [], title: title, creationDate: Date())
        goal?.delete(title: title)
        
        // check if there is a goal else return
        // delete the goal
    }
    
    
    func deleteTask(taskID: UUID) {
        guard goal == nil else {
            return
        }
    
        // check if there is a goal else return
        // delete the task
    }
    

}
