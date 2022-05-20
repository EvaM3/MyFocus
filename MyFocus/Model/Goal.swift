//
//  Goal.swift
//  MyFocus
//
//  Created by Eva Madarasz on 14/12/2021.
//

import Foundation



struct Goal: Identifiable {
    var id: UUID
    
    private var goalTasks: [Task]
    private var goalTitle: String
    private var goalCompleted: Bool
    private var goalCreationDate: Date
    private var goalAchievedDate: Date?
    var title: String { goalTitle }
    var tasks: [Task] { goalTasks }
    var completed: Bool { goalCompleted }
    var creationDate: Date { goalCreationDate }
    var achievedDate: Date? { goalAchievedDate}
    
    
    init(tasks: [Task], title: String) {
        self.id = UUID()
        self.goalTasks = tasks
        self.goalTitle = title
        self.goalCompleted = false
        self.goalCreationDate = Date()
        self.goalAchievedDate = nil
    }
    
    
    mutating func addTask(title: String) {
        let newTask = Task(id: UUID(), title: title, completed: false, creationDate: Date())
        goalTasks.append(newTask)
        unCompleteGoal()
    }
    
    private mutating func unCompleteGoal() {
        for i in 0..<goalTasks.count {
            if let taskDate =  goalTasks[i].achievedDate,
               let goalDate = goalAchievedDate,
               taskDate >= goalDate {
                goalTasks[i].unDoCompleteTask()
            }
        }
        
        goalCompleted = false
        goalAchievedDate = nil
    }
    
    mutating func completeGoal() {
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
    
    
    mutating func undoCompleteGoal() {
        
        unCompleteGoal()
    }
    
    
    mutating func deleteTask(index: Int) {
        if index >= 0 && index < goalTasks.count {
            goalTasks.remove(at: index)
        } else {
            return
        }
    }
    
    
    mutating func updateTask(index: Int, title: String) {
        if index >= 0 && index < goalTasks.count {
            goalTasks[index].updateTask(title: title)
            undoCompleteGoal()
        } else {
            return
        }
    }
    
    
    mutating func undoCompleteTask(index: Int) {
        if index >= 0 && index < goalTasks.count {
            goalTasks[index].unDoCompleteTask()
            undoCompleteGoal()
        } else {
            return
        }
    }
    
    mutating func completeTask(index: Int) {
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




