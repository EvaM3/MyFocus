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
        XCTAssertNotEqual(sut.description, description1)
        XCTAssertFalse(sut.completed, "Expected false, got \(sut.completed)")
    }
    
    func test_completeTask() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssert(sut.description == description3 )
        XCTAssertFalse(sut.completed, "Expected false, got\(sut.completed)")
        
        // ACT:
        sut.completeTask()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue((sut.achievedDate != nil))
    }
    
    func test_completeTask_WhenFalse_ThenNotNil() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssert(sut.description == description3)
        XCTAssertFalse(sut.completed, "Expected false, got\(sut.completed)")
        
        // ACT:
        sut.completeTask()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil((sut.achievedDate))
    }
    
    func test_completeTask_ThenTrueAndFilled() {
        
        // ARRANGE:
        var sut = makeSut()
        XCTAssert(sut.description == description3 )
        
        // ACT:
        sut.completeTask()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue((sut.achievedDate != nil))
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
    
    
    func test_WhenUndoCompleteTask_ThenTrueandNil() {
        
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
        XCTAssertFalse(sut.completed, "Expected false, got \(sut.completed)")
        
        // ACT:
        sut.unDoCompleteTask()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil((sut.achievedDate))
    }
    
    func test_undoCompleteTask_ThenFalseAndNil() {
        
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
      var sut = Task(description: "Learn Russian today", completed: false, creationDate: Date(), achievedDate: nil)
        return sut
    }
}
