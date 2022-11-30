//
//  Goal.swift
//  MyFocus
//
//  Created by Eva Madarasz on 14/12/2021.
//

import Foundation



struct Goal: Identifiable, Equatable {
    static func == (lhs: Goal, rhs: Goal) -> Bool {
        return true
    }
    
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
    
    
    init(id: UUID = UUID(), tasks: [Task], title: String, completed: Bool = false, creationDate: Date, achievedDate: Date? = nil) {
        self.id = id
        self.goalTasks = tasks
        self.goalTitle = title
        self.goalCompleted = completed
        self.goalCreationDate = creationDate
        self.goalAchievedDate = achievedDate
        
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
    
    mutating func update(title: String) {
        goalTitle = title
        
    }
    
    mutating func delete(title: String) {
        goalTitle = title
        goalTitle.removeAll()
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




