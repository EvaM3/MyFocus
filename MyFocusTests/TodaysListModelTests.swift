//
//  TodaysListModelTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 07/12/2022.
//

import XCTest


@testable import MyFocus



class TodaysListModelTests: XCTestCase {


    

    func test_goalCreationSuccess()  {
        
    // ARRANGE, ACT:
    let sut = TodaysListModel()
    
    
       
        
        
    // ASSERT:
    XCTAssertFalse(((sut.todaysGoal?.tasks.isEmpty) != nil))
    XCTAssertFalse(((sut.todaysGoal?.completed) != nil))
      
        
        
    }
   
    func test_goalCreationNoGoal() {
       
    // ARRANGE:
        
        let sut = TodaysListModel()
        let noGoals = Goal(tasks: [], title: "", creationDate: Date())
        let noGoal = ""
        
        
     // ACT:
        
        sut.createGoal(with: noGoal)
        
        
    // ASSERT:
        
    
        XCTAssertFalse(((sut.todaysGoal?.tasks.isEmpty) != nil))
        XCTAssertFalse(((sut.todaysGoal?.completed) != nil))
        
        
    }
    
    func test_addTask() {
        
        // ARRANGE:
            
            let sut = TodaysListModel()
            let newTask = Task(id: UUID(), title: "Do something", completed: false, creationDate: Date())
            let taskAdded = Goal(tasks: [newTask], title: "", creationDate: Date())
        
        // ACT:
        sut.addTask(with: "")
        
        // ASSERT:
        
        XCTAssertNotNil(sut.addTask(with: ""))
    }
}
