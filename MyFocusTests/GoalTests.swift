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
        let sut = makeSut()
        XCTAssertEqual(sut.goalDescription, "")
        XCTAssertFalse(sut.completed)
    }
    
    
    func test_addTask() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertEqual(sut.goalDescription, sut.goalDescription)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.addTask(description: "")
        
        // ASSERT:
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_addTaskAssertTrue() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertEqual(sut.goalDescription, sut.goalDescription)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.addTask(description: "")
        
        // ASSERT:
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_completeGoal() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertNil(sut.goalAchievedDate)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil(sut.goalAchievedDate)
    }
    
    func test_completeGoal_WhenAssertTrue_ThenCompletedFalse() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertNil(sut.goalAchievedDate)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
    }
    
    func test_unDoCompleteGoal() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_unDoCompleteGoal_AssertTrueCompletedTrue() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_deleteTask() {
        
        // ARRANGE:
         let sut = makeSut()
        
        // ACT:
        sut.deleteTask(index: 0)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_deleteTaskAssertTrue() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.deleteTask(index: 0)
        
        // ASSERT:
        XCTAssertTrue(sut.completed != nil)
    }
    
    func test_undoCompleteTask() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.undoCompleteTask(index: 0)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_undoCompleteTask_AssertFalse() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.undoCompleteTask(index: 0)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    
    func test_taskAchieved() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.taskAchieved()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_taskAchievedAssertFalse() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.taskAchieved()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func makeSut() -> Goal {
      let sut = Goal(tasks: [], goalDescription: "")
        return sut
    }
}


