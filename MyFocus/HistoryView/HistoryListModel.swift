//
//  HistoryListModel.swift
//  MyFocus
//
//  Created by Eva Madarasz on 11/08/2022.
//

import Foundation
import UIKit



struct HistoryListModel {
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dataManager = CoreDataManager()
    
    
    var sections = [String]()
    var sectionRows =  [[ListElement]]()
    
    init() {
        sections = ["July 2022","Today","10-07-2022","11-07-2022","12-07-2022"]
        
        sectionRows = [
            [ListElement(type: .summary, title: "One of 2 is done", isCompleted: true)],
            [ListElement.init(from: Goal(tasks: [], title: " Finish the essay", creationDate: Date())), ListElement.init(from: Task(id: UUID(), title: "Read the last pages over again", completed: true, creationDate: Date()))],
            [ListElement.init(from: Goal(tasks: [Task(id: UUID(), title: "Go grocery shopping for ingredients", completed: false, creationDate: Date())], title: "Bake the cake", creationDate: Date()))],
            [ListElement.init(from: Goal(tasks: [Task(id: UUID(), title: "Clean kitchen and bathroom", completed: false, creationDate: Date())], title: "Do the housekeeping chores", creationDate: Date()))],
            []
        ]
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
    
    func generateData(from: [Goal]) {
        var context = dataManager.persistentContainer.viewContext
        let goalItem = GoalEntity(context: context)
        let goalItemTitle = goalItem.title
        let goalItemTasks = goalItem.defaultTasks
        let goalitemCompleted = goalItem.completed
        let goalitemCreation = goalItem.creationDate
        
      //  var goalData = [[CoreDataManager.mapToGoal]]
        var generatedSections: [String] = []
        var generatedRows: [[ListElement]] = []
        var generatedGoals: [Goal] = []
        
        let sortedGoals = from.sorted { $0.creationDate > $1.creationDate }
        for goal in sortedGoals {
            generatedRows.append(mapGoal(goal: goal))
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM, yyyy"
        for goal in sortedGoals {
            let currentCreationDate = dateFormatter.string(from: goal.creationDate)
           // generatedSections.append(currentCreationDate)
            generatedRows.append(mapGoal(goal: goal))
        }
        
    }

}
 

