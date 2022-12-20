//
//  TodaysListModelTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 07/12/2022.
//

import XCTest


@testable import MyFocus



class TodaysListModelTests: XCTestCase {
    
    

    
    func test_initHasNoAffect() {
        
        // ARRANGE:
        
        let sut = makeSut()
        
        
        // ASSERT:
        
        XCTAssertNil(sut.todaysGoal)
    }
    
    
    
    func test_goalCreationSuccess()  {
        
        
        // ARRANGE:
        let sut = makeSut()
        
        
     // ACT:
        sut.createGoal(with: "")
        
        
        // ASSERT:
        XCTAssertNotNil(sut.todaysGoal)
        
        
        
    }
    
    func test_goalCreationNotOverridingExistingGoal() {
        
        // ARRANGE:
        
        let sut = makeSut()
        let firstGoalTitle = UUID().uuidString
        let secondGoalTitle = UUID().uuidString
        
      
        
        
        // ACT:
        
        sut.createGoal(with: firstGoalTitle)
        sut.createGoal(with: secondGoalTitle)
        
        
        // ASSERT:
        
        XCTAssertEqual(sut.todaysGoal?.title, firstGoalTitle )
       
    }
    
    
    func test_addTask_WhenTodaysGoalNil() {
        
        // ARRANGE:
        
        let sut = makeSut()
       
        
        // ACT:
        sut.addTask(with: "")
        
        // ASSERT:
        
        XCTAssertNil(sut.todaysGoal)
        
        
    }
    
    func test_addTask_WhenGoalCreatedAndTaskAdded() {
        
        // ARRANGE:
        
        let sut = makeSut()
     
        
        // ACT:
        
        sut.createGoal(with: "")
        sut.addTask(with: "")
        
        // ASSERT:
        
        XCTAssertEqual(sut.todaysGoal?.tasks.count, 1)
        
        
    }
    
    func test_addTask_maximumTaskNumberIsRespected() {
        
        // ARRANGE:
        
        let sut = makeSut()
       
        
        // ACT:
        sut.createGoal(with: "")
        for _ in 0...10 {
            sut.addTask(with: "")
        }
       
        // ASSERT:
        
        XCTAssertEqual(sut.todaysGoal?.tasks.count, Goal.maximumTasks)
    }
    
    
    func test_updateGoalWithNoGoal() {
        // ARRANGE:
        
        let sut = makeSut()
        
        // ACT:
        sut.updateGoal(with: "", completed: false)
        
        // ASSERT:
        XCTAssertNil(sut.todaysGoal)
    }
    
    
    func test_updateGoalWithGoal() {
        
        // ARRANGE:
        
        let sut = makeSut()
        let newTitle = UUID().uuidString
        
        // ACT:
        sut.createGoal(with: "")
        sut.updateGoal(with: newTitle, completed: false)
        
        
        // ASSERT:

        XCTAssertEqual(sut.todaysGoal?.title, newTitle)
    }
    
    func test_updateGoalCompletionToggle() {
        
        // ARRANGE:
        
        let sut = makeSut()
        
        // ACT:
        sut.createGoal(with: "")
        sut.addTask(with: "")
        sut.updateGoal(with: "", completed: true)
        
        
        // ASSERT:
        XCTAssertEqual(sut.todaysGoal?.completed, true)
        
        sut.updateGoal(with: "", completed: false)
        XCTAssertEqual(sut.todaysGoal?.completed, false)
        
    }
    
    func test_updateTaskWithTask() {
        
        
    // ARRANGE:
        
    let sut = makeSut()
    let newTaskTitle = UUID().uuidString
        
        
    // ACT:
    
        sut.createGoal(with: "!")
        sut.addTask(with: "A")
        guard let testTaskId = sut.todaysGoal?.tasks[0].id else {
            XCTFail("Task ID cannot be found")
            return
        }
      
    // ASSERT:
 
        sut.update(taskID: testTaskId, with: newTaskTitle, completed: false)
        XCTAssertEqual(sut.todaysGoal?.tasks[0].title, newTaskTitle)

    }
    
    func test_updateTaskWithNoTask() {
        // ARRANGE:
            
        let sut = makeSut()
        
        // ACT:
        
        sut.createGoal(with: "!")
        sut.update(taskID: UUID(), with: "", completed: false)
        
        
        // ASSERT:
        
        XCTAssertTrue(((sut.todaysGoal?.completed) != nil))
        
    }
    
    
    func test_deleteGoalWithGoal() {
        // ARRANGE:
        
        let sut = makeSut()
    
        // ACT:
        sut.createGoal(with: "")
        sut.deleteGoal()
        
        // ASSERT:
        XCTAssertNil(sut.todaysGoal)
    }
    
    func test_deleteGoalWithNoGoal() {
        
        // ARRANGE:
        
        let sut = makeSut()
    
        // ACT:
        sut.deleteGoal()
        
        // ASSERT:
        XCTAssertNil(sut.todaysGoal)
        
    }
  

    func test_deleteTaskWithTask() {
     
        // ARRANGE:
        
        let sut = makeSut()
        let taskId = UUID()
        
    
        // ACT:
        
        sut.addTask(with: "!")
        sut.deleteTask(taskID: taskId)
        
        // ASSERT:
        XCTAssertNil(sut.todaysGoal?.tasks)
    }
    
    func test_deleteTaskWithNoTask() {
        
        // ARRANGE:
           
        let sut = makeSut()
        let taskId = UUID()
        
        // ACT:
        sut.deleteTask(taskID: taskId)
        
        // ASSERT:
        XCTAssertNil(sut.todaysGoal?.tasks)
        
    }
    
    private func makeSut() -> TodaysListModel {
        return TodaysListModel()
    }
}
