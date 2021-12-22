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
       // var sut = Goal.init(tasks: [], goalDescription: "")
        XCTAssertEqual(sut.goalDescription, "")
        XCTAssertTrue(sut.completed)
    }
    
    func test_addTask() {
        var sut = Goal(tasks: [], goalDescription:"")
        XCTAssertEqual(sut.goalDescription, sut.goalDescription)
        XCTAssertFalse(sut.completed)
    }
    
    func test_completeGoal() {
        var sut = Goal(tasks: [], goalDescription:"")
       // XCTAssertNotNil(goalAchievedDate)
    }
}


