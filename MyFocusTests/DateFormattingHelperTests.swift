//
//  DateFormattingHelperTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 19/11/2022.
//


import XCTest

@testable import MyFocus


class DateFormattingHelperTests: XCTest {
    
    
    
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
    
    
    func test_exactDateIsReferenceDate() {
        
        // ARRANGE, ACT:
        let sut = DateFormattingHelper()
        let referenceDate = sut.makeFormattedExactDate(date: Date())
        
        // ASSERT:
        
        XCTAssertEqual(referenceDate,sut.makeFormattedExactDate(date: Date()))
        
    }
    
    func test_summarySectionDate() {
        
        // ARRANGE, ACT:
        let sut = DateFormattingHelper()
        let summaryDate = "MM/yyyy"
        
        // ASSERT:
        XCTAssertEqual(summaryDate, sut.makeFormattedSummaryDate(date: Date()))
    }

    
}
