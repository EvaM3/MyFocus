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
        let goalID = UUID()  // add task
        let taskID = UUID()
        let testTasks = [Task(id: taskID, title: "", completed: false, creationDate: Date(), achievedDate: Date())]
        let firstGoal = Goal(id: goalID, tasks: testTasks, title: "", completed: false, creationDate: Date(), achievedDate: Date())
        
        // ACT:
        sut.createGoal(goal: firstGoal)
      
        
        // ASSERT:
        // Equality with result
        XCTAssertFalse(firstGoal.tasks.isEmpty)
        XCTAssertEqual(firstGoal.tasks.count, 1)
        XCTAssertFalse(firstGoal.completed)
        
    }
    
    func test_init_hasNoEffect() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT, ASSERT:
        
        XCTAssertTrue(sut.loadGoal().isEmpty)
    }
    
    func test_oneGoalCalledTwice() { // one goal, call twice the create goal
        
        // ARRANGE:
        let sut = makeSut()
        let goalID = UUID()
        let firstGoal = Goal(id: goalID, tasks: [], title: "", completed: false, creationDate: Date(), achievedDate: Date())
       
        
        // ACT:
        sut.createGoal(goal: firstGoal)
        sut.createGoal(goal: firstGoal)
        
        // ASSERT:
        let result = sut.loadGoal()
       
        XCTAssertEqual(result, [firstGoal])
       
    }
    
    func test_sameIdDifferentTitle() {
        
        // ARRANGE:
        let sut = makeSut()
        let goalID = UUID()
        let firstGoal = Goal(id: goalID, tasks: [], title: "", completed: false, creationDate: Date(), achievedDate: Date())
       let secondGoal = Goal(id: goalID, tasks: [], title: "Hi!", completed: false, creationDate: Date(), achievedDate: Date())
        
        // ACT:
        sut.createGoal(goal: firstGoal)
        sut.createGoal(goal: secondGoal)
        
        // ASSERT:
        let result = sut.loadGoal()
        XCTAssertEqual(result, [firstGoal])
    }
    
    func test_init_deleteHasNoEffect() {
        
        // ARRANGE:
        let sut = makeSut()
        
        // ACT, ASSERT:
        
        XCTAssertTrue(sut.loadGoal().isEmpty)
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
        
        XCTAssertEqual(sut.loadGoal(), [])
        
    }
    
    func test_twoGoalsCreatedOneDeleted() {
        
        // ARRANGE:
        let sut = makeSut()
        let firstGoalID = UUID()
        let firstGoal = Goal(id: firstGoalID, tasks: [], title: "", completed: false, creationDate: Date(), achievedDate: Date())
        let secondGoalID = UUID()
        let secondTestGoal = Goal(id: secondGoalID, tasks: [], title: "", completed: false, creationDate: Date(), achievedDate: Date())
        
        // ACT:
        sut.createGoal(goal: firstGoal)
        sut.createGoal(goal: secondTestGoal)
        sut.deleteGoal(id: firstGoalID)
        
        // ASSERT:
        let result = sut.loadGoal()
        XCTAssertEqual(result, [secondTestGoal])
     
        
    }
    
    func test_updateGoalInitialSuccess() {
        let sut = makeSut()
        let firstGoalID = UUID()
        let creationDate = Date()
        let firstGoal = Goal(id: firstGoalID, tasks: [], title: "", completed: false, creationDate: creationDate, achievedDate: nil)

        let updatedTestGoal = Goal(id: firstGoalID, tasks: [], title: "!", completed: true, creationDate: creationDate, achievedDate: Date() + 10)
        
        
        
        sut.createGoal(goal: firstGoal)
        sut.updateGoal(goal: updatedTestGoal)
        
        XCTAssertEqual(sut.loadGoal(), [updatedTestGoal])
    }
    
    /* Update goal unit cases:
    
    //  1. Initial success:
     
   Input(Arrange): - setting up sut
          - variable with new goal with creation Date, tasks and the completion is false
          - variable with same id, but updated data
     
          - (Act): - creating new goal
                   - updating with updated goal
     
  Output(Assert):  - load will be equal to the updated, one element only
        
    
     
     // 2. Update with no goal to update to:
     
     Input(Arrange): - setting up sut
     - variable with new goal with creation Date, tasks and the completion is false
     
     - (Act): - updating goal
     
     
     Output(Assert): - load will be equal to empty array
     
     
    // 3. Goal updated, no change in tasks = combine it with the first
     
     Input(Arrange): - setting up sut
                     - variable with new goal with creation Date, tasks and the completion is false
     
         - (Act): - creating goal
                  - updating created goal
     
     
     Output(Assert): - NotEqual: The goal does not match with the updated one
                     - Not completed: The updated goal is not completed
                     - Equal: The tasks are the same
            
    */
    
    
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
