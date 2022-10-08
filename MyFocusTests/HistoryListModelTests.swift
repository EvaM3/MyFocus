//
//  HistoryListModelTest.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 15/09/2022.
//

import XCTest

@testable import MyFocus

class DataManagerSpy: CoreDataLoaderProtocol {
    
    var stubbedGoals: [Goal]!
    var invokedLoadGoal: Bool = false
    var invokedLoadGoalCount = 0
    var invokedLoadGoalParameter: NSPredicate? = nil
   
    
    func loadGoal(predicate: NSPredicate?) -> [Goal] {
        
        invokedLoadGoal = true
        invokedLoadGoalCount += 1
        invokedLoadGoalParameter = predicate
    
        
        return stubbedGoals
    }
    
    
}

class HistoryListModelTests: XCTestCase {
    
    func test_init_hasNoEffectHistoryListModel() {
        // ARRANGE, ACT:
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        
        // ASSERT:
        XCTAssertTrue(sut.sectionRows.isEmpty)
        XCTAssertTrue(sut.sections.isEmpty)
        XCTAssertFalse(dataSpy.invokedLoadGoal)
    }
    
    
    
    func test_loadData_calledMultiple_thenOutputIsSame() {
        // ARRANGE:
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let referenceDate =  Date(timeIntervalSince1970: 0.0)
        dataSpy.stubbedGoals = [Goal(tasks: [], title: "", creationDate: referenceDate)]
        let expectedSections = ["01/1970", "01 01, 1970"]
        
        
        // ACT:
        sut.loadData()
        let firstSectionRows =  sut.sectionRows
        XCTAssertEqual(expectedSections, sut.sections)
        sut.loadData()
        
    
        
        // ASSERT:
        XCTAssertEqual(dataSpy.invokedLoadGoalCount, 2)
        XCTAssertEqual(expectedSections, sut.sections)
        XCTAssertEqual(firstSectionRows, sut.sectionRows)
        
    }
    
    
    
    func test_loadData_withMultipeRows() {
        // ARRANGE:
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        dataSpy.stubbedGoals = [Goal(tasks: [], title: "", creationDate: Date())]
    
        
        // ACT:
        sut.loadData()
        let firstSectionRows =  sut.sectionRows
        let firstSections = sut.sections
        let secondSectionRows = sut.sectionRows
        let secondSections = sut.sections
        sut.loadData()
        
        // ASSERT:
        XCTAssertEqual(dataSpy.invokedLoadGoalCount, 2)
        XCTAssertEqual(firstSectionRows, secondSectionRows)
        XCTAssertEqual(firstSections,secondSections)
        
    }
    
    func test_twoGoals_inDifferentYears_notCompleted() {
        // ARRANGE:
        let dataSpy = DataManagerSpy()
        var firstDate = Calendar.current.date(byAdding: .year, value: -22, to: Date()) ?? Date() - 86400
        var secondDate = Calendar.current.date(byAdding: .year, value: -21, to: Date()) ?? Date() - 86400
        let sut = HistoryListModel(dataManager: dataSpy)
        dataSpy.stubbedGoals = [Goal(id: UUID(), tasks: [], title: "", completed: false, creationDate: firstDate, achievedDate: Date())]
        dataSpy.stubbedGoals = [Goal(id: UUID(), tasks: [], title: "", completed: false, creationDate: secondDate, achievedDate: Date())]
        
        
        // ACT:
        sut.loadData()
        
        // ASSERT:
        XCTAssertNotEqual(firstDate, secondDate)
        XCTAssertEqual(dataSpy.invokedLoadGoalCount, 1)
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        
    }
    
    func test_twoGoals_in2020and2021_notCompleted() {
        // ARRANGE:
        let dataSpy = DataManagerSpy()
        var firstDate = Calendar.current.date(byAdding: .year, value: -2, to: Date()) ?? Date() - 86400
        var secondDate = Calendar.current.date(byAdding: .year, value: -1, to: Date()) ?? Date() - 86400
        let sut = HistoryListModel(dataManager: dataSpy)
        dataSpy.stubbedGoals = [Goal(id: UUID(), tasks: [], title: "", completed: false, creationDate: firstDate, achievedDate: Date())]
        dataSpy.stubbedGoals = [Goal(id: UUID(), tasks: [], title: "", completed: false, creationDate: secondDate, achievedDate: Date())]
        
        
        // ACT:
        sut.loadData()
        
        // ASSERT:
        XCTAssertNotEqual(firstDate, secondDate)
        XCTAssertEqual(dataSpy.invokedLoadGoalCount, 1)
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        
    }
    
    func test_twoGoals_oneIsCompleted() {
        // ARRANGE:
        let dataSpy = DataManagerSpy()
        var firstDate = Calendar.current.date(byAdding: .year, value: -2, to: Date()) ?? Date() - 86400
        var secondDate = Calendar.current.date(byAdding: .year, value: -1, to: Date()) ?? Date() - 86400
        let sut = HistoryListModel(dataManager: dataSpy)
        dataSpy.stubbedGoals = [Goal(id: UUID(), tasks: [], title: "", completed: true, creationDate: firstDate, achievedDate: Date())]
        dataSpy.stubbedGoals = [Goal(id: UUID(), tasks: [], title: "", completed: false, creationDate: secondDate, achievedDate: Date())]
        
        
        // ACT:
        sut.loadData()
        let firstGoal = dataSpy.stubbedGoals
        let secondGoal = dataSpy.stubbedGoals
        
        
        // ASSERT:
        XCTAssertNotEqual(firstDate, secondDate)
        XCTAssertEqual(dataSpy.invokedLoadGoalCount, 1)
      
        
       
        
    }
    
    
    
    }



