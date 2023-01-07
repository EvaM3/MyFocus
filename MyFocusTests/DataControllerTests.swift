//
//  DataControllerTests.swift
//  MyFocusTests
//
//  Created by Eva Madarasz on 23/12/2022.
//

import XCTest
import CoreData

@testable import MyFocus



class DataControllerTests: XCTestCase {
    
    

    
    var testContainer: NSPersistentContainer!
    
    
    private func makeContainer() -> NSPersistentContainer {
    
        let container = NSPersistentContainer(name: "FocusData")
        
        clear(container: container)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }
    
    
    private func clear(container: NSPersistentContainer) {
        for store in container.persistentStoreCoordinator.persistentStores {
            let url = store.url!
            let type = NSPersistentStore.StoreType(rawValue: store.type)
            try! container.persistentStoreCoordinator.destroyPersistentStore(at: url, type: type, options: nil)
        }
        
    }
    
    override func setUp() {
        super.setUp()
        
        testContainer = makeContainer()
    
    }
    
    override func tearDown() {
        clear(container: testContainer)
        super.tearDown()
    }
    
    
    func test_createGoalInitialSuccess() {
        
        
        // ARRANGE:
        let sut = makeSut()
        let goalID = UUID()
        let firstGoal = Goal(id: goalID, tasks: [], title: "", completed: false, creationDate: Date(), achievedDate: Date())
        
        // ACT:
        sut.createGoal(goal: firstGoal)
      
        
        // ASSERT:
        let result = sut.loadGoal()
        XCTAssertEqual(result, [firstGoal])
        
    }
    
    func test_fromTwoGoalsOnlyOneGoalAdded() {
        
        // ARRANGE:
        let sut = makeSut()
        let goalID = UUID()
        let secondID = UUID()
        let firstGoal = Goal(id: goalID, tasks: [], title: "", completed: false, creationDate: Date(), achievedDate: Date())
        let secondGoal = Goal(id: secondID, tasks: [], title: "!", completed: false, creationDate: Date(), achievedDate: Date())
        
        // ACT:
        sut.createGoal(goal: firstGoal)
        
        // ASSERT:
        let result = sut.loadGoal()
        XCTAssertEqual(result, [firstGoal])
        
    }
    
    func test_createGoalWithTasks() {
        
        // ARRANGE:
        let sut = makeSut()
        let goalID = UUID()
        let taskID = UUID()
        let testTasks = [Task(id: taskID, title: "", completed: false, creationDate: Date(), achievedDate: Date())]
        let testGoal = Goal(id: goalID, tasks: testTasks, title: "", completed: false, creationDate: Date(), achievedDate: Date())
        
        
        // ACT:
        sut.createGoal(goal: testGoal)
        
        // ASSERT:
        let result = sut.loadGoal()
        XCTAssertFalse(testGoal.tasks.isEmpty)
        XCTAssertEqual(testGoal.tasks.count, 1)
    }
    
    func test_deleteGoalInitialSuccess() {
        
        // ARRANGE:
        let sut = makeSut()
        let goalID = UUID()
        let testGoal = Goal(id: goalID, tasks: [], title: "", completed: false, creationDate: Date(), achievedDate: Date())
        sut.createGoal(goal: testGoal)
        
        // ACT:
       
        sut.deleteGoal(id: goalID)
        sut.saveData()
        
        
        // ASSERT:
        
       XCTAssertNotNil(goalID)
        
    }
    
    
    func makeSut() -> CoreDataManager {
       let sut = CoreDataManager(persistentContainer: testContainer)
        
        return sut
    }
    
}

extension Goal: Equatable {
    public static func == (lhs: Goal, rhs: Goal) -> Bool {
        lhs.completed == rhs.completed &&
        lhs.id == rhs.id &&
        lhs.tasks == rhs.tasks &&
        lhs.title == rhs.title &&
        lhs.achievedDate == rhs.achievedDate &&
        lhs.creationDate == rhs.creationDate
    }
    
    
}

extension Task: Equatable {
    public static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.completed == rhs.completed &&
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.achievedDate == rhs.achievedDate &&
        lhs.creationDate == rhs.creationDate
    }
    
    
}
