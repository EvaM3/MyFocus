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
   

}
