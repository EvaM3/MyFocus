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
    
    
    func test_addTask_success() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertEqual(sut.goalDescription, sut.goalDescription)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.addTask(description: "")
        
        // ASSERT:
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_addTask_WhenCompletedTrue_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.completed = true
        
        // ACT:
        sut.addTask(description: "")
        
        // ASSERT:
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_completeGoal_success() {
        
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
    
    func test_completeGoal_WhenCompletedIsTrue_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
    }
    
    func test_unDoCompleteGoal_success() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_unDoCompleteGoal_WhenAchievedDateIsNil_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_deleteTask_success() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.deleteTask(index: 0)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_deleteTask_WhenAchievedDateIsNil_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.deleteTask(index: 0)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    func test_undoCompleteTask_success() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.undoCompleteTask(index: 0)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
    }
    
    func test_undoCompleteTask_WhenAchievedDateIsNil_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT:
        sut.undoCompleteTask(index: 0)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.goalAchievedDate)
    }
    
    
    func test_taskAchieved_success() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.completed = true
        
        // ACT:
        sut.taskAchieved()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
    }
    
    func test_taskAchieved_WhenAchievedDateIsNotNil_ThenSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        sut.completed = true
        sut.goalAchievedDate = Date()
        
        // ACT:
        sut.taskAchieved()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil(sut.goalAchievedDate)
    }
    
    
    func makeSut() -> Goal {
        let sut = Goal(tasks: [], goalDescription: "")
        return sut
    }
}


