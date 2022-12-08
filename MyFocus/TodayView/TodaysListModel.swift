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
        // Ask DataController to create the goal.
        // checking if there is already a goal, to avoid overriding.
        guard goal == nil else {
            return
        }
        goal = Goal(tasks: [], title: title, creationDate: Date())
        
    }
    
    
    func addTask(with title: String) {
        guard var unwrappedGoal = goal else {
            return
        }
        
        if unwrappedGoal.tasks.count >= 4 {  // move it into line 38 (first guard)
            return
        }
        
        unwrappedGoal.addTask(title: title)
        goal = unwrappedGoal
        
        // check if there is a goal else return
        // check if the goal has 3 max. tasks, if yes, return
        // create a new task with the title(parameter)
        // append new task to the goal
        
    }
    
    func loadData() {
        
    }
    
    func updateGoal(with title: String, completed: Bool) {
        // Ask DataController to update the goal.
        guard var unwrappedGoal = goal else {
            return
        }
        if unwrappedGoal.title != title {
            unwrappedGoal.update(title: title)
        }
        if unwrappedGoal.completed != completed {
            unwrappedGoal.completed ? unwrappedGoal.undoCompleteGoal() :  unwrappedGoal.completeGoal()
        }
        goal = unwrappedGoal
    }
    
    
    func update(taskID: UUID, with title: String, completed: Bool) {
        // Ask DataController to update task.
        guard var unwrappedGoal = goal else {
            return
        }
        if unwrappedGoal.title != title {
            unwrappedGoal.update(title: title)
        }
        if unwrappedGoal.id != taskID {
            unwrappedGoal.updateTask(id: taskID, title: title)
        }
        if unwrappedGoal.completed != completed {
            unwrappedGoal.completed ? unwrappedGoal.undoCompleteGoal() :  unwrappedGoal.completeGoal()
        }
        goal = unwrappedGoal
        
        // check if there is a goal else return
        // update task title, complete status update
    }
    
    
    func deleteGoal() {
        // Ask DataController to delete the goal.
       goal = nil
    
    }
    
    
    func deleteTask(taskID: UUID) {
        // Ask DataController to delete the task.
        guard var unwrappedGoal = goal else {
            return
        }
         unwrappedGoal.deleteTask(id: taskID)
        
        // check if there is a goal else return
        // delete the task
    }
}
