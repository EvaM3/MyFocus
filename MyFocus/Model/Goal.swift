//
//  Goal.swift
//  MyFocus
//
//  Created by Eva Madarasz on 14/12/2021.
//

import Foundation



class Goal {
    var tasks: [Task]
    var goalDescription: String
    var completed: Bool
    var goalCreationDate: Date?
    var goalAchievedDate: Date?
    
    
    init(tasks: [Task], goalDescription: String, completed: Bool, goalCreationDate: Date, goalAchievedDate: Date) {
        self.tasks = tasks
        self.goalDescription = goalDescription
        self.completed = false
        self.goalCreationDate = Date()
        self.goalAchievedDate = nil
    }
    
    func addTask(description: String) {
        let newTask = Task(description: description, completed: false, creationDate: Date())
        tasks.append(newTask)
        completed = false
    }
    
    
    func completeGoal() {
        if goalAchievedDate == nil {
            goalAchievedDate = Date()
        }
        if completed == false {
            completed = true
        }
        for i in 0..<tasks.count {
            tasks[i].completeTask()
        }
    }
    
    
    func undoCompleteGoal() {
        if goalAchievedDate != nil {
            goalAchievedDate = nil
        }
        if completed == true {
            completed = false
        }
        for i in 0..<tasks.count {
            tasks[i].unDoCompleteTask()
        }
    }
    
    
    func deleteTask(index: Int) {
        if index >= 0 && index < tasks.count {
            tasks.remove(at: index)
        } else {
            return
        }
    }
    
    
    func updateTask(index: Int, description: String) {
        if index >= 0 && index < tasks.count {
            tasks[index].updateTask(description: description)
            undoCompleteGoal()
        } else {
            return
        }
    }
    
    
    func undoCompleteTask(index: Int) {
        if index >= 0 && index < tasks.count {
            tasks[index].unDoCompleteTask()
            undoCompleteGoal()
        } else {
            return
        }
    }
    
    
    func taskAchieved() -> Bool {
        var allTasksAchieved : Bool = false
        
        for i in 0..<tasks.count {
            if tasks[i].self.completed == true {
                allTasksAchieved = true
            } else {
                allTasksAchieved = false
                break
            }
        }
        return allTasksAchieved
        
    }
}




