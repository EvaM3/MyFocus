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
        
    }
    
    
    
    func test_initGoal() {
        
        let sut = makeSut()
        XCTAssertEqual(sut.description, TestDescriptions.testGoalDescription.rawValue)
        XCTAssertFalse(sut.completed)
        XCTAssertEqual(sut.tasks.count, 0)
        XCTAssertNil(sut.achievedDate)
        XCTAssertGreaterThan(Date(), sut.creationDate)
    }
    
    func test_initGoalWithTasks() {
        
        
        let goalTask1 = [Task(description: TestDescriptions.testGoalDescription.rawValue, completed: false, creationDate: Date(), achievedDate: Date())]
        
        let testTasks = [Task(description: TestDescriptions.taskDescription1.rawValue, completed: true, creationDate: Date(), achievedDate: Date())]
        let sut = makeSut(tasks: testTasks, description: TestDescriptions.testGoalDescription2.rawValue)
        let sut2 = makeSut(tasks:  goalTask1, description: TestDescriptions.testGoalDescription.rawValue)
        XCTAssertEqual(sut.description, TestDescriptions.testGoalDescription2.rawValue)
        XCTAssertFalse(sut.completed)
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertNil(sut.achievedDate)
        XCTAssertGreaterThan(Date(), sut.creationDate)
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
        sut.completeGoal()
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil(sut.achievedDate)
        
        // ACT:
        sut.addTask(description: TestDescriptions.taskDescription1.rawValue)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_completeGoal_WhenGoalWithoutTasks_ThenFailure() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertNil(sut.achievedDate)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil(sut.achievedDate)
    }
    
    func test_completeGoal_WhenTaskIsNotAchieved_ThenCompleted() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.addTask(description: "")
    
        // ACT:
        sut.completeGoal()
        sut.addTask(description: TestDescriptions.testGoalDescription.rawValue)
        
        // ASSERT:
        XCTAssertNotNil(sut.taskAchieved)
        XCTAssertNotNil(sut.addTask(description: TestDescriptions.testGoalDescription.rawValue))
        
        
    }
    
    func test_completeGoal_WhenTasksFinished_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertNotNil(sut.tasks.count)
    }
    
    func test_completeGoal_WhenGoalCompleted_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertNotNil(sut.completeGoal)
    }
    
    func test_unDoCompleteGoal_success() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_unDoCompleteGoal_WhenAchievedDateIsNil_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_unDoCompleteGoal_WhenAllTasksUnDone_ThenFinished() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertNil(sut.achievedDate)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        sut.undoCompleteTask(index: sut.tasks.count)
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


