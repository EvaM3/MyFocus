//
//  Goal.swift
//  MyFocus
//
//  Created by Eva Madarasz on 14/12/2021.
//

import Foundation



class Goal {
    private var goalTasks: [Task]
    private var goalDescription: String
    private var goalCompleted: Bool
    private var goalCreationDate: Date
    private var goalAchievedDate: Date?
    var description: String { goalDescription }
    var tasks: [Task] { goalTasks }
    var completed: Bool { goalCompleted }
    var creationDate: Date { goalCreationDate }
    var achievedDate: Date? { goalAchievedDate}
    
    
    
    init(tasks: [Task], description: String) {
        self.goalTasks = tasks
        self.goalDescription = description
        self.goalCompleted = false
        self.goalCreationDate = Date()
        self.goalAchievedDate = nil
    }
    
    func addTask(description: String) {
        let newTask = Task(description: description, completed: false, creationDate: Date())
        goalTasks.append(newTask)
        unCompleteGoal()
    }
    
    private func unCompleteGoal() {
        goalCompleted = false
        goalAchievedDate = nil
    }
    
    func completeGoal() {
        guard !goalTasks.isEmpty else {
            unCompleteGoal()
            return
        }
        
        if goalAchievedDate == nil {
            goalAchievedDate = Date()
        }
        
        if goalCompleted == false {
            goalCompleted = true
        }
        
        for i in 0..<goalTasks.count {
            goalTasks[i].completeTask()
        }
        
    }
    
    
    func undoCompleteGoal() {
        unCompleteGoal()
    }
    
    
    func deleteTask(index: Int) {
        if index >= 0 && index < goalTasks.count {
            goalTasks.remove(at: index)
        } else {
            return
        }
    }
    
    
    func updateTask(index: Int, description: String) {
        if index >= 0 && index < goalTasks.count {
            goalTasks[index].updateTask(description: description)
            undoCompleteGoal()
        } else {
            return
        }
    }
    
    
    func undoCompleteTask(index: Int) {
        if index >= 0 && index < goalTasks.count {
            goalTasks[index].unDoCompleteTask()
            undoCompleteGoal()
        } else {
            return
        }
    }
    
    func completeTask(index: Int) {
        if index >= 0 && index < goalTasks.count {
            goalTasks[index].completeTask()
            if allTasksAchieved() {
                completeGoal()
            }
        }
    }
    
    func allTasksAchieved() -> Bool {
        var allTasksAchieved : Bool = false
        
        for i in 0..<goalTasks.count {
            if goalTasks[i].self.completed == true {
                allTasksAchieved = true
            } else {
                allTasksAchieved = false
                break
            }
        }
        return allTasksAchieved
        
    }
}




