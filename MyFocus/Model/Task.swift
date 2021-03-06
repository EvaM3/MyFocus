//
//  Task.swift
//  MyFocus
//
//  Created by Eva Madarasz on 02/12/2021.
//

import Foundation


struct Task: Identifiable {
    var id: UUID
    var title: String
    var completed: Bool
    var creationDate: Date
    var achievedDate: Date?
    
    
    
    
    mutating func unDoCompleteTask() {
        if achievedDate != nil {
            achievedDate = nil
        }
        if completed {
            completed = false
        }
    }
    
    
    mutating func completeTask() {
        
        if achievedDate == nil {
            achievedDate = Date()
        }
        if !completed {
            completed = true
        }
    }
    
    
    mutating func updateTask(title: String) {
        
        self.title = title
        unDoCompleteTask()
        if creationDate != Date() {
            creationDate = Date()
        }
    }
}

