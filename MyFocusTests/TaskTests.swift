//
//  TaskTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 02/12/2021.
//

import XCTest
@testable import MyFocus

class TaskTests: XCTestCase {
    
    let description1 = "Buy a few books"
    let description2 = "Buy some flowers"
    let description3 = "Learn Russian today"
    
    func test_init() {
        let sut = makeSut()
        XCTAssertEqual(sut.description, description1)
        XCTAssertFalse(sut.completed, "Expected false, got \(sut.completed)")
    }
    
    func test_completeTask_success() {
        
        // ARRANGE:
        var sut = makeSut()
        
        // ACT:
        sut.completeTask()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil(sut.achievedDate)
    }
    
    func test_completeTask_WhenCompletedTrue_ThenSuccess() {
        
        // ARRANGE:
        var sut = makeSut()
        sut.completed = true
        
        // ACT:
        sut.completeTask()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil(sut.achievedDate)
    }
    
    func test_completeTask_WhenAchievedDateNotNil_ThenSuccess() {
        
        // ARRANGE:
        let date = Date()
        var sut = makeSut()
        sut.achievedDate = date
        
        // ACT:
        sut.completeTask()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil(sut.achievedDate)
        XCTAssertNotEqual(date, sut.achievedDate)
    }
    

    func test_undoCompletedTask() {
        
        // ARRANGE:
        var sut = makeSut()
        sut.completeTask()
        XCTAssert(sut.description == description3)
        XCTAssertTrue(sut.completed, "Expected true, got \(sut.completed)")
        
        // ACT:
        sut.unDoCompleteTask()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    
    func test_undoCompleteTask_WhenCompletedTrue_ThenFalseandNil() {
        
        // ARRANGE:
        var sut = makeSut()
        sut.completed = true
        XCTAssert(sut.description == description3)
        XCTAssertTrue(sut.completed, "Expected true, got \(sut.completed)")
        
        // ACT:
        sut.unDoCompleteTask()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_undoCompleteTask_ThenFalseAndFilled() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssert(sut.description == description3)
        
        // ACT:
        sut.unDoCompleteTask()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil((sut.achievedDate))
    }
    
    func test_undoCompleteTask_WhenCompletedFalse_ThenFalseAndNil() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssert(sut.description == description3)
        XCTAssertFalse(sut.completed, "Expected false, got \(sut.completed)")
        
        // ACT:
        sut.unDoCompleteTask()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
     
    func test_updateTask() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssert(sut.description == description3)
        
        // ACT:
        sut.unDoCompleteTask()
        
        // ASSERT:
        XCTAssertNotNil((sut.achievedDate != nil))
    }
    
    func makeSut() -> Task {
      var sut = Task(description: description1, completed: false, creationDate: Date(), achievedDate: nil)
        return sut
    }
}
