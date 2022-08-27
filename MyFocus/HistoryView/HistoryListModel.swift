//
//  HistoryListModel.swift
//  MyFocus
//
//  Created by Eva Madarasz on 11/08/2022.
//

import Foundation
import UIKit



struct HistoryListModel {
    
    var dataManager = CoreDataManager()
    
    
    var sections = [String]()
    var sectionRows =  [[ListElement]]()
    
    mutating func loadData() {
        dataManager.generateRandomData()
        generateData(from: dataManager.loadGoal())
    }
    
    // MARK: Data loading functions
    
    func mapGoal(goal: Goal) -> [ListElement] {
        var elementArray = [ListElement]()
        let newGoalEntity = ListElement(from: goal)
        elementArray.append(newGoalEntity)
        for task in goal.tasks {
            let taskListElement = ListElement(from: task)
            elementArray.append(taskListElement)
        }
        return elementArray
    }
 
  
    
//    func monthlySummary(done: Goal, from: DateInterval) {
//        print("From\(from) goals \(done) is completed.")
//    }
//  
//    for goal in done {
//        for from in from {
//            monthlySummary(done: Goal, from: DateInterval)
//        }
//    }
    
    
    
    mutating func generateData(from: [Goal]) {
       // var monthlySummary : String = ""
        var generatedSections: [String] = []
        var generatedRows: [[ListElement]] = []
        
        let sortedGoals = from.sorted { $0.creationDate > $1.creationDate }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM, yyyy"
        for goal in sortedGoals {
            let currentCreationDate = dateFormatter.string(from: goal.creationDate)
            generatedSections.append(currentCreationDate)
            generatedRows.append(mapGoal(goal: goal))
        }
        
        self.sections = generatedSections
        self.sectionRows = generatedRows
    }
    
}


