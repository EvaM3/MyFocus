//
//  HistoryListModel.swift
//  MyFocus
//
//  Created by Eva Madarasz on 11/08/2022.
//

import Foundation



struct HistoryListModel {
    
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
}
 

