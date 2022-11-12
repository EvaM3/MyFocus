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
    
    func test_twoGoals_NoTasksNotCompleted_ThenSuccess() {
        
        // ARRANGE:
        
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let firstDate = Date(timeIntervalSince1970: 0.0)
        let secondDate = Date(timeIntervalSinceReferenceDate: 0.0)
        let firstGoal = Goal(id: UUID(), tasks: [], title: "A", completed: false, creationDate:firstDate, achievedDate: Date())
        let secondGoal = Goal(id: UUID(), tasks: [], title: "B", completed: false, creationDate: secondDate, achievedDate: Date())
        let arrayOfGoals = [firstGoal,secondGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        let expectedSections = ["01/2001", "01 01, 2001", "01/1970", "01 01, 1970"]
        let expectedSectionRows = [[ListElement(summary: "From 1 goals 0 is completed")],
                                   [ListElement(from: secondGoal)],
                                   [ListElement(summary: "From 1 goals 0 is completed")],
                                   [ListElement(from: firstGoal)]]
        
        
        // ACT:
        
        sut.loadData()
        
        
        // ASSERT:
        
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
        
    }
    
    
    
    func test_twoGoals_withDifferentMonths() {
        
        
        // ARRANGE:
        
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let firstMonth = Date(timeIntervalSince1970: 0.0)
        let secondMonth = Date(timeIntervalSince1970: +2714400.0)
        let firstGoal = Goal(id: UUID(), tasks: [], title: "A", completed: false, creationDate:firstMonth, achievedDate: Date())
        let secondGoal = Goal(id: UUID(), tasks: [], title: "B", completed: false, creationDate: secondMonth, achievedDate: Date())
        let arrayOfGoals = [firstGoal,secondGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        let expectedSections = ["02/1970", "01 02, 1970", "01/1970", "01 01, 1970"]
        let expectedSectionRows = [[ListElement(summary: "From 1 goals 0 is completed")],
                                   [ListElement(from: secondGoal)],
                                   [ListElement(summary: "From 1 goals 0 is completed")],
                                   [ListElement(from: firstGoal)]]
        
        
        // ACT:
        
        sut.loadData()
        
        
        // ASSERT:
        
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertNotEqual(firstGoal.creationDate, secondGoal.creationDate)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
        
    }
    
    
    
    func test_WhenYearAndMonthIsTheSameThenSuccess() {
        
        
        // ARRANGE:
        
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let firstWeek = Date(timeIntervalSince1970: 0.0)
        let secondWeek = firstWeek.adding(week: 1)
        let firstGoal = Goal(id: UUID(), tasks: [], title: "A", completed: false, creationDate:firstWeek, achievedDate: Date())
        let secondGoal = Goal(id: UUID(), tasks: [], title: "B", completed: false, creationDate: secondWeek, achievedDate: Date())
        let arrayOfGoals = [firstGoal,secondGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        // Expected values
        let expectedSections = ["01/1970", "08 01, 1970", "01 01, 1970"]
        let expectedSectionRows = [[ListElement(summary: "From 2 goals 0 is completed")],
                                   [ListElement(from: secondGoal)],
                                   [ListElement(from: firstGoal)]]
        
        // ACT:
        
        sut.loadData()
        
        
        
        // ASSERT:
        
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertNotEqual(firstGoal.creationDate, secondGoal.creationDate)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
        
    }
    
    
    func test_NoTasksOneGoalCompleted() {
        
        // ARRANGE:
        
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let firstMonth = Date(timeIntervalSince1970: 0.0)
        let secondMonth = firstMonth.adding(month: 1)
        let firstGoal = Goal(id: UUID(), tasks: [], title: "A", completed: true, creationDate:firstMonth, achievedDate: Date())
        let secondGoal = Goal(id: UUID(), tasks: [], title: "B", completed: false, creationDate: secondMonth, achievedDate: Date())
        let arrayOfGoals = [firstGoal,secondGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        let expectedSections = ["02/1970", "01 02, 1970", "01/1970", "01 01, 1970"]
        let expectedSectionRows = [[ListElement(summary: "From 1 goals 0 is completed")],
                                   [ListElement(from: secondGoal)],
                                   [ListElement(summary: "From 1 goals 1 is completed")],
                                   [ListElement(from: firstGoal)]]
        
        // ACT:
        
        sut.loadData()
        
        
        // ASSERT:
        
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertNotEqual(firstGoal.creationDate, secondGoal.creationDate)
        XCTAssertNotEqual(firstGoal.completed, secondGoal.completed)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
    }
    
    
    
    
    func test_ThreeGoalsNoTasksAllCompletedTwoInTheSameMonthAndYear() {
        
        // ARRANGE:
        
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let firstMonth = Date(timeIntervalSince1970: 0.0)
        let secondMonthFirstWeek = firstMonth.adding(month: 1)
        let secondMonthSecondWeek  = secondMonthFirstWeek.adding(week: 1)
        let firstGoal = Goal(id: UUID(), tasks: [], title: "A", completed: true, creationDate:firstMonth, achievedDate: Date())
        let secondGoal = Goal(id: UUID(), tasks: [], title: "B", completed: true, creationDate: secondMonthFirstWeek, achievedDate: Date())
        let thirdGoal = Goal(id: UUID(), tasks: [], title: "C", completed: true, creationDate: secondMonthSecondWeek, achievedDate: Date())
        let arrayOfGoals = [firstGoal,secondGoal,thirdGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        let expectedSections = ["02/1970", "08 02, 1970", "01 02, 1970", "01/1970", "01 01, 1970"]
        let expectedSectionRows = [[ListElement(summary: "From 2 goals 2 is completed")],
                                   [ListElement(from: thirdGoal)],
                                   [ListElement(from: secondGoal)],
                                   [ListElement(summary: "From 1 goals 1 is completed")],
                                   [ListElement(from: firstGoal)]]
        
        
        // ACT:
        
        sut.loadData()
        
        // ASSERT:
        
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
        
    }
    
    
    func test_firstGoalWithOneTaskSecondWithTwoTasks() {
        
        
        // ARRANGE:
        
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let firstDate = Date(timeIntervalSince1970: 0.0)
        let secondDate = firstDate.adding(month: 1)
        let firstGoalFirstTask = Task(id: UUID(), title: "Task A", completed: false, creationDate: firstDate)
        let firstGoal = Goal(id: UUID(), tasks: [firstGoalFirstTask], title: "First", completed: true, creationDate:firstDate, achievedDate: Date())
        let secondGoalFirstTask = Task(id: UUID(), title: "Task B1", completed: false, creationDate: secondDate)
        let secondGoalSecondTask = Task(id: UUID(), title: "Task B1", completed: false, creationDate: secondDate)
        let secondGoal = Goal(id: UUID(), tasks: [secondGoalFirstTask, secondGoalSecondTask], title: "Second", completed: true, creationDate: secondDate, achievedDate: Date())
        let arrayOfGoals = [firstGoal,secondGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        let expectedSections = ["02/1970", "01 02, 1970", "01/1970", "01 01, 1970"]
        let expectedSectionRows =  [[ListElement(summary: "From 1 goals 1 is completed")],
                                    [ListElement(from: secondGoal), ListElement(from: secondGoalFirstTask), ListElement(from:
                                                                                                                            secondGoalSecondTask)],
                                    [ListElement(summary: "From 1 goals 1 is completed")],
                                    [ListElement(from: firstGoal), ListElement(from: firstGoalFirstTask)]]
        
        
        
        // ACT:
        
        sut.loadData()
        
        // ASSERT:
        
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
        
        
    }
    
    
    
    
    
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
    
    
    func test_firstGoalWithThreeTasksAllCompletedSecondWithNoTasksNotCompleted() {
        
        // setting up the input values
        // ARRANGE:
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let firstDate = Date(timeIntervalSince1970: 0.0)
        let secondDate = firstDate.adding(month: 1)
        let firstGoalFirstTask = Task(id: UUID(), title: "Task A", completed: true, creationDate: firstDate)
        let firstGoalSecondTask = Task(id: UUID(), title: "Task B", completed: true, creationDate: firstDate)
        let firstGoalThirdTask = Task(id: UUID(), title: "Task C", completed: true, creationDate: firstDate)
        let firstGoal = Goal(id: UUID(), tasks: [firstGoalFirstTask,firstGoalSecondTask,firstGoalThirdTask], title: "First", completed: true, creationDate:firstDate, achievedDate: Date())
        let secondGoal = Goal(id: UUID(), tasks: [], title: "Second", completed: false, creationDate: secondDate, achievedDate: Date())
        let arrayOfGoals = [firstGoal,secondGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        let expectedSections = ["02/1970", "01 02, 1970", "01/1970", "01 01, 1970"]
        let expectedSectionRows =  [[ListElement(summary: "From 1 goals 0 is completed")],
                                    [ListElement(from: secondGoal)],
                                    [ListElement(summary: "From 1 goals 1 is completed")],
                                    [ListElement(from: firstGoal), ListElement(from: firstGoalFirstTask),ListElement(from: firstGoalSecondTask),ListElement(from: firstGoalThirdTask)]]
        
        
        
        // ACT:
        // Providing a method on the test subject
        sut.loadData()
        
        // ASSERT:
        // Verifying the outputs
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
        
        
    }
    
    
    
    
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
    // SectionRows:
    // [[Summary in the given year of x year  "From 1 goals 1 is completed"], [The title for Listelement = goal in year x, the type is goal,The title for Listelement = task 1 in  x, the type is task(not completed),The title for Listelement = task 2 in  x, the type is task(not completed)]]
    
    
    func test_GoalIsCompletedTasksNot() {
        
        
        // ARRANGE:
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let goalDate = Date(timeIntervalSince1970: 0.0)
        let testGoalFirstTask = Task(id: UUID(), title: "Task 1", completed: false, creationDate: goalDate)
        let testGoalSecondTask = Task(id: UUID(), title: "Task 2", completed: false, creationDate: goalDate)
        let testGoal = Goal(id: UUID(), tasks: [testGoalFirstTask,testGoalSecondTask], title: "First", completed: true, creationDate:goalDate, achievedDate: Date())
        let arrayOfGoals = [testGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        let expectedSections = ["01/1970", "01 01, 1970"]
        let expectedSectionRows = [[ListElement(summary: "From 1 goals 1 is completed")],
                                   [ListElement(from: testGoal), ListElement(from: testGoalFirstTask), ListElement(from: testGoalSecondTask)]]
        
        
        // ACT:
        
        sut.loadData()
        
        // ASSERT:
        
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
        
        
    }
    
    
    
    
    
    
    
    
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
    
    
    
    func test_DifferentCreationDateforGoalAndTask() {
        
        // ARRANGE:
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let goalDate = Date(timeIntervalSince1970: 0.0)
        let taskDate = goalDate.adding(day: 1)
        let testGoalTask = Task(id: UUID(), title: "Task", completed: false, creationDate: taskDate)
        let testGoal = Goal(id: UUID(), tasks: [testGoalTask], title: "Goal", completed: true, creationDate:goalDate, achievedDate: Date())
        let arrayOfGoals = [testGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        let expectedSections = ["01/1970", "01 01, 1970"]
        let expectedSectionRows = [[ListElement(summary: "From 1 goals 1 is completed")],
                                   [ListElement(from: testGoal), ListElement(from: testGoalTask)]]
        
        
        
        // ACT:
        
        sut.loadData()
        
        
        // ASSERT:
        
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
        
    }
    
    
    
    
    
    
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
    
    
    
    func test_GoalWhereCreationAndAchievedDateDiffers() {
        
        // ARRANGE:
        
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let goalDate = Date(timeIntervalSince1970: 0.0)
        let achievedDate = goalDate.adding(day: 1)
        let testGoal = Goal(id: UUID(), tasks: [], title: "Goal", completed: true, creationDate:goalDate, achievedDate: achievedDate)
        let arrayOfGoals = [testGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        let expectedSections = ["01/1970", "01 01, 1970"]
        let expectedSectionRows = [[ListElement(summary: "From 1 goals 1 is completed")],
                                   [ListElement(from: testGoal)]]
        
        
        // ACT:
        
        sut.loadData()
        
        
        // ASSERT:
        
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
        
        
    }
    
    
    
    
    
    
    // MARK: - Today's test
    
    // 11: Input is one goal, the date is today. The goal is not completed.
    
    // output:
    
    // month and year of month x
    // --------
    // Summary in the given month of x month  "From 1 goals 0 is completed"
    // --------
    //    Exact date (Today) for goal ( year and month x)
    // ---------
    // The title for Listelement = goal in today(Date()), the type is goal
    // ---------
    // Sections and sectionRows:
    // Sections:
    // [month and year of month x,Exact date (Today) for goal(creationDate) ( year and month x)]
    // Sectionrows:
    // [[Summary in the given month of x month  "From 1 goals 0 is completed"],[The title for Listelement = goal in today(Date()), the type is goal]]
    
    
    func test_todaysDateGoalNotCompleted() {
        
        // ARRANGE:
        
        let dataSpy = DataManagerSpy()
        let sut = HistoryListModel(dataManager: dataSpy)
        let goalDate = Date()
        let testGoal = Goal(id: UUID(), tasks: [], title: "Goal", completed: false, creationDate:goalDate, achievedDate: Date())
        let arrayOfGoals = [testGoal]
        dataSpy.stubbedGoals = arrayOfGoals
        let expectedSections = ["11/2022", "Today"]
        let expectedSectionRows = [[ListElement(summary: "From 1 goals 0 is completed")],
                                   [ListElement(from: testGoal)]]
        
        // ACT:
        
        sut.loadData()
        
        
        // ASSERT:
        
        XCTAssertTrue(dataSpy.invokedLoadGoal)
        XCTAssertEqual(sut.sections, expectedSections)
        XCTAssertEqual(sut.sectionRows, expectedSectionRows)
        
        
    }
    
    
}


extension Date {
    
    func adding(day: Int) ->  Date {
        Calendar(identifier: .gregorian).date(byAdding: .day, value: day, to: self)!
    }
    
    func adding(week: Int) -> Date {
        Calendar(identifier: .gregorian).date(byAdding: .day, value: week * 7, to: self)!
    }
    
    func adding(month: Int) -> Date {
        Calendar(identifier: .gregorian).date(byAdding: .month, value: month, to: self)!
    }
    
}
