//
//  GoalTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 14/12/2021.
//

import XCTest
@testable import MyFocus

class GoalTests: XCTestCase {
    
    enum TestDescriptions: String {
        case testGoalDescription = "Finish the book"
        case testGoalDescription2 = "Go jogging"
        case taskDescription1 = "Take a walk"
        case taskDescription2 = "Go grocery shopping"
        case taskDescription3 = "Shop fot the birthday present"
        case taskDescription4 = "Call your best friend"
        
    }
    
    
    
    func test_initGoal() {
        
        let sut = makeSut()
        XCTAssertEqual(sut.description, TestDescriptions.testGoalDescription.rawValue)
        XCTAssertFalse(sut.completed)
        XCTAssertEqual(sut.tasks.count, 0)
        XCTAssertNil(sut.achievedDate)
        XCTAssertGreaterThan(Date(), sut.creationDate)
        
    }
    
    func test_initGoalWithUncomletedTask() {
        
        let sut = makeSut()
        sut.addTask(description: TestDescriptions.taskDescription1.rawValue)
        XCTAssertEqual(sut.description, TestDescriptions.testGoalDescription.rawValue)
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
        XCTAssertGreaterThan(Date(), sut.creationDate)
        
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertEqual(sut.tasks[0].description,TestDescriptions.taskDescription1.rawValue)
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertNil(sut.tasks[0].achievedDate)
    }
    
    
    func test_initGoalWithTasks() {
        
        let testTasks = [Task(description: TestDescriptions.taskDescription1.rawValue, completed: true, creationDate: Date(), achievedDate: Date())]
        let sut = makeSut(tasks: testTasks, description: TestDescriptions.testGoalDescription2.rawValue)
        XCTAssertEqual(sut.description, TestDescriptions.testGoalDescription2.rawValue)
        XCTAssertFalse(sut.completed)
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertNil(sut.achievedDate)
        XCTAssertGreaterThan(Date(), sut.creationDate)
    }
    
    func test_initGoalWithMoreTasks() {
        
        let sut = makeSut()
        sut.addTask(description: TestDescriptions.taskDescription3.rawValue)
        XCTAssertEqual(sut.description, TestDescriptions.testGoalDescription.rawValue)
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
        XCTAssertGreaterThan(Date(), sut.creationDate)
        
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertNotEqual(sut.tasks[0].description,TestDescriptions.taskDescription1.rawValue)
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertNil(sut.tasks[0].achievedDate)
    }
    
    func test_addTask_success() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.addTask(description: TestDescriptions.taskDescription1.rawValue)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_addTask_WhenCompletedTrue_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.addTask(description: TestDescriptions.taskDescription1.rawValue)
        sut.completeGoal()
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil(sut.achievedDate)
        
        // ACT:
        sut.addTask(description: TestDescriptions.taskDescription1.rawValue)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertEqual(sut.tasks.count, 2)
        XCTAssertNil(sut.achievedDate)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertFalse(sut.tasks[1].completed)
    }
    
    
    func test_completeGoal_WhenGoalWithoutTasks_ThenFailure() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertNil(sut.achievedDate)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_completeGoal_WhenTaskIsNotAchieved_ThenCompleted() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.addTask(description: TestDescriptions.taskDescription1.rawValue)
        
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.achievedDate)
        XCTAssertNotNil(sut.tasks[0].achievedDate)
    }
    
    func test_completeGoal_WhenMoreThanOneTasks_ThenCompleted() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.addTask(description: TestDescriptions.taskDescription1.rawValue)
        sut.addTask(description: TestDescriptions.taskDescription2.rawValue)
        
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.achievedDate)
        XCTAssertNotNil(sut.tasks[0].achievedDate)
        XCTAssertTrue(sut.tasks[1].completed)
        XCTAssertNotNil(sut.tasks[1].achievedDate)
    }
    
    func test_completeGoal_WhenMoreTasksOneAchieved_ThenCompleted() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.addTask(description: TestDescriptions.taskDescription1.rawValue)
        sut.addTask(description: TestDescriptions.taskDescription2.rawValue)
        sut.completeTask(index: 0)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertFalse(sut.tasks[1].completed)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.achievedDate)
        XCTAssertNotNil(sut.tasks[0].achievedDate)
        XCTAssertTrue(sut.tasks[1].completed)
        XCTAssertNotNil(sut.tasks[1].achievedDate)
    }
    
    func test_completeGoal_WhencompleteTaskWhenAllCompleted_ThenGoalCompleted() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.addTask(description: TestDescriptions.taskDescription3.rawValue)
        sut.addTask(description: TestDescriptions.taskDescription4.rawValue)
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertFalse(sut.tasks[1].completed)
        
        // ACT:
        sut.completeTask(index: 0)
        XCTAssertFalse(sut.completed)
        sut.completeTask(index: 1)
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.achievedDate)
        XCTAssertNotNil(sut.tasks[0].achievedDate)
        XCTAssertTrue(sut.tasks[1].completed)
        XCTAssertNotNil(sut.tasks[1].achievedDate)
    }
    
    func test_WhenOneTaskCompleted_ThenGoalCompleted() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.addTask(description: TestDescriptions.taskDescription3.rawValue)
        XCTAssertFalse(sut.tasks[0].completed)
        
        // ACT:
        sut.completeTask(index: 0)
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.achievedDate)
        
    }
    
    
    func test_unDoCompleteGoal_WhenOneTaskIsUnDone_ThenNotCompleted() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.addTask(description: TestDescriptions.taskDescription1.rawValue)
        sut.undoCompleteTask(index: 0)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    
    func test_undoCompleteGoal_WhenAllTasksUnDone_ThenNotCompleted() {
        
        // ARRANGE:
        let sut = makeSut()
        
        
        // ACT:
        sut.undoCompleteTask(index: sut.tasks.count)
        sut.undoCompleteGoal()
        
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    
    
    
    func test_unDoCompleteGoal_WhenAchievedDateIsNil_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
      
    
        
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertNil(sut.tasks[0].achievedDate)
        XCTAssertNil(sut.achievedDate)
    }
    
    
    func test_unDoCompletGoal_WhenCompletedIsFalse_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_deleteTask_success() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.deleteTask(index: 1)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_deleteTask_WhenAchievedDateIsNil_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.deleteTask(index: 1)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_undoCompleteTask_success() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.undoCompleteTask(index: 1)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_undoCompleteTask_WhenAchievedDateIsNil_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.undoCompleteTask(index: 1)
        
        // ASSERT:
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_undoCompleteTask_WhenUnDoCompleteGoalIsCalled_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertNil(sut.achievedDate)
    }
    
    
    func makeSut(tasks: [Task] = [], description: String = TestDescriptions.testGoalDescription.rawValue) -> Goal {
        let sut = Goal(tasks: tasks, description: description)
        
        return sut
    }
}


