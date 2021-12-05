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
        let task = Task(description: "Buy a few books", completed: true, creationDate: Date(), achievedDate: Date())
        XCTAssert(task.description == "Buy a few books")
        XCTAssertTrue(task.completed, "Expected true, got \(task.completed)")
        
    }
    
    func test_undoCompletedTask() {
        var description: String
        var completed: Bool
        var creationDate: Date
        var achievedDate: Date?
        
        let undoTask = Task(description: "Learn Russian today", completed: false, creationDate: Date(), achievedDate: Date())
        XCTAssert(undoTask.description == "Learn Russian today")
        XCTAssertTrue(undoTask.completed, "Expected false, got \(undoTask.completed)")
    }
    
    func test_completeTask() {
        let completeTask = Task(description: "Buy some flowers", completed: true, creationDate: Date(), achievedDate: Date())
        XCTAssert(completeTask.description == "Buy some flowers" )
        XCTAssertTrue(completeTask.completed, "Expected true, got\(completeTask.completed)")
    }
}
