//
//  GoalTests.swift
//  MyFocusTests
//
//  Created by Eva Sira Madarasz on 14/12/2021.
//

import XCTest
@testable import MyFocus

class GoalTests: XCTestCase {

   func test_initGoal() {
    var tasks: [Task]
    var goalDescription: String
    var completed: Bool
    var goalCreationDate: Date?
    var goalAchievedDate: Date?
    
    var sut = (tasks: [Task](),goalDescription: "Finish the essay", completed: true, goalCreationDate: Date(), goalAchievedDate: Date())
    XCTAssertEqual(sut.goalDescription, "Finish the essay")
    XCTAssertTrue(sut.completed, "Expected true, got \(sut.completed)")
    }
    }
   

