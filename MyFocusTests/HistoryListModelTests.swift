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
    // 1. :  input: array of 2 goals, first goal with year(creation Date) x, the second goal y(creation date). None of the goals has tasks, or is completed.
    
    // output:
  
    //----
    // month and year of year x
    // -----
    // Summary in the given year of x year  "From 1 goals 0 is completed"
//    -------
//    Exact date (day,mont, year) for goal ( year x)
    // -----
    // The title for Listelement = goal in year x, the type is goal
    //----
    // month and year of year y
    // -----
    // Summary in the given year of  year  "From 1 goals 0 is completed"
//    -------
//    Exact date (day,mont, year) for goal ( year y)
    // -----
    // The title for Listelement = goal in year y, the type is goal
    //sections:
    // [month and year of year x,   Exact date (day,mont, year) for goal ( year x), month and year of year y,  Exact date (day,mont, year) for goal ( year y)]
    // sectionRows:
    //[[ Summary in the given year of x year  "From 1 goals 0 is completed"],[The title for Listelement = goal in year x, the type is goal],[Summary in the given year of  year y "From 1 goals 0 is completed"],[The title for Listelement = goal in year y, the type is goal]]
    
    
    
   
    //  2. : input: array of 2 goals, first goal with year(creation Date) x, the second goal y(creation date). None of the goals has tasks, one is completed.
    
    // output:
  
    //----
    // month and year of year x
    // -----
    // Summary in the given year of x year  "From 1 goals 0 is completed"
//    -------
//    Exact date (day,mont, year) for goal ( year x)
    // -----
    // The title for Listelement = goal in year x, the type is goal
    //----
    // month and year of year y
    // -----
    // Summary in the given year of  year  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,mont, year) for goal ( year y)
    // -----
    // The title for Listelement = goal in year y, the type is goal
    //sections:
    // [month and year of year x,   Exact date (day,mont, year) for goal ( year x), month and year of year y,  Exact date (day,mont, year) for goal ( year y)]
    // sectionRows:
    //[[ Summary in the given year of x year  "From 1 goals 0 is completed"],[The title for Listelement = goal in year x, the type is goal],[Summary in the given year of  year y "From 1 goals 1 is completed"],[The title for Listelement = goal in year y, the type is goal]]
   
    
    
    //  3. : input: array of 2 goals, first goal with year(creation Date) x, the second goal y(creation date). None of the goals has tasks, both completed.
    
    // output:
  
    //----
    // month and year of year x
    // -----
    // Summary in the given year of x year  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,mont, year) for goal ( year x)
    // -----
    // The title for Listelement = goal in year x, the type is goal
    //----
    // month and year of year y
    // -----
    // Summary in the given year of  year  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,mont, year) for goal ( year y)
    // -----
    // The title for Listelement = goal in year y, the type is goal
    //sections:
    // [month and year of year x,   Exact date (day,mont, year) for goal ( year x), month and year of year y,  Exact date (day,mont, year) for goal ( year y)]
    // sectionRows:
    //[[ Summary in the given year of x year  "From 1 goals 1 is completed"],[The title for Listelement = goal in year x, the type is goal],[Summary in the given year of  year y "From 1 goals 1 is completed"],[The title for Listelement = goal in year y, the type is goal]]
   
    
    //  4. : input: array of 2 goals, first goal with month(creation Date) x, the second goal with month y(creation date). The months differ.
    
    // output:
  
    //----
    // month and year of month x
    // -----
    // Summary in the given month of x month and year  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,month, year) for goal ( month x)
    // -----
    // The title for Listelement = goal in month x, the type is goal
    //----
    // month and year of year y
    // -----
    // Summary in the given month of  month y  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,mont, year) for goal ( month y)
    // -----
    // The title for Listelement = goal in month y, the type is goal
    //sections:
    // [month and year of year x,   Exact date (day,mont, year) for goal ( month x), month and year of year y,  Exact date (day,mont, year) for goal ( month y)]
    // sectionRows:
    //[[ Summary in the given month of x month  "From 1 goals 1 is completed"],[The title for Listelement = goal in month x, the type is goal],[Summary in the given month of month y "From 1 goals 1 is completed"],[The title for Listelement = goal in month y, the type is goal]]
   
    
    //  5. : input: array of 2 goals, first goal with month(creation Date) x, the second goal with month y(creation date). The months differ, the year is the same.
    
    // output:
  
    //----
    // month(i.e.: June) and year of x
    // -----
    // Summary in the given month of x month and year  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,month, year) for goal ( year and month of x)
    // -----
    // The title for Listelement = goal in month x, the type is goal
    //----
    // month(i.e.: July) and year of year y
    // -----
    // Summary in the given month of  month y  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,mont, year) for goal ( year and month of  y)
    // -----
    // The title for Listelement = goal in month and year of  y, the type is goal
    //sections:
    // [month and year of year x,   Exact date (day,mont, year) for goal ( year x), month and year of year y,  Exact date (day,mont, year) for goal ( year y)]
    // sectionRows:
    //[[ Summary in the given year and month of x month  "From 1 goals 1 is completed"],[The title for Listelement = goal in month and year x, the type is goal],[Summary in the given year and month of month y "From 1 goals 1 is completed"],[The title for Listelement = goal in month and year y, the type is goal]]
    
    
    //  6. : input: array of 2 goals, first goal with year and month(creation Date) for x with tasks, the second goal with year and month for y(creation date) with tasks.
    
    // output:
  
    //----
    // month and year of x
    // -----
    // Summary in the given month of x month and year  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,month, year) for goal and tasks ( year and month of x)
    // -----
    // The title for Listelement = goal in month x, the type is goal
    //----
    // month and year of year y
    // -----
    // Summary in the given month of  month y  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,month, year) for goal  and tasks( year and month of y)
    // -----
    // The title for Listelement = goal in month and year of  y, the type is goal
    //sections:
    // [month and year of year x,   Exact date (day,mont, year) for goal ( year x), month and year of year y,  Exact date (day,mont, year) for goal ( year y)]
    // sectionRows:
    //[[ Summary in the given year and month of x month  "From 1 goals 1 is completed"],[The title for Listelement = goal with tasks in month and year x, the type is goal],[Summary in the given year and month of month y "From 1 goals 1 is completed"],[The title for Listelement = goal with tasks in month and year y, the type is goal]]
   
    //  7. : input: array of 2 goals, first goal with year and month(creation Date) for x with tasks, the second goal with year and month for y(creation date) with  no tasks.
    
    // output:
  
    //----
    // month and year of x
    // -----
    // Summary in the given month of x month and year  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,month, year) for goal and tasks ( year and month of x)
    // -----
    // The title for Listelement = goal in month x, the type is goal
    //----
    // month and year of year y
    // -----
    // Summary in the given month of  month y  "From 1 goals 1 is completed"
//    -------
//    Exact date (day,month, year) for goal( year and month of y)
    // -----
    // The title for Listelement = goal in month and year of  y, the type is goal
    //sections:
    // [month and year of year x,   Exact date (day,mont, year) for goal ( year x), month and year of year y,  Exact date (day,mont, year) for goal ( year y)]
    // sectionRows:
    //[[ Summary in the given year and month of x month  "From 1 goals 1 is completed"],[The title for Listelement = goal with tasks in month and year x, the type is goal],[Summary in the given year and month of month y "From 1 goals 1 is completed"],[The title for Listelement = goal in month and year y, the type is goal]]
   
    
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



