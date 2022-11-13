//
//  HistoryListModel.swift
//  MyFocus
//
//  Created by Eva Madarasz on 11/08/2022.
//

import Foundation


protocol HistoryListModelProtocol  {
    var sections: [String] { get }
    var sectionRows: [[ListElement]] { get }
    
   func loadData()
}



class HistoryListModel: HistoryListModelProtocol {
  
    
    
    private var dataManager: CoreDataLoaderProtocol
    private let goalSectionDateFormatter = DateFormatter()
    private let summarySectionDateFormatter = DateFormatter()
    private var currentSummaryYearAndMonth: String?
    private var currentYearAndMonth: String?
    private var totalGoalsCounter = 0
    private var completedGoalsCounter = 0
    private let todayString = "Today"
    
    
    var sections = [String]()
    var sectionRows =  [[ListElement]]()
    
    init(dataManager: CoreDataLoaderProtocol) {
        self.dataManager = dataManager
    }
    
    func loadData() {
        //dataManager.generateRandomData()
        generateData(from: dataManager.loadGoal(predicate: nil))
    }
    
    // MARK: Data loading functions
    
    private func mapGoal(goal: Goal) -> [ListElement] {
        var elementArray = [ListElement]()
        let newGoalEntity = ListElement(from: goal)
        elementArray.append(newGoalEntity)
        for task in goal.tasks {
            let taskListElement = ListElement(from: task)
            elementArray.append(taskListElement)
        }
        return elementArray
    }
    
    private func addToStats(goal: Goal) {
        totalGoalsCounter += 1
        
        if goal.completed {
            completedGoalsCounter += 1
        }
        
    }
    
    private func resetStats() {
        totalGoalsCounter = 0
        completedGoalsCounter = 0
    }
    
    
    private func addToSummary() -> (yearAndMonth: String, totalCount: Int, completedCount: Int) {
        let summary = (yearAndMonth: currentSummaryYearAndMonth ?? "", totalCount: totalGoalsCounter, completedCount: completedGoalsCounter)
        
        resetStats()
       
        return summary
    }
    
   
    private func generateData(from: [Goal]) {
        var generatedSections: [String] = []
        var generatedRows: [[ListElement]] = []
        
        let sortedGoals = from.sorted { $1.creationDate > $0.creationDate }
        self.summarySectionDateFormatter.dateFormat = "MM/yyyy"
        self.goalSectionDateFormatter.dateFormat = "dd MM, yyyy"
        for goal in sortedGoals {
            if self.currentSummaryYearAndMonth == nil {
                self.currentSummaryYearAndMonth = summarySectionDateFormatter.string(from: goal.creationDate)
            } else {
                let currentGoalYearAndMonth = summarySectionDateFormatter.string(from: goal.creationDate)
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
                let currentCreationDate = goalSectionDateFormatter.string(from: goal.creationDate)
                generatedSections.append(currentCreationDate)
            }
            addToStats(goal: goal)
            generatedRows.append(mapGoal(goal: goal))
        }
        
        
        
        
        let summary = addToSummary()
        generatedSections.append(self.currentSummaryYearAndMonth ?? "")
        generatedRows.append([ListElement(summary: "From \(summary.totalCount) goals \(summary.completedCount) is completed")])
        resetStats()
        self.sections = generatedSections.reversed()
        self.sectionRows = generatedRows.reversed()
        
        
        
        
    }
    
    
}

