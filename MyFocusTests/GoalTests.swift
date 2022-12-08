//
//  GoalTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 14/12/2021.
//

import XCTest

@testable import MyFocus

class GoalTests: XCTestCase {
    
    enum TestTitles: String {
        case testGoaltitle = "Finish the book"
        case testGoaltitle2 = "Go jogging"
        case tasktitle1 = "Take a walk"
        case tasktitle2 = "Go grocery shopping"
        case tasktitle3 = "Shop fot the birthday present"
        case tasktitle4 = "Call your best friend"
        
    }
    
   
    func test_initGoal() {
        
        var sut =  makeSut()
        XCTAssertEqual(sut.title, TestTitles.testGoaltitle.rawValue)
        XCTAssertFalse(sut.completed)
        XCTAssertEqual(sut.tasks.count, 0)
        XCTAssertNil(sut.achievedDate)
        XCTAssertGreaterThan(Date(), sut.creationDate)
        
    }
    
    func test_initGoalWithUncomletedTask() {
        
        var sut = makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        XCTAssertEqual(sut.title, TestTitles.testGoaltitle.rawValue)
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
        XCTAssertGreaterThan(Date(), sut.creationDate)
        
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertEqual(sut.tasks[0].title,TestTitles.tasktitle1.rawValue)
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertNil(sut.tasks[0].achievedDate)
    }
    
    
    func test_initGoalWithTasks() {
        
        let testTasks = [Task(id: UUID(), title: TestTitles.tasktitle1.rawValue, completed: true, creationDate: Date(), achievedDate: Date())]
        var sut =  makeSut(tasks: testTasks, title: TestTitles.testGoaltitle2.rawValue)
        XCTAssertEqual(sut.title, TestTitles.testGoaltitle2.rawValue)
        XCTAssertFalse(sut.completed)
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertNil(sut.achievedDate)
        XCTAssertGreaterThan(Date(), sut.creationDate)
    }
    
