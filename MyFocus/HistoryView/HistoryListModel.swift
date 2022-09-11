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
    var currentYearAndMonth: String?
    var totalGoalsCounter = 0
    var completedGoalsCounter = 0
    let todayString = "Today"

    var sections = [String]()
    var sectionRows =  [[ListElement]]()

    mutating func loadData() {
      //  dataManager.generateRandomData()
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


    mutating func addToSummary(goal: Goal) -> (yearAndMonth: String, totalCount: Int, completedCount: Int)? {

        var summary: (yearAndMonth: String, totalCount: Int, completedCount: Int)?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM, yyyy"
        if currentSummaryYearAndMonth == nil {
            currentSummaryYearAndMonth = dateFormatter.string(from: goal.creationDate)
        } else {
            let currentGoalYearAndMonth = dateFormatter.string(from: goal.creationDate)
            if currentSummaryYearAndMonth != currentGoalYearAndMonth,
            let currentSummaryYearAndMonth = currentSummaryYearAndMonth {
                summary = (yearAndMonth: currentSummaryYearAndMonth, totalCount: totalGoalsCounter, completedCount: completedGoalsCounter)
                self.currentSummaryYearAndMonth = currentGoalYearAndMonth
                completedGoalsCounter = 0
                totalGoalsCounter = 0
        }
        }

        
        totalGoalsCounter += 1

        
        return summary
    }

    
    
    mutating func generateData(from: [Goal]) {
        var generatedSections: [String] = []
        var generatedRows: [[ListElement]] = []

        let sortedGoals = from.sorted { $1.creationDate > $0.creationDate }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM, yyyy"
        for goal in sortedGoals {

            if  let summary = addToSummary(goal: goal) {
                generatedSections.append(summary.yearAndMonth)
                generatedRows.append([ListElement(summary: "From \(summary.totalCount) goals \(summary.completedCount) is completed")])
            }
            
            let date = Date()
            let currentCreationDate = dateFormatter.string(from: goal.creationDate)
            let todaysDate = dateFormatter.string(from: date)
             
            if currentCreationDate == todaysDate {
                generatedSections.append(todayString)
            } else {
            generatedSections.append(currentCreationDate)
            generatedRows.append(mapGoal(goal: goal))

        }
        }
        self.sections = generatedSections.reversed()
        self.sectionRows = generatedRows.reversed()

    }
    
//    mutating func isToday() {
//        let calendar: Calendar = Calendar.current
//        let date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = " dd MM/yyyy"
//        let currentDay = dateFormatter.string(from: date)
//
//
//        if let currentDay = currentCre
//
//    }
    
    

//    func isTodays(date1: Date, date2: Date) -> Bool {
//        let diff = Calendar.current.dateComponents([.day], from: date1,to: date2)
//
//        var today = Calendar.current.compare(date1, to: date2, toGranularity: .day) == .orderedSame
//        if diff.day == 0 {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    mutating func generateTodaysGoal(from: [Goal]) {
//        var todaysSection: String = "Today"
//        var todaysRows: [[ListElement]] = []
//
//
//
//
//}

}
