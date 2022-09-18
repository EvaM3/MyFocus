//
//  HistoryListModelTest.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 15/09/2022.
//

import XCTest

@testable import MyFocus

class HistoryListModelTests: XCTestCase {
  
    var sut =  HistoryListModel()
    let goal1 = "Train for the marathon"
    let goal2 = "Finish the letter"
    let goal3 = "Practice on the piano"
    
    
    func test_initHistoryListModel() {
        XCTAssertNotNil(sut.sectionRows)
        XCTAssertNotNil(sut.sections)
    }
    
    func test_mapGoal() {
        XCTAssertNotNil(sut.mapGoal)
        
    }
    
    func test_mapGoal_whenMappedthenSuccess() {
        XCTAssertNotNil(sut.mapGoal)
      
    }
    
    
    
}
