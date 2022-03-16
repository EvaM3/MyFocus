//
//  TaskTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 02/12/2021.
//

import XCTest
@testable import MyFocus

class TaskTests: XCTestCase {
    
    let title1 = "Buy a few books"
    let title2 = "Buy some flowers"
   
    
    func test_init() {
        let sut = makeSut()
        XCTAssertEqual(sut.title, title1)
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
        XCTAssertEqual(date, sut.achievedDate)
    }
    

    func test_undoCompletedTask() {
        
        // ARRANGE:
        var sut = makeSut()
        sut.completeTask()
        
        // ACT:
        sut.unDoCompleteTask()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    
    func test_undoCompleteTask_WhenCompletedTrue_ThenSuccess() {
        
        // ARRANGE:
        var sut = makeSut()
        sut.completed = true
        
        // ACT:
        sut.unDoCompleteTask()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_undoCompleteTask_WhenAchievedDateisNotNil_ThenSuccess() {
        
        // ARRANGE:
        var sut = makeSut()
        sut.achievedDate = Date()
        
        // ACT:
        sut.unDoCompleteTask()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil((sut.achievedDate))
    }
    
    func test_undoCompleteTask_WhenTaskInitialized_ThenNoChange() {
        
        // ARRANGE:
        var sut = makeSut()
        
        // ACT:
        sut.unDoCompleteTask()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
     
    func test_updateTask() {
        
        // ARRANGE:
        var sut = makeSut()
        let originalDate = sut.creationDate
        
        
        // ACT:
        sut.updateTask(title: title2)
        
        // ASSERT:
        XCTAssertEqual(sut.title,title2)
        XCTAssertLessThan(originalDate, sut.creationDate)
    }
    
  
    
    
    func makeSut() -> Task {
      let sut = Task(title: title1, completed: false, creationDate: Date(), achievedDate: nil)
        return sut
    }
}
