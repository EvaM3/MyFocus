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
    
    func test_init() {
        let sut = makeSut()
        XCTAssertNotEqual(sut.description, description1)
        XCTAssertFalse(sut.completed, "Expected false, got \(sut.completed)")
    }
    
    func test_completeTask() {
        // ARRANGE:
        var sut = Task(description: "Buy some flowers", completed: false, creationDate: Date(), achievedDate: Date())
        XCTAssert(sut.description == "Buy some flowers" )
        XCTAssertFalse(sut.completed, "Expected false, got\(sut.completed)")
        // ACT:
        sut.completeTask()
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue((sut.achievedDate != nil))
    }
    
    func test_completeTaskFalseAndNil() {
        // ARRANGE:
        var sut = Task(description: "Buy some flowers", completed: false, creationDate: Date(), achievedDate: Date())
        XCTAssert(sut.description == "Buy some flowers" )
        XCTAssertFalse(sut.completed, "Expected false, got\(sut.completed)")
        // ACT:
        sut.completeTask()
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_completeTaskTrueAndFilled() {
        // ARRANGE:
        var sut = Task(description: "Buy some flowers", completed: false, creationDate: Date(), achievedDate: Date())
        XCTAssert(sut.description == "Buy some flowers" )
        // ACT:
        sut.completeTask()
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue((sut.achievedDate != nil))
    }
    

    func test_undoCompletedTask() {
        // ARRANGE:
        var sut = Task(description: "Learn Russian today", completed: true, creationDate: Date(), achievedDate: Date())
        XCTAssert(sut.description == "Learn Russian today")
        XCTAssertTrue(sut.completed, "Expected true, got \(sut.completed)")
        // ACT:
        sut.unDoCompleteTask()
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    
    func test_undoCompleteTaskTrueandNil() {
        // ARRANGE:
        var sut = Task(description: "Learn Russian today", completed: true, creationDate: Date(), achievedDate: Date())
        XCTAssert(sut.description == "Learn Russian today")
        XCTAssertTrue(sut.completed, "Expected true, got \(sut.completed)")
        // ACT:
        sut.unDoCompleteTask()
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_undoCompleteTaskFalseAndFilled() {
        // ARRANGE:
        var sut = Task(description: "Learn Russian today", completed: false, creationDate: Date(), achievedDate: Date())
        XCTAssert(sut.description == "Learn Russian today")
        XCTAssertFalse(sut.completed, "Expected false, got \(sut.completed)")
        // ACT:
        sut.unDoCompleteTask()
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil((sut.achievedDate))
    }
    
    func test_undoCompleteTaskFalseAndNil() {
        // ARRANGE:
        var sut = Task(description: "Learn Russian today", completed: false, creationDate: Date(), achievedDate: Date())
        XCTAssert(sut.description == "Learn Russian today")
        XCTAssertFalse(sut.completed, "Expected false, got \(sut.completed)")
        // ACT:
        sut.unDoCompleteTask()
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
     
    func test_updateTask() {
        // ARRANGE:
        var sut = Task(description: "Learn Russian today", completed: false, creationDate: Date(), achievedDate: Date())
        XCTAssert(sut.description == "Learn Russian today")
        // ACT:
        sut.unDoCompleteTask()
        // ASSERT:
        XCTAssert((sut.achievedDate != nil))
    }
    
    func makeSut() -> Task {
      var sut = Task(description: "Learn Russian today", completed: false, creationDate: Date(), achievedDate: Date())
        return sut
    }
}
