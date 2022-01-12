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
        var sut = makeSut()
        XCTAssertEqual(sut.goalDescription, "")
        XCTAssertFalse(sut.completed)
    }
    
    func test_addTask() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssertEqual(sut.goalDescription, sut.goalDescription)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.addTask(description: "")
        
        // ASSERT:
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_addTaskAssertTrue() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssertEqual(sut.goalDescription, sut.goalDescription)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.addTask(description: "")
        
        // ASSERT:
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_completeGoal() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssertNil(sut.goalAchievedDate)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil(sut.goalAchievedDate)
    }
    
    func test_completeGoal_WhenAssertFalse_ThenCompletedFalse() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssertNotNil(sut.goalAchievedDate)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_unDoCompleteGoal() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_unDoCompleteGoal_AssertTrueCompletedTrue() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_deleteTask() {
        
        // ARRANGE:
        var sut = makeSut()
        
        // ACT:
        sut.deleteTask(index: 0)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_deleteTaskAssertTrue() {
        
        // ARRANGE:
        var sut = makeSut()
        
        // ACT:
        sut.deleteTask(index: 0)
        
        // ASSERT:
        XCTAssertTrue(sut.completed != nil)
    }
    
    func test_undoCompleteTask() {
        
        // ARRANGE:
        var sut = makeSut()
        
        // ACT:
        sut.undoCompleteTask(index: 0)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_undoCompleteTask_AssertFalse() {
        
        // ARRANGE:
        var sut = makeSut()
        
        // ACT:
        sut.undoCompleteTask(index: 0)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    
    func test_taskAchieved() {
        
        // ARRANGE:
        var sut = makeSut()
        
        // ACT:
        sut.taskAchieved()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_taskAchievedAssertFalse() {
        
        // ARRANGE:
        var sut = makeSut()
        
        // ACT:
        sut.taskAchieved()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func makeSut() -> Goal {
      var sut = Goal(tasks: [], goalDescription: "")
        return sut
    }
}


