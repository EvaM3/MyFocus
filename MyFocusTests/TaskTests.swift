//
//  TaskTests.swift
//  MyFocusTests
//
//  Created by Eva Sira Madarasz on 02/12/2021.
//

import XCTest
@testable import MyFocus

class TaskTests: XCTestCase {
    
    func test_init() {
        let sut = Task(description: "Buy a few books", completed: true, creationDate: Date(), achievedDate: Date())
        XCTAssert(sut.description == "Buy a few books")
        XCTAssertTrue(sut.completed, "Expected true, got \(sut.completed)")
        
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
    
    func test_completeTask() {
        // ARRANGE:
        var sut = Task(description: "Buy some flowers", completed: true, creationDate: Date(), achievedDate: Date())
        XCTAssert(sut.description == "Buy some flowers" )
        XCTAssertTrue(sut.completed, "Expected true, got\(sut.completed)")
        // ACT:
        sut.completeTask()
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssert((sut.achievedDate != nil))
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
}
