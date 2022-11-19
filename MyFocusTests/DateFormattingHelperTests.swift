//
//  DateFormattingHelperTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 19/11/2022.
//


import XCTest

@testable import MyFocus


class DateFormattingHelperTests: XCTest {
    
    var dateFormatterHelper = DateFormattingHelper()
    
    
    func test_init_hasNoEffectDateFormattingHelper() {
        
        // ARRANGE, ACT:
        
    let sut = DateFormattingHelper()
        
        // ASSERT:
        
        XCTAssertNotNil(sut.makeFormattedExactDate(date: Date()))
        XCTAssertNotNil(sut.makeFormattedSummaryDate(date: Date()))
        
        
    }
    
    func test_sectionsNotEqual() {
        
        // ARRANGE, ACT:
        
    let sut = DateFormattingHelper()
        
        // ASSERT:
        
        XCTAssertNotEqual(sut.makeFormattedExactDate(date: Date()), sut.makeFormattedSummaryDate(date: Date()))
        
    }
}
