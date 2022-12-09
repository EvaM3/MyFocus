//
//  TodaysListModelTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 07/12/2022.
//

import XCTest


@testable import MyFocus

//class TodayListSpy: TodayListModel {
//
//    var goal: Goal? = nil
//
//    func createGoal(with title: String) {
//
//        var goal = Goal(tasks: [], title: title, creationDate: Date())
//    }
//
//    func addTask(with title: String) {
//        var goal = Goal(tasks: [], title: title, creationDate: Date())
//        var goalTask = goal
//        goalTask.addTask(title: title)
//        goal = goalTask
//
//    }
//
//    func loadData() {
//
//    }
//
//    func updateGoal(with title: String, completed: Bool) {
//        <#code#>
//    }
//
//    func update(taskID: UUID, with title: String, completed: Bool) {
//        <#code#>
//    }
//
//    func deleteGoal() {
//        goal = nil
//    }
//
//    func deleteTask(taskID: UUID) {
//        var goalTask = goal
//        goalTask?.deleteTask(id: taskID)
//    }
//
//
//}

class TodaysListModelTests: XCTestCase {


    

    func test_goalCreationSuccess()  {
        
        // ARRANGE, ACT:
    let sut = TodaysListModel()
        
        
        // ASSERT:
 
        
    }
   

}
