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
    // MARK: - Goal date tests
    
    // 1. :  input: array of 2 goals, first goal with year(creation Date) x, the second goal y(creation date). None of the goals has tasks, or is completed.
    
    // output:
    
    //----
    // month and year of year x
    // -----
    // Summary in the given year of x year  "From 1 goals 0 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( year x)
    // -----
    // The title for Listelement = goal in year x, the type is goal
    //----
    // month and year of year y
    // -----
    // Summary in the given year of  year  "From 1 goals 0 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( year y)
    // -----
    // The title for Listelement = goal in year y, the type is goal
    //sections:
    // [month and year of year x,   Exact date (day,mont, year) for goal ( year x), month and year of year y,  Exact date (day,month, year) for goal ( year y)]
    // sectionRows:
    //[[ Summary in the given year of x year  "From 1 goals 0 is completed"],[The title for Listelement = goal in year x, the type is goal],[Summary in the given year of  year y "From 1 goals 0 is completed"],[The title for Listelement = goal in year y, the type is goal]]
    
    
    func test_twoGoals_NoTasksNotCompleted_ThenSuccess() {
        
        // ARRANGE:
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        // setting up the input values
        let firstDate = Date(timeIntervalSince1970: 0.0)
        let secondDate = Date(timeIntervalSinceReferenceDate: 0.0)
        let firstGoal = Goal(id: UUID(), tasks: [], title: "A", completed: false, creationDate:firstDate, achievedDate: Date())
        let secondGoal = Goal(id: UUID(), tasks: [], title: "B", completed: false, creationDate: secondDate, achievedDate: Date())
        let arrayOfGoals = [firstGoal,secondGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        // Expected values
        let expectedSections = [String]()
        let expectedSectionRows = [[ListElement]]()
        
        
        // ACT:
        // Providing a method on the test subject
        sut.loadData()
       
       
        
        
        // ASSERT:
        // Verifying the outputs
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertFalse(firstGoal.completed)
        XCTAssertFalse(secondGoal.completed)
        XCTAssertTrue(firstGoal.tasks.isEmpty)
        XCTAssertTrue(secondGoal.tasks.isEmpty)
      
        
    }
    
    //  2. : input: array of 2 goals, first goal with month(creation Date) x, the second goal with month y(creation date). The months differ.
    
    // output:
    
    //----
    // month and year of month x
    // -----
    // Summary in the given month of x month and year  "From 1 goals 0 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( month x)
    // -----
    // The title for Listelement = goal in month x, the type is goal
    //----
    // month and year of year y
    // -----
    // Summary in the given month of  month y  "From 1 goals 0 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( month y)
    // -----
    // The title for Listelement = goal in month y, the type is goal
    //sections:
    // [month and year of year x,   Exact date (day,month, year) for goal ( month x), month and year of year y,  Exact date (day,month, year) for goal ( month y)]
    // sectionRows:
    //[[ Summary in the given month of x month  "From 1 goals 1 is completed"],[The title for Listelement = goal in month x, the type is goal],[Summary in the given month of month y "From 1 goals 1 is completed"],[The title for Listelement = goal in month y, the type is goal]]
    
    
    func test_twoGoals_WhenNotInTheSameMonth_ThenSuccess() {
        
        // ARRANGE:
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let firstGoalSection = ["3/2022"]
        let secondGoalSection = ["8/2022"]
        
        // ACT:
        sut.loadData()
        
        // ASSERT:
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertNotEqual(firstGoalSection, secondGoalSection)
    }
    
    
    
    
    //  3. : input: array of 2 goals, first goal with month(creation Date) x, the second goal with month y(creation date).Year and month is the same.
    
    // output:
    
    //----
    // month and year of goal x.
    // -----
    // Summary in the given month of goal x (month and year)  "From 1 goals 0 is completed"
    // -----
    //    Exact date (day,month, year) for goal x
    //    -------
    // The title for Listelement = goal x in month x, the type is goal
    //----
    //    Exact date (day,month, year) for goal y
    //    -------
    // The title for Listelement = goal y in month y, the type is goal
    //----
    //  sections:
    // [month and year of goal x, Exact date (day,month, year) for goal x,   Exact date (day,month, year) for goal y]
    //  sectionRows:
    //[[Summary in the given month of goal x (month and year)  "From 1 goals 0 is completed"],[The title for Listelement = goal x in month x, the type is goal],[ The title for Listelement = goal y in month y, the type is goal]]
    
    
    // MARK: - Completion tests
    //  4. : input: array of 2 goals, first goal with year(creation Date) x, the second goal y(creation date). None of the goals has tasks, one is completed.
    
    // output:
    
    //----
    // month and year of year x
    // -----
    // Summary in the given year of x year  "From 1 goals 0 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( year x)
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
    // [month and year of year x,   Exact date (day,mont, year) for goal ( year x), month and year of year y,  Exact date (day,month, year) for goal ( year y)]
    // sectionRows:
    //[[ Summary in the given year of x year  "From 1 goals 0 is completed"],[The title for Listelement = goal in year x, the type is goal],[Summary in the given year of  year y "From 1 goals 1 is completed"],[The title for Listelement = goal in year y, the type is goal]]
    
    
    
    //  5. : input: array of 3 goals, first goal with year(creation Date) x, the second goal y(creation date). None of the goals has tasks, all of them completed and two of them in the same month and year.
    
    // output:
    
    //----
    // month and year of goal x
    // -----
    // Summary in the given year of x year  "From 1 goals 1 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( year and month x)
    // -----
    // The title for Listelement = goal in year x, the type is goal
    //----
    // month and year of year y
    // -----
    // Summary in the given year of goal  "From 2 goals 2 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( year and month y)
    // -----
    // The title for Listelement = goal in year y, the type is goal
    // -----
    //    Exact date (day,month, year) for goal ( year z)
    // -----
    // The title for Listelement = goal in year z, the type is goal
    //-------
    //Sections and sectionRows
    // sections:
    //  [month and year of goal x,  Exact date (day,month, year) for goal ( year and month x),month and year of year y, Exact date (day,month, year) for goal ( year and month y), Exact date (day,month, year) for goal ( year z)]
    //  sectionRows:
    // [[Summary in the given year of x year  "From 1 goals 1 is completed"],[The title for Listelement = goal in year x, the type is goal], [ Summary in the given year of goal  "From 2 goals 2 is completed"],[ The title for Listelement = goal in year y, the type is goal],[The title for Listelement = goal in year z, the type is goal]]
    
    // MARK: - Task tests
    
    
    //  6. : input: array of 2 goals, first goal with year and month(creation Date) for x with one task, the second goal with year and month for y(creation date) with two tasks.
    
    // output:
    
    //----
    // month and year of year x
    // -----
    // Summary in the given year of x year  "From 1 goals 1 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( year and month x)
    // ---------
    // The title for Listelement = goal in year x, the type is goal
    // -----
    // The title for Listelement = task 1 in  x, the type is task
    // -----
    // month and year of year y
    // -----
    // Summary in the given year of y year  "From 1 goals 1 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( year and month y)
    // ---------
    // The title for Listelement = goal in year y, the type is goal
    // -----
    // The title for Listelement = task 1 in  y, the type is task
    // -----
    // The title for Listelement = task 2 in  y, the type is task
    // -----
    
    // Sections and sectionRows
    // sections:
    // [month and year of year x,  Exact date (day,month, year) for goal ( year and month x), month and year of year y, Exact date (day,month, year) for goal ( year and month y)]
    //  sectionRows:
    // [[Summary in the given year of x year  "From 1 goals 1 is completed"],[The title for Listelement = goal in year x, the type is goal,The title for Listelement = task 1 in  x, the type is task],[ Summary in the given year of y year  "From 1 goals 1 is completed"],[The title for Listelement = goal in year y, the type is goal,The title for Listelement = task 1 in  y, the type is task, The title for Listelement = task 2 in  y, the type is task]]
    
    
    //  7. : input: array of 2 goals, first goal with year and month(creation Date) for x with three tasks, all of them completed. The second goal with year and month for y(creation date) with  no tasks and not completed.
    
    // output:
    
    // month and year of year x
    // -----
    // Summary in the given year of x year  "From 1 goals 1 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( year and month x)
    // ---------
    // The title for Listelement = goal in year x, the type is goal
    // -----
    // The title for Listelement = task 1 in  x, the type is task
    // -----
    // The title for Listelement = task 2 in  x, the type is task
    // -----
    // The title for Listelement = task 3 in  x, the type is task
    // -----
    // month and year of year y
    // -----
    // Summary in the given year of y year  "From 1 goals 0 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( year and month y)
    // ---------
    // The title for Listelement = goal in year y, the type is goal
    
    
    // Sections and sectionRows
    //  sections:
    // [ month and year of year x,  Exact date (day,month, year) for goal ( year and month x), month and year of year y,  Exact date (day,month, year) for goal ( year and month y)]
    //  sectionRows:
    // [[Summary in the given year of x year  "From 1 goals 1 is completed"],[ The title for Listelement = goal in year x, the type is goal,The title for Listelement = task 1 in  x, the type is task, The title for Listelement = task 2 in  x, the type is task,The title for Listelement = task 3 in  x, the type is task],[Summary in the given year of y year  "From 1 goals 0 is completed"],[ The title for Listelement = goal in year y, the type is goal]]
    
    
    // MARK: - Invalid state tests
    //  8. : goal is completed, but the tasks are not. In the summary no mention of the tasks.
    
    // output:
    
    // month and year of year x
    // -----
    // Summary in the given year of x year  "From 1 goals 1 is completed"
    //    -------
    //    Exact date (day,month, year) for goal ( year and month x)
    // ---------
    // The title for Listelement = goal in year x, the type is goal
    
    // The title for Listelement = task 1 in  x, the type is task(not completed)
    // --------
    // The title for Listelement = task 2 in  x, the type is task(not completed)
    
    // Sections and SectionRows
    // Sections:
    // [month and year of year x, Exact date (day,month, year) for goal ( year and month x)]
    // SectiionRows:
    // [[Summary in the given year of x year  "From 1 goals 1 is completed"],[ The title for Listelement = goal in year x, the type is goal],[The title for Listelement = task 1 in  x, the type is task(not completed),The title for Listelement = task 2 in  x, the type is task(not completed)]]
    
    
    
    //  9. : The goal is on day A and the task(creationDate) is on day B. Section for day A includes the goal and the task.
    
    
    // output:
    
    // month and year of year A
    // --------
    // Summary in the given year of A year  "From 1 goals 1 is completed"
    // --------
    //    Exact date (day,month, year) for goal ( year and month A)
    // ---------
    // The title for Listelement = goal in day A, the type is goal
    // ---------
    // The title for Listelement = task 1 in day A, the type is task
    // ---------
    //  Sections and sectionrows
    // Sections:
    // [ month and year of year A, Exact date (day,month, year) for goal ( year and month A)]
    // SectionRows:
    //[[Summary in the given year of A year  "From 1 goals 1 is completed"], [The title for Listelement = goal in day A, the type is goal,The title for Listelement = task 1 in day A, the type is task]]
    
    
    
    //  10. : Input is one goal, where creationDate and achievedDate differs, but it still goes to the creationDate as completed(Goal) without task.
    
    // output:
    
    
    // month and year of year x
    // -----
    // Summary in the given year of x year  "From 1 goals 1 is completed"
    //    -------
    //    Exact date (day,month, year) for goal(creationDate) ( year and month x)
    // ---------
    // The title for Listelement = goal in year x, the type is goal
    // ---------
    
    // Sections and sectionRows:
    // Sections:
    // [month and year of year x,Exact date (day,month, year) for goal(creationDate) ( year and month x)]
    // Sectionrows:
    // [[Summary in the given year of x year  "From 1 goals 1 is completed"],[The title for Listelement = goal in year x, the type is goal]]
    
    
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



