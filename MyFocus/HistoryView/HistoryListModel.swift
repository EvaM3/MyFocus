//
//  HistoryListModel.swift
//  MyFocus
//
//  Created by Eva Madarasz on 11/08/2022.
//

import Foundation




struct HistoryListModel {
    
    private var dataManager = CoreDataManager()
    private let dateFormatter = DateFormatter()
    private var currentSummaryYearAndMonth: String?
    private var currentYearAndMonth: String?
    private var totalGoalsCounter = 0
    private var completedGoalsCounter = 0
    private let todayString = "Today"
    
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
    
    mutating func addToStats(goal: Goal) {
        totalGoalsCounter += 1
        
        if goal.completed {
            completedGoalsCounter += 1
        }
        
    }
    
    mutating func resetStats() {
        totalGoalsCounter = 0
        completedGoalsCounter = 0
    }
    
    
    mutating func addToSummary() -> (yearAndMonth: String, totalCount: Int, completedCount: Int) {
        let summary = (yearAndMonth: currentSummaryYearAndMonth ?? "", totalCount: totalGoalsCounter, completedCount: completedGoalsCounter)
        resetStats()
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "MM, yyyy"
        //        if currentSummaryYearAndMonth == nil {
        //            currentSummaryYearAndMonth = dateFormatter.string(from: goal.creationDate)
        //        } else {
        //            let currentGoalYearAndMonth = dateFormatter.string(from: goal.creationDate)
        //            if currentSummaryYearAndMonth != currentGoalYearAndMonth,
        //               let currentSummaryYearAndMonth = currentSummaryYearAndMonth {
        //                summary = (yearAndMonth: currentSummaryYearAndMonth, totalCount: totalGoalsCounter, completedCount: completedGoalsCounter)
        //                self.currentSummaryYearAndMonth = currentGoalYearAndMonth
        //                completedGoalsCounter = 0
        //                totalGoalsCounter = 0
        //            }
        //        }
        //
        //
        //        totalGoalsCounter += 1
        //
        //
        return summary
    }
    
    
    mutating func generateSummaryDate() -> String {
        let date = Date()
        dateFormatter.dateFormat = "MM/yyyy"
        let currentMonth = dateFormatter.string(from: date)
        return currentMonth
      
    }
     
    
    mutating func generateData(from: [Goal]) {
        var generatedSections: [String] = []
        var generatedRows: [[ListElement]] = []
        
        let sortedGoals = from.sorted { $1.creationDate > $0.creationDate }
        dateFormatter.dateFormat = "dd MM, yyyy"
        for goal in sortedGoals {
            if currentSummaryYearAndMonth == nil {
                currentSummaryYearAndMonth = dateFormatter.string(from: goal.creationDate)
            } else {
                let currentGoalYearAndMonth = dateFormatter.string(from: goal.creationDate)
                if currentSummaryYearAndMonth != currentGoalYearAndMonth,
                   let currentSummaryYearAndMonth = currentSummaryYearAndMonth {
                    let summary = addToSummary()
                    generatedSections.append(summary.yearAndMonth)
                    generatedRows.append([ListElement(summary: "From \(summary.totalCount) goals \(summary.completedCount) is completed")])
                    
                    self.currentSummaryYearAndMonth = currentGoalYearAndMonth
                    
                }
            }
            
            if Calendar.current.isDateInToday(goal.creationDate) {
                generatedSections.append(todayString)
            } else {
                let currentCreationDate = dateFormatter.string(from: goal.creationDate)
                generatedSections.append(currentCreationDate)
            }
            generatedRows.append(mapGoal(goal: goal))
        }
        
        
        
        
        let summary = addToSummary()
        generatedSections.append(generateSummaryDate())
        generatedRows.append([ListElement(summary: "From \(summary.totalCount) goals \(summary.completedCount) is completed")])
        
        self.sections = generatedSections.reversed()
        self.sectionRows = generatedRows.reversed()
        
      
        
        
    }
    
    
}