    func test_addTaskSuccess() {
        
        var sut = makeSut()
        sut.addTask(title: TestTitles.tasktitle3.rawValue)
        XCTAssertEqual(sut.title, TestTitles.testGoaltitle.rawValue)
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
        XCTAssertGreaterThan(Date(), sut.creationDate)
        
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertNotEqual(sut.tasks[0].title,TestTitles.tasktitle1.rawValue)
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertNil(sut.tasks[0].achievedDate)
    }
    
    
    func test_addTask_WhenGoalCompleted_ThenSuccessAndGoalUnAchieved() {
        
        // ARRANGE:
        var sut = makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.completeTask(id: UUID())
        XCTAssertTrue(sut.completed)
        XCTAssertNotNil(sut.achievedDate)
        
        // ACT:
        sut.addTask(title: TestTitles.tasktitle2.rawValue)
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertEqual(sut.tasks.count, 2)
        XCTAssertNil(sut.achievedDate)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertFalse(sut.tasks[1].completed)
    }
    
    
    func test_completeGoal_WhenGoalWithoutTasks_ThenNoChange() {
        
        // ARRANGE:
        var sut =  makeSut()
        XCTAssertNil(sut.achievedDate)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    
    func test_completeGoal_WhenTaskIsNotAchieved_ThenCompleted() {
        
        // ARRANGE:
        var sut = makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.achievedDate)
        XCTAssertNotNil(sut.tasks[0].achievedDate)
    }
    
    
    func test_completeGoal_WhenMoreThanOneTasks_ThenAllCompleted() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.addTask(title: TestTitles.tasktitle2.rawValue)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.achievedDate)
        XCTAssertNotNil(sut.tasks[0].achievedDate)
        XCTAssertTrue(sut.tasks[1].completed)
        XCTAssertNotNil(sut.tasks[1].achievedDate)
    }
    
    
    func test_completeGoal_WhenMoreTasksButOneAchieved_ThenAllCompleted() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.addTask(title: TestTitles.tasktitle2.rawValue)
        sut.completeTask(id: UUID())
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertFalse(sut.tasks[1].completed)
        
        // ACT:
        sut.completeGoal()
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.achievedDate)
        XCTAssertNotNil(sut.tasks[0].achievedDate)
        XCTAssertTrue(sut.tasks[1].completed)
        XCTAssertNotNil(sut.tasks[1].achievedDate)
    }
    
    func test_completeGoal_WhenCompleteAllTasks_ThenGoalCompleted() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle3.rawValue)
        sut.addTask(title: TestTitles.tasktitle4.rawValue)
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertFalse(sut.tasks[1].completed)
        
        // ACT:
        sut.completeTask(id: UUID())
        XCTAssertFalse(sut.completed)
        sut.completeTask(id: UUID())
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.achievedDate)
        XCTAssertNotNil(sut.tasks[0].achievedDate)
        XCTAssertTrue(sut.tasks[1].completed)
        XCTAssertNotNil(sut.tasks[1].achievedDate)
    }
    
    
    func test_completeTask_WhenTheOnlyTaskCompleted_ThenGoalCompleted() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle3.rawValue)
        XCTAssertFalse(sut.tasks[0].completed)
        
        // ACT:
        sut.completeTask(id: UUID())
        
        // ASSERT:
        XCTAssertTrue(sut.completed)
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.achievedDate)
    }
    
    
    func test_unDoCompleteGoal_WhenGoalIsWithoutTasks_ThenNoChange() {
        
        // ARRANGE:
        var sut =  makeSut()
        XCTAssertNil(sut.achievedDate)
        XCTAssertFalse(sut.completed)
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_unDoCompleteGoal_WhenJustOneTask_ThenNoChange() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        
        
        // ACT:
        sut.undoCompleteGoal()
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertNil(sut.tasks[0].achievedDate)
        XCTAssertNil(sut.achievedDate)
    }
    
    
    func test_undoCompleteGoal_WhenOnlyOneTaskIsCompleted_ThenNoChange() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.addTask(title: TestTitles.tasktitle2.rawValue)
        sut.completeTask(id: UUID())
        
        
        // ACT:
        sut.undoCompleteGoal()
        
        
        // ASSERT:
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.tasks[0].achievedDate)
        XCTAssertFalse(sut.tasks[1].completed)
        XCTAssertNil(sut.tasks[1].achievedDate)
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    
    func test_undoCompleteGoal_WhenOneTaskIsCompletedAndGoalIsCompleted_ThenOnOneTaskNoChange() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.addTask(title: TestTitles.tasktitle2.rawValue)
        sut.completeTask(id: UUID())
        sut.completeGoal()
        
        
        // ACT:
        sut.undoCompleteGoal()
        
        
        // ASSERT:
        XCTAssertTrue(sut.tasks[0].completed)
        XCTAssertNotNil(sut.tasks[0].achievedDate)
        XCTAssertFalse(sut.tasks[1].completed)
        XCTAssertNil(sut.tasks[1].achievedDate)
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    func test_undoCompleteGoal_WhenGoalIsCompleted_ThenSuccess() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.completeGoal()
        
        
        // ACT:
        sut.undoCompleteGoal()
        
        
        // ASSERT:
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertNil(sut.tasks[0].achievedDate)
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
   
    
    func test_deleteTask_success() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        XCTAssertFalse(sut.tasks[0].completed)
        
        // ACT:
        sut.deleteTask(id: UUID())
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
        XCTAssertEqual(sut.tasks.count, 0)
    }
    
    func test_deleteTask_WhenMoreTasksAreDeleted_ThenSuccess() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.addTask(title: TestTitles.tasktitle2.rawValue)
        
        // ACT:
        sut.deleteTask(id: UUID())
        sut.deleteTask(id: UUID())
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
        XCTAssertEqual(sut.tasks.count, 0)
    }
    
    
    func test_deleteTask_WhenNoTask_ThenNoChange() {
        
        // ARRANGE:
        var sut =  makeSut()
        
        
        // ACT:
        sut.deleteTask(id: UUID())
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
        XCTAssertEqual(sut.tasks.count, 0)
    }
    
    func test_undoCompleteTask_success() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.completeTask(id: UUID())
        XCTAssertTrue(sut.tasks[0].completed)
        
        // ACT:
        sut.undoCompleteTask(id: UUID())
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.tasks[0].achievedDate)
        XCTAssertFalse(sut.tasks[0].completed)
    }
    
    
    func test_undoCompleteTask_WhenGoalCompleted_ThenBothUnAchieved() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.completeGoal()
        XCTAssertTrue(sut.tasks[0].completed)
        
        // ACT:
        sut.undoCompleteTask(id: UUID())
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.tasks[0].achievedDate)
        XCTAssertFalse(sut.tasks[0].completed)
    }
   
    
    func test_undoCompleteTask_WhenTaskUnAchieved_ThenNoChange() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        
        
        // ACT:
        sut.undoCompleteTask(id: UUID())
        
        // ASSERT:
        XCTAssertNil(sut.achievedDate)
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertNil(sut.tasks[0].achievedDate)
    }
    
    func test_undoCompleteTask_WhenNoTask_ThenNoChange() {
        
        // ARRANGE:
        var sut =  makeSut()
        
        // ACT:
        sut.undoCompleteTask(id: UUID())
        
        // ASSERT:
        XCTAssertNil(sut.achievedDate)
    }
    
    
    func test_updateTask_WhenTaskisUpdatedAndNotCompleted_ThenSuccess() {
        
        // ARRANGE:
        var sut =  makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        
        
        // ACT:
        sut.updateTask(id: UUID(), title: TestTitles.tasktitle2.rawValue)
        
        
        // ASSERT:
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.tasks[0].achievedDate)
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertEqual(sut.tasks[0].title, TestTitles.tasktitle2.rawValue)
    }
    
    
    func test_updateTask_WhenSecondTaskisUpdatedAndNotCompleted_ThenSuccess() {
        
        // ARRANGE:
        var sut = makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.addTask(title: TestTitles.tasktitle2.rawValue)
        
        // ACT:
        sut.updateTask(id: UUID(), title: TestTitles.tasktitle3.rawValue)
        
        
        // ASSERT:
        XCTAssertEqual(sut.tasks.count, 2)
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.tasks[1].achievedDate)
        XCTAssertFalse(sut.tasks[1].completed)
        XCTAssertEqual(sut.tasks[1].title, TestTitles.tasktitle3.rawValue)
        XCTAssertEqual(sut.tasks[0].title, TestTitles.tasktitle1.rawValue)
        XCTAssertFalse(sut.tasks[0].completed)
    }
    
    
    func test_updateTask_WhenGoalAchieved_ThenGoalUnAchieved() {
        
        // ARRANGE:
        var sut = makeSut()
        sut.addTask(title: TestTitles.tasktitle1.rawValue)
        sut.completeGoal()
        
        
        // ACT:
        sut.updateTask(id: UUID(), title: TestTitles.tasktitle2.rawValue)
        
        
        // ASSERT:
        XCTAssertEqual(sut.tasks.count, 1)
        XCTAssertFalse(sut.tasks[0].completed)
        XCTAssertNil(sut.achievedDate)
        XCTAssertFalse(sut.completed)
    }
    
    func test_updateTask_WhenNoTasks_ThenNoChange() {
        
        // ARRANGE:
        var sut = makeSut()
        
        // ACT:
        sut.updateTask(id: UUID(), title: TestTitles.tasktitle1.rawValue)
        
        
        // ASSERT:
        XCTAssertFalse(sut.completed)
        XCTAssertNil(sut.achievedDate)
    }
    
    
    func makeSut(tasks: [Task] = [], title: String = TestTitles.testGoaltitle.rawValue) -> Goal {
        var sut = Goal(id: UUID(), tasks: tasks, title: title, creationDate: Date())
        
        return sut
    }
}


