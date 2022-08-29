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
    var currentSummaryYearAndMonth: String?
    var totalGoalsCounter = 0
    var completedGoalsCounter = 0
    
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
    

    mutating func addToSummary(goal: Goal) -> Bool {
        var summaryCreationRequired = true
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM, yyyy"
        currentSummaryYearAndMonth = dateFormatter.string(from: goal.creationDate)
        
        
        totalGoalsCounter += 1
        
        if goal.completed  {
            completedGoalsCounter += 1
        }
        return summaryCreationRequired
    }
    
    mutating func generateData(from: [Goal]) {
        var generatedSections: [String] = []
        var generatedRows: [[ListElement]] = []
        
        let sortedGoals = from.sorted { $0.creationDate > $1.creationDate }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM, yyyy"
        for goal in sortedGoals {
            
            if addToSummary(goal: goal) {
                generatedSections.append(currentSummaryYearAndMonth ?? "")
                generatedRows.append([ListElement(summary: "From \(totalGoalsCounter) goals \(completedGoalsCounter) is completed")])
            }
            
            let currentCreationDate = dateFormatter.string(from: goal.creationDate)
            generatedSections.append(currentCreationDate)
            generatedRows.append(mapGoal(goal: goal))
            
        }
        
        self.sections = generatedSections
        self.sectionRows = generatedRows
    }
    
}


