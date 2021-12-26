//
//  GoalTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 14/12/2021.
//

import XCTest
@testable import MyFocus

class GoalTests: XCTestCase {
    
    func test_initGoal() {
        var sut = Goal.init(tasks: [], goalDescription: "", completed: true, goalCreationDate: Date(), goalAchievedDate: Date())
        XCTAssertEqual(sut.goalDescription, "")
        XCTAssertTrue(sut.completed)
    }
    
    func test_addTask() {
        // ARRANGE:
        var sut = Goal(tasks: [], goalDescription: "", completed: false, goalCreationDate: Date(), goalAchievedDate: Date())
        XCTAssertEqual(sut.goalDescription, sut.goalDescription)
        XCTAssertFalse(sut.completed)
        // ACT:
        sut.addTask(description: "")
        // ASSERT:
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_addTaskAssertTrue() {
        // ARRANGE:
        var sut = Goal(tasks: [], goalDescription: "", completed: false, goalCreationDate: Date(), goalAchievedDate: Date())
        XCTAssertEqual(sut.goalDescription, sut.goalDescription)
        XCTAssertTrue(sut.completed)
        // ACT:
        sut.addTask(description: "")
        // ASSERT:
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_completeGoal() {
        // ARRANGE:
        var sut = Goal(tasks: [], goalDescription: "", completed: true, goalCreationDate: Date(), goalAchievedDate: Date())
        XCTAssertNotNil(sut.goalAchievedDate)
        XCTAssertTrue(sut.completed)
        // ACT:
        sut.completeGoal()
        // ASSERT:
        XCTAssertTrue(sut.completed)
    }
    
    func test_completeGoalAssertFalseCompletedFalse() {
        // ARRANGE:
        var sut = Goal(tasks: [], goalDescription: "", completed: true, goalCreationDate: Date(), goalAchievedDate: Date())
        XCTAssertNotNil(sut.goalAchievedDate)
        XCTAssertFalse(sut.completed)
        // ACT:
        sut.completeGoal()
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_unDoCompleteGoal() {
        // ARRANGE:
        var sut = Goal(tasks: [], goalDescription: "", completed: false, goalCreationDate: Date(), goalAchievedDate: Date())
        XCTAssertFalse(sut.completed)
        // ACT:
        sut.undoCompleteGoal()
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_unDoCompleteGoalAssertTrueCompletedTrue() {
        // ARRANGE:
        var sut = Goal(tasks: [], goalDescription: "", completed: false, goalCreationDate: Date(), goalAchievedDate: Date())
        XCTAssertTrue(sut.completed)
        // ACT:
        sut.undoCompleteGoal()
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_deleteTask() {
        // ARRANGE:
        var sut = Goal(tasks: [], goalDescription: "", completed: false, goalCreationDate: Date(), goalAchievedDate: Date())
        // ACT:
        sut.deleteTask(index: <#T##Int#>)
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_undoCompleteTask() {
        // ARRANGE:
        var sut = Goal(tasks: [], goalDescription: "", completed: false, goalCreationDate: Date(), goalAchievedDate: Date())
        // ACT:
        sut.undoCompleteTask(index: <#T##Int#>)
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_taskAchieved() {
        // ARRANGE:
        var sut = Goal(tasks: [], goalDescription: "", completed: true, goalCreationDate: Date(), goalAchievedDate: Date())
        // ACT:
        sut.taskAchieved()
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
}


